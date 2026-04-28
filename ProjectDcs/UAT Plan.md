# UAT Plan - ksf_FA_Training

## Overview

This document defines the User Acceptance Test (UAT) cases for the Training Management module. UAT validates that the system meets business requirements and is ready for production deployment.

---

## 1. UAT Objectives

### 1.1 Goals

- Validate business workflows function correctly
- Confirm user requirements are met
- Ensure integration with FA works seamlessly
- Verify data accuracy and integrity
- Obtain sign-off for production deployment

### 1.2 Success Criteria

- All critical test cases pass
- No high-severity defects open
- User acceptance obtained
- Sign-off documented

---

## 2. UAT Scope

### 2.1 In Scope

- Training program CRUD operations
- Course management
- Enrollment and attendee tracking
- Instructor management
- Session scheduling
- Dashboard and reporting
- FA integrations (CRM, Employee)
- Security and permissions

### 2.2 Out of Scope

- Performance stress testing
- Security penetration testing
- Browser compatibility (covered in QA)
- Data migration from legacy systems

---

## 3. UAT User Roles

| Role | Description | Tests Executed |
|------|-------------|---------------|
| Training Manager | Manages programs and enrollments | TR-001 through TR-008 |
| Employee | Self-enrolls and completes training | EM-001 through EM-003 |
| Administrator | System configuration | AD-001 through AD-003 |

---

## 4. UAT Test Cases

### 4.1 Training Program Management (TR)

#### UAT-TR-001: Create New Training Program

| Field | Value |
|-------|-------|
| Test Case ID | UAT-TR-001 |
| Scenario | Create a new training program as Training Manager |
| Preconditions | User has TRAINING_MANAGE_PROGRAM permission |
| Test Steps | 1. Login as Training Manager |
| | 2. Navigate to Training → Programs |
| | 3. Click "New Program" |
| | 4. Enter: Program ID = "TRP-001", Name = "Leadership Training", Description = "Leadership skills development", Type = "Soft Skills" |
| | 5. Set Duration = 16 hours |
| | 6. Select Delivery Method = "Classroom" |
| | 7. Set Status = "Draft" |
| | 8. Click Save |
| Expected Result | Success message, program appears in list |
| Acceptance Criteria | [ ] Program saved to database |
| | [ ] Program visible in list with all fields correct |
| | [ ] Activity logged |
| Result | PASS/FAIL |
| Notes | |

#### UAT-TR-002: Edit Program Details

| Field | Value |
|-------|-------|
| Test Case ID | UAT-TR-002 |
| Scenario | Modify program details |
| Preconditions | Program exists from UAT-TR-001 |
| Test Steps | 1. Edit program TRP-001 |
| | 2. Change status to "Published" |
| | 3. Change capacity to 20 |
| | 4. Save changes |
| Expected Result | Changes saved successfully |
| Acceptance Criteria | [ ] Status updated to Published |
| | [ ] Capacity updated to 20 |
| | [ ] Activity logged |
| Result | PASS/FAIL |
| Notes | |

#### UAT-TR-003: View Programs with Filters

| Field | Value |
|-------|-------|
| Test Case ID | UAT-TR-003 |
| Scenario | Search and filter programs |
| Preconditions | Multiple programs exist with different statuses |
| Test Steps | 1. Navigate to Training → Programs |
| | 2. Enter search term "Leadership" |
| | 3. Click specific status filter link |
| Expected Result | Correct programs displayed |
| Acceptance Criteria | [ ] Search returns matching programs |
| | [ ] Status filter shows correct programs |
| Result | PASS/FAIL |
| Notes | |

#### UAT-TR-004: Delete Program

| Field | Value |
|-------|-------|
| Test Case ID | UAT-TR-004 |
| Scenario | Delete a training program |
| Preconditions | Test program exists |
| Test Steps | 1. Navigate to program edit |
| | 2. Click Delete |
| | 3. Confirm deletion |
| Expected Result | Program removed from system |
| Acceptance Criteria | [ ] Program not in list |
| | [ ] Related courses handled |
| | [ ] Activity logged |
| Result | PASS/FAIL |
| Notes | |

#### UAT-TR-005: Create Program with Prerequisites

| Field | Value |
|-------|-------|
| Test Case ID | UAT-TR-005 |
| Scenario | Create program with prerequisites |
| Preconditions | Programs exist |
| Test Steps | 1. Create new program |
| | 2. Select prerequisite programs |
| | 3. Save |
| Expected Result | Prerequisites saved |
| Acceptance Criteria | [ ] Prerequisites stored in database |
| | [ ] Visible in program details |
| Result | PASS/FAIL |
| Notes | |

---

### 4.2 Course Management (CO)

#### UAT-CO-001: Create Course Under Program

| Field | Value |
|-------|-------|
| Test Case ID | UAT-CO-001 |
| Scenario | Add course to a training program |
| Preconditions | Program exists |
| Test Steps | 1. Navigate to Training → Courses |
| | 2. Click "New Course" |
| | 3. Select program |
| | 4. Enter course details: name, description, objectives |
| | 5. Set duration |
| | 6. Set delivery method |
| | 7. Save |
| Expected Result | Course created and associated |
| Acceptance Criteria | [ ] Course saved to database |
| | [ ] Course appears in course list |
| | [ ] Linked to correct program |
| Result | PASS/FAIL |
| Notes | |

#### UAT-CO-002: Assign Instructor to Course

| Field | Value |
|-------|-------|
| Test Case ID | UAT-CO-002 |
| Scenario | Assign instructor to course |
| Preconditions | Course exists, instructor exists |
| Test Steps | 1. Edit course |
| | 2. Select instructor from dropdown |
| | 3. Save |
| Expected Result | Instructor assigned to course |
| Acceptance Criteria | [ ] Instructor selection saved |
| | [ ] Instructor visible in course details |
| Result | PASS/FAIL |
| Notes | |

#### UAT-CO-003: View Courses by Program Filter

| Field | Value |
|-------|-------|
| Test Case ID | UAT-CO-003 |
| Scenario | Filter courses by program |
| Preconditions | Multiple courses under different programs exist |
| Test Steps | 1. Navigate to Courses |
| | 2. Select specific program from dropdown |
| Expected Result | Only courses for selected program shown |
| Acceptance Criteria | [ ] Correct filtering |
| | [ ] Program name shown for reference |
| Result | PASS/FAIL |
| Notes | |

---

### 4.3 Enrollment Management (EN)

#### UAT-EN-001: Enroll Employee in Program

| Field | Value |
|-------|-------|
| Test Case ID | UAT-EN-001 |
| Scenario | Enroll employee in training program |
| Preconditions | Program exists, employee exists in FA |
| Test Steps | 1. Navigate to Training → Enrollments |
| | 2. Click "New Enrollment" |
| | 3. Select program |
| | 4. Select employee |
| | 5. Set enrollment date |
| | 6. Save |
| Expected Result | Employee enrolled successfully |
| Acceptance Criteria | [ ] Enrollment saved to database |
| | [ ] Employee appears in enrollment list |
| | [ ] Status shows "Enrolled" |
| Result | PASS/FAIL |
| Notes | |

#### UAT-EN-002: Mark Attendance

| Field | Value |
|-------|-------|
| Test Case ID | UAT-EN-002 |
| Scenario | Mark employee attendance |
| Preconditions | Enrollment exists |
| Test Steps | 1. Edit enrollment |
| | 2. Mark attendance as present |
| | 3. Save |
| Expected Result | Attendance marked |
| Acceptance Criteria | [ ] Attendance status saved |
| | [ ] Shows in enrollment list |
| Result | PASS/FAIL |
| Notes | |

#### UAT-EN-003: Complete Training

| Field | Value |
|-------|-------|
| Test Case ID | UAT-EN-003 |
| Scenario | Mark training as completed |
| Preconditions | Enrollment with attendance marked |
| Test Steps | 1. Edit enrollment |
| | 2. Set completion status to "Completed" |
| | 3. Set score if applicable |
| | 4. Save |
| Expected Result | Training marked complete |
| Acceptance Criteria | [ ] Status shows "Completed" |
| | [ ] Completion date recorded |
| | [ ] Activity logged |
| Result | PASS/FAIL |
| Notes | |

#### UAT-EN-004: Cancel Enrollment

| Field | Value |
|-------|-------|
| Test Case ID | UAT-EN-004 |
| Scenario | Cancel employee enrollment |
| Preconditions | Enrollment exists |
| Test Steps | 1. Edit enrollment |
| | 2. Change status to "Cancelled" |
| | 3. Save |
| Expected Result | Enrollment cancelled |
| Acceptance Criteria | [ ] Status shows "Cancelled" |
| | [ ] Activity logged |
| Result | PASS/FAIL |
| Notes | |

#### UAT-EN-005: Self-Enrollment

| Field | Value |
|-------|-------|
| Test Case ID | UAT-EN-005 |
| Scenario | Employee self-enrolls in program |
| Preconditions | Program published, self-enrollment enabled |
| Test Steps | 1. Login as Employee |
| | 2. Navigate to My Training |
| | 3. View available programs |
| | 4. Select program |
| | 5. Click Enroll |
| Expected Result | Employee enrolled |
| Acceptance Criteria | [ ] Self-enrollment works |
| | [ ] Confirmation shown |
| Result | PASS/FAIL |
| Notes | |

---

### 4.4 Instructor Management (IN)

#### UAT-IN-001: Add Instructor

| Field | Value |
|-------|-------|
| Test Case ID | UAT-IN-001 |
| Scenario | Add new instructor |
| Preconditions | Employee exists in FA |
| Test Steps | 1. Navigate to Training → Instructors |
| | 2. Click "Add Instructor" |
| | 3. Select employee |
| | 4. Enter specialization |
| | 5. Add bio |
| | 6. Save |
| Expected Result | Instructor added |
| Acceptance Criteria | [ ] Instructor in list |
| | [ ] Details stored |
| Result | PASS/FAIL |
| Notes | |

#### UAT-IN-002: View Instructor Details

| Field | Value |
|-------|-------|
| Test Case ID | UAT-IN-002 |
| Scenario | View instructor details |
| Preconditions | Instructor exists |
| Test Steps | 1. Navigate to Instructors |
| | 2. Click instructor name |
| Expected Result | Details displayed |
| Acceptance Criteria | [ ] Name, specialization, bio shown |
| | [ ] Rating shown |
| Result | PASS/FAIL |
| Notes | |

#### UAT-IN-003: Rate Instructor

| Field | Value |
|-------|-------|
| Test Case ID | UAT-IN-003 |
| Scenario | Employee rates instructor |
| Preconditions | Enrollment completed |
| Test Steps | 1. Navigate to completed training |
| | 2. Rate instructor (1-5) |
| | 3. Add feedback comments |
| | 4. Submit |
| Expected Result | Rating saved |
| Acceptance Criteria | [ ] Rating recorded |
| | [ ] Average updated |
| Result | PASS/FAIL |
| Notes | |

---

### 4.5 Session Scheduling (SS)

#### UAT-SS-001: Create Training Session

| Field | Value |
|-------|-------|
| Test Case ID | UAT-SS-001 |
| Scenario | Create training session |
| Preconditions | Program exists |
| Test Steps | 1. Navigate to Training → Schedule |
| | 2. Click "New Session" |
| | 3. Select program |
| | 4. Select instructor |
| | 5. Set date and time |
| | 6. Set location |
| | 7. Save |
| Expected Result | Session created |
| Acceptance Criteria | [ ] Session in schedule |
| | [ ] Details correct |
| Result | PASS/FAIL |
| Notes | |

#### UAT-SS-002: View Calendar

| Field | Value |
|-------|-------|
| Test Case ID | UAT-SS-002 |
| Scenario | View training calendar |
| Preconditions | Sessions exist |
| Test Steps | 1. Navigate to Schedule |
| | 2. Switch to calendar view |
| Expected Result | Sessions displayed on calendar |
| Acceptance Criteria | [ ] Sessions on correct dates |
| | [ ] Times shown |
| Result | PASS/FAIL |
| Notes | |

#### UAT-SS-003: Create Recurring Sessions

| Field | Value |
|-------|-------|
| Test Case ID | UAT-SS-003 |
| Scenario | Create recurring training sessions |
| Preconditions | Program exists |
| Test Steps | 1. Create new session |
| | 2. Enable recurring |
| | 3. Set pattern (e.g., weekly for 4 weeks) |
| | 4. Save |
| Expected Result | Multiple sessions created |
| Acceptance Criteria | [ ] All sessions in schedule |
| | [ ] Series manageable |
| Result | PASS/FAIL |
| Notes | |

---

### 4.6 Dashboard (DB)

#### UAT-DB-001: View Dashboard Statistics

| Field | Value |
|-------|-------|
| Test Case ID | UAT-DB-001 |
| Scenario | Verify dashboard displays correct counts |
| Preconditions | Test data created in previous tests |
| Test Steps | 1. Navigate to Dashboard |
| | 2. View statistics |
| Expected Result | Dashboard shows counts |
| Acceptance Criteria | [ ] Total programs count matches |
| | [ ] Active enrollments count matches |
| | [ ] Completion rate shown |
| Result | PASS/FAIL |
| Notes | |

#### UAT-DB-002: View Recent Activities

| Field | Value |
|-------|-------|
| Test Case ID | UAT-DB-002 |
| Scenario | Verify activity log displays |
| Preconditions | Activities performed |
| Test Steps | 1. Navigate to Dashboard |
| | 2. View Recent Activities section |
| Expected Result | Activities listed |
| Acceptance Criteria | [ ] Activities chronologically ordered |
| | [ ] Action and details shown |
| Result | PASS/FAIL |
| Notes | |

---

### 4.7 Reports (RP)

#### UAT-RP-001: Generate Enrollment Report

| Field | Value |
|-------|-------|
| Test Case ID | UAT-RP-001 |
| View enrollment status summary |
| Preconditions | Enrollments exist |
| Test Steps | 1. Navigate to Training → Reports |
| | 2. Select Enrollment Report |
| Expected Result | Report displays with counts |
| Acceptance Criteria | [ ] Status breakdown table |
| | [ ] Counts accurate |
| Result | PASS/FAIL |
| Notes | |

#### UAT-RP-002: Generate Completion Report

| Field | Value |
|-------|-------|
| Test Case ID | UAT-RP-002 |
| Scenario | View completion rates by program |
| Preconditions | Completions exist |
| Test Steps | 1. Navigate to Reports |
| | 2. Select Completion Report |
| Expected Result | Completion rates displayed |
| Acceptance Criteria | [ ] Rates by program |
| | [ ] Totals correct |
| Result | PASS/FAIL |
| Notes | |

#### UAT-RP-003: Generate Instructor Report

| Field | Value |
|-------|-------|
| Test Case ID | UAT-RP-003 |
| Scenario | View instructor performance |
| Preconditions | Sessions and ratings exist |
| Test Steps | 1. Navigate to Reports |
| | 2. Select Instructor Report |
| Expected Result | Instructor performance displayed |
| Acceptance Criteria | [ ] Sessions per instructor |
| | [ ] Average ratings |
| Result | PASS/FAIL |
| Notes | |

---

### 4.8 Security (SC)

#### UAT-SC-001: Permission - View Programs

| Field | Value |
|-------|-------|
| Test Case ID | UAT-SC-001 |
| Scenario | Access denied without permission |
| Preconditions | User without TRAINING_VIEW_PROGRAM |
| Test Steps | 1. User attempts to access Programs page |
| Expected Result | Access denied message |
| Acceptance Criteria | [ ] Error message shown |
| | [ ] No data displayed |
| Result | PASS/FAIL |
| Notes | |

#### UAT-SC-002: Permission - Manage Programs

| Field | Value |
|-------|-------|
| Test Case ID | UAT-SC-002 |
| Scenario | Create denied without permission |
| Preconditions | User without TRAINING_MANAGE_PROGRAM |
| Test Steps | 1. User attempts to create program |
| Expected Result | Access denied message |
| Acceptance Criteria | [ ] Error message shown |
| | [ ] Program not created |
| Result | PASS/FAIL |
| Notes | |

---

### 4.9 Integration (INT)

#### UAT-INT-001: Employee Dropdown Populated

| Field | Value |
|-------|-------|
| Test Case ID | UAT-INT-001 |
| Scenario | Verify FA employees in dropdown |
| Preconditions | Employees exist in FA |
| Test Steps | 1. Navigate to enrollment create |
| | 2. View employee dropdown |
| Expected Result | Employees from FA displayed |
| Acceptance Criteria | [ ] Employee names shown |
| | [ ] Can select employee |
| Result | PASS/FAIL |
| Notes | |

#### UAT-INT-002: Self-Enrollment Prerequisites Check

| Field | Value |
|-------|-------|
| Test Case ID | UAT-INT-002 |
| Scenario | Verify prerequisites checked |
| Preconditions | Program requires prerequisites |
| Test Steps | 1. Employee attempts self-enrollment |
| | 2. Has not completed prerequisites |
| Expected Result | Enrollment blocked with message |
| AcceptanceCriteria | [ ] Message shown |
| | [ ] Prerequisites listed |
| Result | PASS/FAIL |
| Notes | |

---

## 5. UAT Execution

### 5.1 Execution Checklist

- [ ] All test cases reviewed
- [ ] Test environment ready
- [ ] Test data loaded
- [ ] Test users configured
- [ ] Test cases executed
- [ ] Results documented
- [ ] Defects logged

### 5.2 Sign-off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Training Manager | | | |
| QA Lead | | | |
| Development Lead | | | |

---

## 6. Test Results Summary

### 6.1 Results Summary

| Category | Total | Passed | Failed | Pass Rate |
|----------|-------|--------|--------|----------|
| Training Program | 5 | | | |
| Course Management | 3 | | | |
| Enrollment Management | 5 | | | |
| Instructor Management | 3 | | | |
| Session Scheduling | 3 | | | |
| Dashboard | 2 | | | |
| Reports | 3 | | | |
| Security | 2 | | | |
| Integration | 2 | | | |
| **TOTAL** | **28** | | | |

### 6.2 Defects Found

| Defect ID | Test Case | Severity | Description | Status |
|-----------|----------|----------|-------------|--------|
| | | | | |

---

## 7. UAT Completion

### 7.1 Completion Criteria

- [ ] All critical test cases pass
- [ ] No high-severity defects open
- [ ] All test data cleaned up
- [ ] Sign-off obtained

### 7.2 Final Sign-off

This module is approved for production deployment.

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Business Owner | | | |
| Training Manager | | | |
| QA Lead | | | |

---
