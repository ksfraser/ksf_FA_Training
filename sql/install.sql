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