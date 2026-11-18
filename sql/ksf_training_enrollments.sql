-- Training module database schema for FrontAccounting
-- Table: 0_ksf_training_enrollments

ALTER TABLE IF EXISTS `fa_training_enrollments` RENAME TO `0_ksf_training_enrollments`;

CREATE TABLE IF NOT EXISTS `0_ksf_training_enrollments` (
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
