<?php
/**
 * FA_Training Module Hooks for FrontAccounting
 */

define('SS_TRAINING', 140 << 8);

class hooks_ksf_FA_Training extends hooks {
    var $module_name = 'ksf_FA_Training';
    var $version = '2.4.0';

    function install_options($app) {
        global $path_to_root;

        switch($app->id) {
            case 'HR':
                $app->add_lapp_function(0, _("Training Programs"),
                    $path_to_root."/modules/".$this->module_name."/programs.php", 'SA_TRAININGVIEW', MENU_ENTRY);
                $app->add_lapp_function(1, _("Enroll Employee"),
                    $path_to_root."/modules/".$this->module_name."/enroll.php", 'SA_TRAININGENROLL', MENU_ENTRY);
                $app->add_lapp_function(2, _("Sessions"),
                    $path_to_root."/modules/".$this->module_name."/sessions.php", 'SA_TRAININGVIEW', MENU_ENTRY);
                break;
        }
    }

    function install_access() {
        $security_sections[SS_TRAINING] = _("Training Management");
        $security_areas['SA_TRAININGVIEW'] = array(SS_TRAINING | 1, _("View Training Programs"));
        $security_areas['SA_TRAININGCREATE'] = array(SS_TRAINING | 2, _("Create Training Programs"));
        $security_areas['SA_TRAININGENROLL'] = array(SS_TRAINING | 3, _("Enroll Employees"));
        $security_areas['SA_TRAININGREPORTS'] = array(SS_TRAINING | 4, _("View Training Reports"));
        return array($security_areas, $security_sections);
    }

    function install_extension($check_only=true) {
        return true;
    }

    function install_tabs($app) {
    }

    function activate_extension($company, $check_only=true) {
        $updates = array('sql/update.sql' => array($this->module_name));
        $ok = $this->update_databases($company, $updates, $check_only);
        if ($check_only || !$ok) {
            return $ok;
        }
        $this->ensure_training_schema();
        return $ok;
    }

    private function table_exists($table) {
        $sql = "SHOW TABLES LIKE " . db_escape($table);
        $res = db_query($sql, 'Failed checking table existence');
        return db_num_rows($res) > 0;
    }

    private function ensure_training_schema() {
        $tables = array(
            TB_PREF . "fa_training_programs" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_training_programs` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `program_name` VARCHAR(100) NOT NULL,
                    `description` TEXT,
                    `duration_hours` INT(11) DEFAULT 0,
                    `instructor` VARCHAR(100) DEFAULT NULL,
                    `max_participants` INT(11) DEFAULT 0,
                    `status` VARCHAR(20) DEFAULT 'Active',
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_status` (`status`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci",

            TB_PREF . "fa_training_enrollments" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_training_enrollments` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `program_id` INT(11) NOT NULL,
                    `employee_id` VARCHAR(100) NOT NULL,
                    `enrollment_date` DATE NOT NULL,
                    `completion_date` DATE DEFAULT NULL,
                    `status` VARCHAR(20) DEFAULT 'Enrolled',
                    `grade` VARCHAR(10) DEFAULT NULL,
                    `notes` TEXT,
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_program` (`program_id`),
                    KEY `idx_employee` (`employee_id`),
                    KEY `idx_status` (`status`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci",

            TB_PREF . "fa_training_sessions" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_training_sessions` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `program_id` INT(11) NOT NULL,
                    `session_date` DATE NOT NULL,
                    `start_time` TIME DEFAULT NULL,
                    `end_time` TIME DEFAULT NULL,
                    `location` VARCHAR(100) DEFAULT NULL,
                    `notes` TEXT,
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_program` (`program_id`),
                    KEY `idx_date` (`session_date`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
        );

        foreach ($tables as $table_name => $sql) {
            db_query($sql, "Could not create Training table: $table_name");
        }
    }

    function db_prevoid($trans_type, $trans_no) {
        // Handle voiding if needed
    }
}
?>
