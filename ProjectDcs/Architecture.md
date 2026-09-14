# Architecture - ksf_FA_Training

## Overview

This document describes the technical architecture for the Training Management module, including the layered architecture, component design, database schema, and integration patterns.

---

## 1. System Architecture

### 1.1 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                      │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐   │
│  │Dashboard│ │Programs│ │Courses │ │Enroll-  │   │
│  │  Page  │ │  Page  │ │  Page  │ │ments   │   │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘   │
│       │           │           │           │           │         │
│       └───────────┴───────────┴───────────┘           │
│                         │                             │
├─────────────────────────┼─────────────────────────────┤
│                    Service Layer                    │
│  ┌──────────────────────────────────────────────────┐  │
│  │              training_db.inc                    │  │
│  │   Database functions (CRUD operations)          │  │
│  └──────────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────────┐  │
│  │              training_ui.inc                     │  │
│  │   UI helper functions and display logic          │  │
│  └──────────────────────────────────────────────────┘  │
├──────────────────────────────────────────────────────┤
│                    Business Layer                   │
│  ┌──────────────────────────────────────────────────┐  │
│  │         TrainingContainer (DI Container)          │  │
│  │   - TrainingService                         │  │
│  │   - EmployeeService                     │  │
│  │   - DatabaseAdapter                   │  │
│  └──────────────────────────────────────────────────┘  │
├──────────────────────────────────────────────────────┤
│                    Data Layer                     │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐   │
│  │Programs │ │ Courses │ │Enroll-  │ │Sessions │   │
│  │  Table  │ │  Table  │ │ments   │ │  Table  │   │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘   │
├──────────────────────────────────────────────────────┤
│                  Integration Layer                  │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐              │
│  │FA CRM   │ │Employee │ │ksf-     │              │
│  │(Debtors)│ │  Mgmt   │ │Training │              │
│  └──────────┘ └──────────┘ └──────────┘              │
└─────────────────────────────────────────────────────┘
```

### 1.2 Module Structure

```
ksf_FA_Training/
├── FA_Training_Module.php      # Module class with permissions
├── hooks.php               # FA lifecycle hooks
├── training.php            # API controller
├── _init/
│   └── init.inc         # Module initialization
├── includes/
│   ├── import.php      # Import functionality
│   ├── TrainingContainer.php  # DI container & services
│   ├── training_db.inc # Database functions
│   └── training_ui.inc # UI helpers
├── pages/
│   ├── dashboard.php   # Dashboard view
│   ├── programs.php  # Program CRUD
│   ├── courses.php   # Course CRUD
│   ├── enrollments.php  # Enrollment management
│   ├── instructors.php # Instructor management
│   ├── schedule.php  # Session scheduling
│   ├── reports.php  # Reporting
│   └── settings.php # Settings
└── sql/
    ├── install.sql   # Schema creation
    └── uninstall.sql # Schema removal
```

---

## 2. Component Design

### 2.1 Core Components

#### TrainingContainer
The DI container provides service instantiation and dependency management.

**Purpose**: Central service locator implementing PSR-11 ContainerInterface

**Services Provided**:
- `DatabaseAdapterInterface` - FADatabaseAdapter
- `EmployeeServiceInterface` - FAEmployeeService
- `TrainingServiceInterface` / `TrainingService` - Core business logic
- `EventDispatcherInterface` - FAEventDispatcher (PSR-14)
- `LoggerInterface` - NullLogger (PSR-3)

**Responsibilities**:
- Service instantiation on demand
- Dependency injection into services
- Service lifecycle management

```php
class TrainingContainer implements ContainerInterface
{
    public function get(string $id): mixed
    public function has(string $id): bool
}
```

#### FADatabaseAdapter
Wraps FA database functions for use by services.

**Methods**:
```php
interface DatabaseAdapterInterface
{
    public function fetchAssoc(string $sql, array $params = []): ?array
    public function fetchAll(string $sql, array $params = []): array
    public function executeUpdate(string $sql, array $params = []): int
    public function lastInsertId(): string|false
}
```

#### FAEmployeeService
Provides employee data access.

**Methods**:
```php
interface EmployeeServiceInterface
{
    public function getEmployee(string $employeeId): array
    public function employeeExists(string $employeeId): bool
    public function getEmployeesByDepartment(string $department): array
}
```

#### FAEventDispatcher
Implements event-driven architecture.

**Methods**:
```php
interface EventDispatcherInterface
{
    public function dispatch(object $event): object
    public function addListener(string $eventName, callable $listener, int $priority = 0): void
    public function addSubscriber(EventSubscriberInterface $subscriber): void
}
```

### 2.2 Database Functions (training_db.inc)

Provides procedural database operations for CRUD.

#### Program Functions
- `get_training_programs($search, $status)` - List programs with filtering
- `get_training_program($programId)` - Get single program
- `insert_training_program($data)` - Create program
- `update_training_program($programId, $data)` - Update program
- `delete_training_program($programId)` - Delete program

#### Course Functions
- `get_training_courses($programId)` - List courses
- `get_training_course($courseId)` - Get single course
- `insert_training_course($data)` - Create course
- `update_training_course($courseId, $data)` - Update course

#### Enrollment Functions
- `get_training_enrollments($programId)` - List enrollments
- `get_enrollment($enrollmentId)` - Get single enrollment
- `get_employee_enrollments($employeeId)` - Get employee's enrollments
- `insert_enrollment($data)` - Create enrollment
- `update_enrollment($enrollmentId, $data)` - Update enrollment

#### Instructor Functions
- `get_training_instructors()` - List instructors
- `get_instructor($instructorId)` - Get single instructor
- `insert_instructor($data)` - Add instructor
- `update_instructor($instructorId, $data)` - Update instructor

#### Session Functions
- `get_training_sessions($programId)` - List sessions
- `insert_session($data)` - Create session

#### Category Functions
- `get_training_categories()` - List categories

### 2.3 UI Functions (training_ui.inc)

Provides presentation logic and helpers.

#### Navigation
- `training_navigation_menu()` - Main menu tabs

#### Display
- `display_training_dashboard_stats($stats)` - Dashboard statistics
- `display_enrollment_status($enrollments)` - Enrollment status display
- `display_session_calendar($sessions)` - Calendar view

#### Select Helpers
- `sel_training_status($selected)` - Status dropdown
- `sel_delivery_method($selected)` - Delivery method dropdown
- `sel_program($programs, $selected)` - Program dropdown
- `sel_category($categories, $selected)` - Category dropdown
- `sel_instructor($instructors, $selected)` - Instructor dropdown
- `sel_enrollment_status($selected)` - Enrollment status dropdown

#### Status Helpers
- `get_training_status_class($status)` - CSS class for status
- `get_enrollment_status_class($status)` - CSS class for enrollment status

---

## 3. Database Schema

### 3.1 Entity Relationship Diagram

```
┌─────────────────┐       ┌─────────────────┐
│   debtors_master │       │    employees    │
│      (FA CRM)   │       │   (FA HRM)      │
└────────┬────────┘       └────────┬────────┘
         │                         │
         │ 1:N                  │ 1:N
         ▼                      ▼
┌─────────────────────────────────────────────────────┐
│              fa_training_programs                    │
│ ┌────────────────────────────────────────────┐    │
│ │ program_id (PK)                         │    │
│ │ name                                  │    │
│ │ description                           │    │
│ │ program_type                         │    │
│ │ category_id (FK) ─────────────┐         │    │
│ │ duration_hours                 │    │    │
│ │ status                            │    │    │
│ │ delivery_method                 │    │    │
│ │ capacity                       │    │    │
│ │ certification_id (FK) ────���─���         │    │
│ │ created_at, updated_at                 │    │
│ └─────────────────────────────────────┘    │
└──────────────────────────┬────────────────────────┘
                         │ 1:N
                         ▼
┌─────────────────────────────────────────────────────┐
│              fa_training_courses                 │
│ ┌────────────────────────────────────────────┐    │
│ │ course_id (PK)                          │    │
│ │ program_id (FK) ──────────► programs      │    │
│ │ name                                   │    │
│ │ description                            │    │
│ │ objectives, outline                   │    │
│ │ instructor_id (FK) ──────────► employees    │    │
│ │ duration_hours                       │    │
│ │ delivery_method                    │    │
│ │ materials                         │    │
│ └─────────────────────────────────────┘    │
└──────────────────────────┬────────────────────────┘
                         │
                         │ 1:N
                         ▼
┌─────────────────────────────────────────────────────┐
│           fa_training_enrollments               │
│ ┌────────────────────────────────────────────┐    │
│ │ enrollment_id (PK)                       │    │
│ │ program_id (FK) ──────────► programs       │    │
│ │ employee_id (FK) ─────────► employees     │    │
│ │ enrollment_date                       │    │
│ │ status                              │    │
│ │ attendance_marked                   │    │
│ │ completion_date                   │    │
│ │ score                            │    │
│ │ certificate_issued               │    │
│ │ created_at, updated_at          │    │
│ └─────────────────────────────────────┘    │
└─────────────────────────────────────────────────────┘

┌─────────────────┐       ┌─────────────────┐
│  fa_categories  │       │    employees   │
│                │       │               │
└────────┬───────┘       └────────┬──────┘
        │ 1:N                 │
        ▼                     │ 1:N
┌─────────────────────────────────────┐
│         fa_training_programs         │
└─────────────────────────────────────┘
```

### 3.2 Table Details

#### fa_training_programs
```sql
CREATE TABLE `@TB_PREF@fa_training_programs` (
    `program_id` VARCHAR(20) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `program_type` VARCHAR(50) DEFAULT NULL,
    `category_id` INT(11) DEFAULT NULL,
    `duration_hours` DECIMAL(10,2) DEFAULT 0.00,
    `status` VARCHAR(30) DEFAULT 'Draft',
    `delivery_method` VARCHAR(30) DEFAULT 'Classroom',
    `capacity` INT(11) DEFAULT 0,
    `prerequisites` TEXT,
    `certification_id` INT(11) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`program_id`),
    KEY `idx_status` (`status`),
    KEY `idx_type` (`program_type`),
    KEY `idx_category` (`category_id`),
    CONSTRAINT `fk_program_category` FOREIGN KEY (`category_id`) 
        REFERENCES `@TB_PREF@fa_training_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### fa_training_courses
```sql
CREATE TABLE `@TB_PREF@fa_training_courses` (
    `course_id` VARCHAR(20) NOT NULL,
    `program_id` VARCHAR(20) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `objectives` TEXT,
    `outline` TEXT,
    `instructor_id` VARCHAR(100) DEFAULT NULL,
    `duration_hours` DECIMAL(10,2) DEFAULT 0.00,
    `delivery_method` VARCHAR(30) DEFAULT 'Classroom',
    `materials` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`course_id`),
    KEY `idx_program` (`program_id`),
    KEY `idx_instructor` (`instructor_id`),
    CONSTRAINT `fk_course_program` FOREIGN KEY (`program_id`) 
        REFERENCES `@TB_PREF@fa_training_programs` (`program_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### fa_training_enrollments
```sql
CREATE TABLE `@TB_PREF@fa_training_enrollments` (
    `enrollment_id` INT(11) NOT NULL AUTO_INCREMENT,
    `program_id` VARCHAR(20) NOT NULL,
    `employee_id` VARCHAR(100) NOT NULL,
    `enrollment_date` DATE NOT NULL,
    `status` VARCHAR(30) DEFAULT 'Enrolled',
    `attendance_marked` TINYINT(1) DEFAULT 0,
    `completion_date` DATE DEFAULT NULL,
    `score` DECIMAL(5,2) DEFAULT NULL,
    `certificate_issued` TINYINT(1) DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`enrollment_id`),
    UNIQUE KEY `uk_program_employee` (`program_id`, `employee_id`),
    KEY `idx_program` (`program_id`),
    KEY `idx_employee` (`employee_id`),
    KEY `idx_status` (`status`),
    CONSTRAINT `fk_enrollment_program` FOREIGN KEY (`program_id`) 
        REFERENCES `@TB_PREF@fa_training_programs` (`program_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### fa_training_instructors
```sql
CREATE TABLE `@TB_PREF@fa_training_instructors` (
    `instructor_id` VARCHAR(100) NOT NULL,
    `employee_id` VARCHAR(100) DEFAULT NULL,
    `specialization` VARCHAR(255) DEFAULT NULL,
    `bio` TEXT,
    `rating` DECIMAL(3,2) DEFAULT 3.00,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`instructor_id`),
    KEY `idx_employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### fa_training_sessions
```sql
CREATE TABLE `@TB_PREF@fa_training_sessions` (
    `session_id` VARCHAR(20) NOT NULL,
    `program_id` VARCHAR(20) NOT NULL,
    `instructor_id` VARCHAR(100) DEFAULT NULL,
    `session_date` DATE NOT NULL,
    `start_time` TIME NOT NULL,
    `end_time` TIME NOT NULL,
    `location` VARCHAR(100) DEFAULT NULL,
    `is_recurring` TINYINT(1) DEFAULT 0,
    `recurrence_pattern` VARCHAR(50) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`session_id`),
    KEY `idx_program` (`program_id`),
    KEY `idx_instructor` (`instructor_id`),
    KEY `idx_date` (`session_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### fa_training_categories
```sql
CREATE TABLE `@TB_PREF@fa_training_categories` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(255) DEFAULT NULL,
    `parent_id` INT(11) DEFAULT NULL,
    `inactive` TINYINT(1) DEFAULT 0,
    `sort_order` INT(11) DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `idx_parent` (`parent_id`),
    KEY `idx_sort` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### fa_training_certifications
```sql
CREATE TABLE `@TB_PREF@fa_training_certifications` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `validity_period` INT(11) DEFAULT 12,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### fa_training_activity_log
```sql
CREATE TABLE `@TB_PREF@fa_training_activity_log` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `activity_type` VARCHAR(30) NOT NULL,
    `entity_type` VARCHAR(30) NOT NULL,
    `entity_id` VARCHAR(20) NOT NULL,
    `user_id` VARCHAR(100) DEFAULT NULL,
    `action` VARCHAR(50) NOT NULL,
    `details` TEXT,
    `old_values` TEXT,
    `new_values` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_entity` (`entity_type`, `entity_id`),
    KEY `idx_user` (`user_id`),
    KEY `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

## 4. Integration Patterns

### 4.1 FA Integration

The module integrates with FrontAccounting core:

#### Database Integration
- Uses FA's `db_query()`, `db_fetch_assoc()`, etc.
- Uses `TB_PREF` for table prefix
- Uses `TB_PREF . "debtors_master"` for customers
- Uses `TB_PREF . "employee"` for employees

#### Session Integration
- Uses `$session->check_access()` for permission checks
- Defines permissions in `FA_Training_Module.php`

#### UI Integration
- Uses FA's `page()`, `start_table()`, `end_table()`
- Uses FA's form helpers

### 4.2 Service Integration

The module provides services for external consumption:

```php
// Using the DI container
$container = new TrainingContainer();
$trainingService = $container->get(TrainingServiceInterface::class);
```

### 4.3 Event Integration

PSR-14 event dispatcher for decoupled operations:

```php
$dispatcher = $container->get(EventDispatcherInterface::class);
$dispatcher->dispatch(new ProgramCreatedEvent($programId));
```

---

## 5. Security Architecture

### 5.1 Permission Model

Defined in FA_Training_Module.php:

| Permission | Description |
|------------|-------------|
| TRAINING_VIEW_PROGRAM | View program list |
| TRAINING_MANAGE_PROGRAM | Create/edit/delete programs |
| TRAINING_VIEW_ENROLLMENT | View enrollments |
| TRAINING_MANAGE_ENROLLMENT | Manage enrollments |
| TRAINING_VIEW_REPORTS | View reports |
| TRAINING_ADMIN | Full admin |

### 5.2 Data Validation

- SQL injection prevention via `db_escape()`
- Input sanitization via `htmlspecialchars()`
- Required field validation in business logic

---

## 6. Design Patterns

### 6.1 Patterns Used

| Pattern | Implementation |
|---------|---------------|
| Service Locator | TrainingContainer |
| Data Access Object | training_db.inc functions |
| Helper Object | training_ui.inc functions |
| Event Dispatcher | FAEventDispatcher |
| Factory | Container service creation |

### 6.2 Dependency Management

The TrainingContainer provides:
- Lazy-loaded services
- Singleton instances for shared services
- Constructor injection for dependent services

---

## 7. Configuration

### 7.1 Module Configuration

Located in pages/settings.php:
- Program types
- Delivery methods
- Default settings

### 7.2 Initial Data

Categories inserted on install:
- Technical Skills
- Soft Skills
- Compliance
- Product Training
- Onboarding
- Leadership

Delivery methods:
- Classroom
- Online
- Hybrid
- Self-Paced

---

## 8. Deployment

### 8.1 Installation

1. Copy module to `/modules/ksf_FA_Training`
2. Activate via FA Modules admin
3. SQL creates tables and inserts initial data
4. Permissions created in FA security

### 8.2 Initialization

_init/init.inc handles:
- Menu registration
- Permission setup
- Version tracking
