<?php
/**
 * Training Module for FrontAccounting
 */

$module_id = 'Training';
$module_version = '1.0.0';
$module_name = 'Training Management';
$module_description = 'Employee training program and enrollment management';

$module_tables = [
    'fa_training_programs',
    'fa_training_enrollments',
    'fa_training_sessions',
];

$module_capabilities = [
    'SA_TRAININGVIEW' => 'View Training Programs',
    'SA_TRAININGCREATE' => 'Create Training Programs',
    'SA_TRAININGENROLL' => 'Enroll Employees',
    'SA_TRAININGREPORTS' => 'View Training Reports',
];

function training_install(): bool
{
    global $db, $db_multi_sql;
    $sql_file = dirname(__FILE__) . '/../sql/install.sql';
    if (!file_exists($sql_file)) return false;
    $sql = file_get_contents($sql_file);
    return $db_multi_sql($sql);
}

function training_enable(): bool
{
    global $db;
    return $db->query("UPDATE " . TB_PREF . "modules SET enabled = 1 WHERE name = 'Training'");
}

function training_disable(): bool
{
    global $db;
    return $db->query("UPDATE " . TB_PREF . "modules SET enabled = 0 WHERE name = 'Training'");
}

function training_remove(): bool
{
    global $db, $db_multi_sql;
    $sql = "DROP TABLE IF EXISTS " . TB_PREF . "training_sessions;
           DROP TABLE IF EXISTS " . TB_PREF . "training_enrollments;
           DROP TABLE IF EXISTS " . TB_PREF . "training_programs;
           DELETE FROM " . TB_PREF . "modules WHERE name = 'Training';";
    return $db_multi_sql($sql);
}

add_module($module_name, $module_version, $module_description);