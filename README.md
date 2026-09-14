# ksf_FA_Training - Training Management Module

FA module for managing training programs, courses, enrollments, and training-related activities.

## Overview

The Training Management module provides comprehensive functionality for training and development management including:
- Training program and course management
- Enrollment and attendee tracking
- Instructor management
- Schedule and calendar management
- Certification tracking
- Training metrics and reporting

## Features

### Core Features

#### Training Program Management
- **Full CRUD Operations**: Create, read, update, delete training programs
- **Program Types**: Classify by type (Technical, Soft Skills, Compliance, Product, Onboarding)
- **Status Tracking**: Draft, Published, In Progress, Completed, Archived
- **Category Management**: Training categories and subcategories
- **Duration Tracking**: Estimated hours, actual completion hours
- **Certification Integration**: Link programs to certifications
- **Prerequisites**: Define prerequisite programs

#### Course Management
- **Course Catalog**: Maintain list of available courses
- **Course Content**: Store course description, objectives, outline
- **Instructor Assignment**: Assign instructors to courses
- **Capacity Limits**: Set maximum attendees
- **Delivery Methods**: Classroom, Online, Hybrid, Self-Paced
- **Course Materials**: Attach documents and resources

#### Enrollment Management
- **Self-Enrollment**: Allow employees to self-enroll
- **Manager Approval**: Workflow for manager approval
- **Enrollment Tracking**: Track enrollment status
- **Attendance**: Mark attendance per session
- **Completion**: Track completion status
- **Waitlist**: Manage waitlists for full courses

#### Instructor Management
- **Instructor Profiles**: Maintain instructor details
- **Qualifications**: Track certifications and expertise
- **Availability**: Manage instructor availability
- **Rating System**: Employee ratings and feedback

#### Schedule & Calendar
- **Session Scheduling**: Create training sessions
- **Recurring Sessions**: Support recurring training
- **Location Management**: Room/location tracking
- **Calendar Integration**: View training calendar

#### Certification Management
- **Certification Track**: Define certification paths
- **Expiry Tracking**: Track certification validity
- **Renewal Reminders**: Automatic reminders
- **Certificate Generation**: Generate certificates

### Dashboard & Reporting
- **Dashboard Statistics**: Total programs, enrollments, completions
- **Enrollment Reports**: Enrollment status tracking
- **Completion Reports**: Completion rates
- **Instructor Reports**: Instructor performance
- **Certification Reports**: Certification status

### Integration Features
- **CRM Integration**: Link to FA CRM customers (for external training)
- **Employee Integration**: Link to FA employee records
- **HR Integration**: Integrate with HR workflows
- **Event-Driven Architecture**: PSR-14 event dispatcher
- **Dependency Injection**: PSR-11 container support

## Quick Start

### Installation

```bash
# Install via composer
composer require ksfraser/ksf-training

# Copy module to FA
cp -r ksf_FA_Training /path/to/frontaccounting/modules/

# Activate via FA Admin → Setup → Modules
```

### Basic Usage

```php
use Ksfraser\Training\FA\TrainingContainer;
use Ksfraser\Training\TrainingService;

// Create a training program
$programData = [
    'program_id' => 'TRP-001',
    'name' => 'Leadership Fundamentals',
    'description' => 'Core leadership skills training',
    'program_type' => 'Soft Skills',
    'duration_hours' => 16,
    'status' => 'Published'
];

$programId = insert_training_program($programData);

// Get program details
$program = get_training_program('TRP-001');

// Enroll employee
enroll_employee([
    'program_id' => 'TRP-001',
    'employee_id' => 'EMP-001',
    'enrollment_date' => '2024-01-15'
]);
```

## Database Tables

The module expects the following database tables:

### fa_training_programs
| Column | Type | Description |
|--------|------|-------------|
| program_id | VARCHAR(20) | Primary key |
| name | VARCHAR(100) | Program name |
| description | TEXT | Detailed description |
| program_type | VARCHAR(50) | Type classification |
| category_id | INT | FK to categories |
| duration_hours | DECIMAL(10,2) | Estimated duration |
| status | VARCHAR(30) | Draft/Published/In Progress/Completed/Archived |
| delivery_method | VARCHAR(30) | Classroom/Online/Hybrid/Self-Paced |
| capacity | INT | Maximum attendees |
| prerequisites | TEXT | Prerequisite programs (JSON) |
| certification_id | INT | Linked certification |
| created_at | TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | Last update time |

### fa_training_courses
| Column | Type | Description |
|--------|------|-------------|
| course_id | VARCHAR(20) | Primary key |
| program_id | VARCHAR(20) | FK to programs |
| name | VARCHAR(100) | Course name |
| description | TEXT | Course description |
| objectives | TEXT | Learning objectives |
| outline | TEXT | Course outline |
| instructor_id | VARCHAR(100) | Assigned instructor |
| duration_hours | DECIMAL(10,2) | Course duration |
| delivery_method | VARCHAR(30) | Delivery method |
| materials | TEXT | Attached materials |
| created_at | TIMESTAMP | Record creation time |

### fa_training_enrollments
| Column | Type | Description |
|--------|------|-------------|
| enrollment_id | INT | Primary key |
| program_id | VARCHAR(20) | FK to programs |
| employee_id | VARCHAR(100) | FK to employees |
| enrollment_date | DATE | Enrollment date |
| status | VARCHAR(30) | Enrolled/Waitlisted/Completed/Cancelled |
| attendance_marked | TINYINT(1) | Attendance status |
| completion_date | DATE | Completion date |
| score | DECIMAL(5,2) | Assessment score |
| certificate_issued | TINYINT(1) | Certificate issued flag |
| created_at | TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | Last update time |

### fa_training_instructors
| Column | Type | Description |
|--------|------|-------------|
| instructor_id | VARCHAR(100) | Primary key |
| employee_id | VARCHAR(100) | FK to employees |
| specialization | VARCHAR(255) | Areas of expertise |
| bio | TEXT | Biography |
| rating | DECIMAL(3,2) | Average rating |
| created_at | TIMESTAMP | Record creation time |

### fa_training_sessions
| Column | Type | Description |
|--------|------|-------------|
| session_id | VARCHAR(20) | Primary key |
| program_id | VARCHAR(20) | FK to programs |
| instructor_id | VARCHAR(100) | FK to instructors |
| session_date | DATE | Session date |
| start_time | TIME | Start time |
| end_time | TIME | End time |
| location | VARCHAR(100) | Location/room |
| is_recurring | TINYINT(1) | Recurring flag |
| recurrence_pattern | VARCHAR(50) | Recurrence details |
| created_at | TIMESTAMP | Record creation time |

### fa_training_categories
| Column | Type | Description |
|--------|------|-------------|
| id | INT(11) | Primary key |
| name | VARCHAR(50) | Category name |
| description | VARCHAR(255) | Category description |
| parent_id | INT | Parent category |
| inactive | TINYINT(1) | Active flag |
| sort_order | INT(11) | Display order |

### fa_training_certifications
| Column | Type | Description |
|--------|------|-------------|
| id | INT(11) | Primary key |
| name | VARCHAR(100) | Certification name |
| description | TEXT | Description |
| validity_period | INT | Valid for (months) |
| created_at | TIMESTAMP | Record creation time |

### fa_training_activity_log
| Column | Type | Description |
|--------|------|-------------|
| id | INT(11) | Primary key |
| activity_type | VARCHAR(30) | Activity category |
| entity_type | VARCHAR(30) | program/course/enrollment |
| entity_id | VARCHAR(20) | Entity reference |
| user_id | VARCHAR(100) | User who performed action |
| action | VARCHAR(50) | Action performed |
| details | TEXT | Detailed description |
| old_values | TEXT | Previous values (JSON) |
| new_values | TEXT | New values (JSON) |
| created_at | TIMESTAMP | Activity timestamp |

## Permissions

### Role-Based Access Control

| Permission | Description |
|------------|-------------|
| TRAINING_VIEW_PROGRAM | View training programs |
| TRAINING_MANAGE_PROGRAM | Create, edit, delete programs |
| TRAINING_VIEW_ENROLLMENT | View enrollments |
| TRAINING_MANAGE_ENROLLMENT | Manage enrollments |
| TRAINING_VIEW_REPORTS | View reports and analytics |
| TRAINING_ADMIN | Full administrative access |

## API Reference

### Database Functions (training_db.inc)

```php
// Programs
get_training_programs(string $search = '', string $status = ''): object|false
get_training_program(string $programId): ?array
get_training_program_count(string $status = ''): int
insert_training_program(array $data): string
update_training_program(string $programId, array $data): bool
delete_training_program(string $programId): bool

// Courses
get_training_courses(string $programId = ''): object|false
get_training_course(string $courseId): ?array
insert_training_course(array $data): string
update_training_course(string $courseId, array $data): bool

// Enrollments
get_training_enrollments(string $programId = ''): object|false
get_enrollment(string $enrollmentId): ?array
get_employee_enrollments(string $employeeId): array
insert_enrollment(array $data): int
update_enrollment(string $enrollmentId, array $data): bool

// Instructors
get_training_instructors(): array
get_instructor(string $instructorId): ?array
insert_instructor(array $data): string
update_instructor(string $instructorId, array $data): bool

// Sessions
get_training_sessions(string $programId = ''): object|false
insert_session(array $data): string

// Categories
get_training_categories(): array

// Certifications
get_training_certifications(): array
```

### UI Functions (training_ui.inc)

```php
// Navigation
training_navigation_menu(): void

// Display
display_training_dashboard_stats(array $stats): void
display_enrollment_status(array $enrollments): void
display_session_calendar(array $sessions): void

// Select Helpers
sel_training_status(string $selected = 'Draft'): string
sel_delivery_method(string $selected = 'Classroom'): string
sel_program(array $programs, string $selected = ''): string
sel_category(array $categories, string $selected = ''): string
sel_instructor(array $instructors, string $selected = ''): string
sel_enrollment_status(string $selected = 'Enrolled'): string

// Status Helpers
get_training_status_class(string $status): string
get_enrollment_status_class(string $status): string
```

### Container Services (TrainingContainer.php)

```php
// Services available via DI container:
// - DatabaseAdapterInterface
// - EmployeeServiceInterface
// - TrainingServiceInterface
// - EventDispatcherInterface
// - LoggerInterface
```

## Configuration

### Program Status Flow

```
Draft → Published → In Progress → Completed
Draft → Published → Archived
Published → In Progress → Completed → Archived
```

### Delivery Methods

- Classroom - In-person training
- Online - Virtual/online training
- Hybrid - Mix of classroom and online
- Self-Paced - Self-directed learning

### Enrollment Status

- Enrolled - Registered for training
- Waitlisted - On waitlist
- Attended - Attended the training
- Completed - Successfully completed
- Cancelled - Enrollment cancelled
- No-Show - Did not attend

## Testing

Run unit tests:

```bash
./vendor/bin/phpunit
```

## Module Structure

```
ksf_FA_Training/
├── composer.json
├── FA_Training_Module.php
├── hooks.php
├── training.php
├── README.md
├── _init/
│   └── init.inc
├── includes/
│   ├── import.php
│   ├── TrainingContainer.php
│   ├── training_db.inc
│   └── training_ui.inc
├── pages/
│   ├── dashboard.php
│   ├── programs.php
│   ├── courses.php
│   ├── enrollments.php
│   ├── instructors.php
│   ├── schedule.php
│   ├── reports.php
│   └── settings.php
├── sql/
│   ├── install.sql
│   └── uninstall.sql
├── tests/
│   └── Unit/
│       └── ComposerDependencyManagerTest.php
│       └── MetadataTest.php
└── ProjectDcs/
    ├── Architecture.md
    ├── Functional Requirements.md
    ├── Test Plan.md
    └── UAT Plan.md
```

## Dependencies

- FrontAccounting 2.4.0+
- PHP 8.0+
- ksfraser/ksf-training (core library)
- ksfraser/ksf-common (common utilities)

## License

Proprietary - KS Fraser Application Framework
