-- Training module database schema for FrontAccounting
-- Table: 0_ksf_training_programs

ALTER TABLE IF EXISTS `fa_training_programs` RENAME TO `0_ksf_training_programs`;

CREATE TABLE IF NOT EXISTS `0_ksf_training_programs` (
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
