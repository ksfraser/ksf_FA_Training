-- Training module database schema for FrontAccounting
-- Table: 0_ksf_training_sessions

ALTER TABLE IF EXISTS `fa_training_sessions` RENAME TO `0_ksf_training_sessions`;

CREATE TABLE IF NOT EXISTS `0_ksf_training_sessions` (
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
