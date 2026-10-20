-- Training module database schema for FrontAccounting

-- Training programs
CREATE TABLE IF NOT EXISTS `fa_training_programs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `type` ENUM('Technical','Soft Skills','Compliance','Safety','Leadership','Other') NOT NULL DEFAULT 'Other',
    `duration_hours` DECIMAL(5,2) DEFAULT NULL,
    `provider` VARCHAR(255) DEFAULT NULL,
    `cost` DECIMAL(10,2) DEFAULT NULL,
    `status` ENUM('Active','Inactive','Archived') NOT NULL DEFAULT 'Active',
    `created_by` INT(11) DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `type` (`type`),
    KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Training enrollments
CREATE TABLE IF NOT EXISTS `fa_training_enrollments` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `program_id` INT(11) NOT NULL,
    `employee_id` INT(11) NOT NULL,
    `enrolled_by` INT(11) DEFAULT NULL,
    `enrolled_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` ENUM('Enrolled','Completed','Failed','Cancelled') NOT NULL DEFAULT 'Enrolled',
    `completion_date` DATE DEFAULT NULL,
    `score` DECIMAL(5,2) DEFAULT NULL,
    `certificate_path` VARCHAR(500) DEFAULT NULL,
    `feedback` TEXT,
    PRIMARY KEY (`id`),
    KEY `program_id` (`program_id`),
    KEY `employee_id` (`employee_id`),
    KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Training sessions
CREATE TABLE IF NOT EXISTS `fa_training_sessions` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `program_id` INT(11) NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE DEFAULT NULL,
    `location` VARCHAR(255) DEFAULT NULL,
    `instructor` VARCHAR(255) DEFAULT NULL,
    `max_capacity` INT(11) DEFAULT NULL,
    `enrolled_count` INT(11) NOT NULL DEFAULT 0,
    `status` ENUM('Scheduled','In Progress','Completed','Cancelled') NOT NULL DEFAULT 'Scheduled',
    PRIMARY KEY (`id`),
    KEY `program_id` (`program_id`),
    KEY `dates` (`start_date`,`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Module version
INSERT INTO `fa_modules` (`name`, `version`, `enabled`, `installed`) VALUES
('Training', '1.0.0', 1, NOW())
ON DUPLICATE KEY UPDATE `version` = '1.0.0', `installed` = NOW();

-- ---------------------------------------------------------------------------
-- Module-local employee directory.
--
-- WHY THIS TABLE EXISTS (and why it is not FA core):
--   FA core has no employee entity. In this estate an employee is an FA
--   person (0_crm_persons) plus a crm_categories row of type 'employee' plus
--   a satellite employment table - the satellite belongs to ksf_FA_HRM
--   (0_hrm_contacts_employment). Reaching into another module's table would
--   make this module depend on that module being activated, which
--   AGENTS_ARCH.md 12.2 forbids ("a shared seam must never be gated on
--   another module's activation"). The contact resolver in ksf-fa-common
--   deliberately does not cover the employee intent either.
--   So this module keeps its OWN employee directory, keyed by the same
--   employee_id its own records already carry. It is module-local by design.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `0_ksf_training_employees` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(120) DEFAULT NULL,
    `active` TINYINT(1) DEFAULT 1,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;