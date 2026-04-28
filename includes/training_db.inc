<?php
/**
 * Training Database Functions
 */

function create_training_program(string $name, string $type, string $description = '', float $duration_hours = null, float $cost = null): int
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "training_programs 
        (name, type, description, duration_hours, cost, created_by)
        VALUES (" . $db->escape($name) . ", " . $db->escape($type) . ", " . $db->escape($description) . ", " . ($duration_hours ? $duration_hours : 'NULL') . ", " . ($cost ? $cost : 'NULL') . ", " . user_id() . ")";
    $db->query($sql);
    return $db->insert_id;
}

function get_training_program(int $id): ?array
{
    global $db;
    $sql = "SELECT * FROM " . TB_PREF . "training_programs WHERE id = " . $id;
    $result = $db->query($sql);
    if ($result && $db->num_rows($result) > 0) {
        return $db->fetch($result);
    }
    return null;
}

function get_training_programs(array $filters = []): ?object
{
    global $db;
    $sql = "SELECT * FROM " . TB_PREF . "training_programs WHERE status != 'Archived'";
    
    if (!empty($filters['type'])) {
        $sql .= " AND type = " . $db->escape($filters['type']);
    }
    if (!empty($filters['status'])) {
        $sql .= " AND status = " . $db->escape($filters['status']);
    }
    
    $sql .= " ORDER BY name";
    return $db->query($sql);
}

function enroll_employee(int $program_id, int $employee_id): int
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "training_enrollments (program_id, employee_id, enrolled_by)
        VALUES (" . $program_id . ", " . $employee_id . ", " . user_id() . ")";
    $db->query($sql);
    return $db->insert_id;
}

function get_enrollments(array $filters = []): ?object
{
    global $db;
    $sql = "SELECT e.*, p.name as program_name, p.type, emp.name as employee_name FROM " . TB_PREF . "training_enrollments e
        LEFT JOIN " . TB_PREF . "training_programs p ON e.program_id = p.id
        LEFT JOIN " . TB_PREF . "hr_employees emp ON e.employee_id = emp.id WHERE 1=1";
    
    if (!empty($filters['program_id'])) {
        $sql .= " AND e.program_id = " . $filters['program_id'];
    }
    if (!empty($filters['employee_id'])) {
        $sql .= " AND e.employee_id = " . $filters['employee_id'];
    }
    if (!empty($filters['status'])) {
        $sql .= " AND e.status = " . $db->escape($filters['status']);
    }
    
    $sql .= " ORDER BY e.enrolled_at DESC";
    return $db->query($sql);
}

function complete_training(int $enrollment_id, float $score = null, string $certificate_path = ''): bool
{
    global $db;
    $sql = "UPDATE " . TB_PREF . "training_enrollments SET status = 'Completed', completion_date = CURDATE(), score = " . ($score ? $score : 'NULL') . ", certificate_path = " . $db->escape($certificate_path) . " WHERE id = " . $enrollment_id;
    return $db->query($sql);
}

function get_employee_training(int $employee_id): ?object
{
    global $db;
    $sql = "SELECT e.*, p.name as program_name, p.type, p.duration_hours FROM " . TB_PREF . "training_enrollments e
        LEFT JOIN " . TB_PREF . "training_programs p ON e.program_id = p.id
        WHERE e.employee_id = " . $employee_id . " ORDER BY e.enrolled_at DESC";
    return $db->query($sql);
}

function create_training_session(int $program_id, string $start_date, string $location = '', string $instructor = '', int $max_capacity = null): int
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "training_sessions (program_id, start_date, location, instructor, max_capacity)
        VALUES (" . $program_id . ", " . $db->escape($start_date) . ", " . $db->escape($location) . ", " . $db->escape($instructor) . ", " . ($max_capacity ? $max_capacity : 'NULL') . ")";
    $db->query($sql);
    return $db->insert_id;
}

function get_upcoming_training_sessions(): ?object
{
    global $db;
    $sql = "SELECT s.*, p.name as program_name, p.type FROM " . TB_PREF . "training_sessions s
        LEFT JOIN " . TB_PREF . "training_programs p ON s.program_id = p.id
        WHERE s.status = 'Scheduled' AND s.start_date >= CURDATE()
        ORDER BY s.start_date ASC";
    return $db->query($sql);
}