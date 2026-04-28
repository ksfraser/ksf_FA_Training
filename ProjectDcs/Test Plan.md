# Test Plan - ksf_FA_Training

## Overview

This document outlines the test strategy, test types, test cases, and acceptance criteria for the Training Management module.

---

## 1. Test Strategy

### 1.1 Test Objectives

- Verify all functional requirements are met
- Ensure data integrity and consistency
- Validate integration with FA core
- Confirm security controls work correctly
- Achieve code quality standards

### 1.2 Test Levels

| Level | Description | Coverage Target |
|-------|-------------|---------------|
| Unit Testing | Individual function/method testing | Core business logic |
| Integration Testing | Module integration with FA | All integrations |
| System Testing | End-to-end workflows | Critical paths |
| User Acceptance Testing | Business user validation | All use cases |

### 1.3 Test Types

| Type | Description |
|------|-------------|
| Functional Testing | Feature verification |
| Regression Testing | Existing functionality |
| Security Testing | Permission and access |
| Performance Testing | Response times |
| UI/UX Testing | User interface |

---

## 2. Test Environment

### 2.1 Environment Requirements

- FrontAccounting 2.4.0+ installed
- PHP 8.0+
- MySQL 5.7+
- Web browser (Chrome/Firefox/Edge)
- Sample data loaded

### 2.2 Test Data

**Required Test Data**:
- At least 5 sample training programs (different statuses)
- At least 10 sample enrollments
- At least 3 sample instructors
- At least 5 sample employees for enrollment

---

## 3. Test Cases

### 3.1 Training Program Tests

#### TC-TR-001: Create New Training Program

| Field | Value |
|-------|-------|
| Test ID | TC-TR-001 |
| Description | Create a new training program with all required fields |
| Preconditions | User has TRAINING_MANAGE_PROGRAM permission |
| Steps | 1. Navigate to Programs page |
| | 2. Click "New Program" |
| | 3. Fill required fields |
| | 4. Click Save |
| Expected Result | Program saved to database, appears in list |
| Pass Criteria | Program visible in list with correct data |

#### TC-TR-002: View Program List

| Field | Value |
|-------|-------|
| Test ID | TC-TR-002 |
| Description | View list of all training programs |
| Preconditions | User has TRAINING_VIEW_PROGRAM permission |
| Steps | 1. Navigate to Programs page |
| | 2. View displayed list |
| Expected Result | Programs displayed in table format |
| Pass Criteria | All columns display correctly |

#### TC-TR-003: Search Programs

| Field | Value |
|-------|-------|
| Test ID | TC-TR-003 |
| Description | Search for programs by name |
| Preconditions | Programs exist in database |
| Steps | 1. Navigate to Programs page |
| | 2. Enter search term |
| | 3. Click Search |
| Expected Result | Matching programs displayed |
| Pass Criteria | Only matching programs shown |

#### TC-TR-004: Filter Programs by Status

| Field | Value |
|-------|-------|
| Test ID | TC-TR-004 |
| Description | Filter programs by status |
| Preconditions | Programs exist with different statuses |
| Steps | 1. Navigate to Programs page |
| | 2. Click status filter link |
| Expected Result | Only programs with selected status shown |
| Pass Criteria | Correct filtering applied |

#### TC-TR-005: Edit Program

| Field | Value |
|-------|-------|
| Test ID | TC-TR-005 |
| Description | Modify existing program |
| Preconditions | Program exists |
| Steps | 1. Navigate to Programs page |
| | 2. Click Edit on program |
| | 3. Modify fields |
| | 4. Click Save |
| Expected Result | Program updated |
| Pass Criteria | Changes reflected in list |

#### TC-TR-006: Delete Program

| Field | Value |
|-------|-------|
| Test ID | TC-TR-006 |
| Description | Delete a program |
| Preconditions | Test program exists |
| Steps | 1. Navigate to program edit |
| | 2. Click Delete |
| | 3. Confirm deletion |
| Expected Result | Program removed |
| Pass Criteria | Program no longer in list |

#### TC-TR-007: Set Program Status

| Field | Value |
|-------|-------|
| Test ID | TC-TR-007 |
| Description | Change program status |
| Preconditions | Program exists in Draft status |
| Steps | 1. Edit program |
| | 2. Change status to Published |
| | 3. Save |
| Expected Result | Status changed |
| Pass Criteria | Status displays correctly |

---

### 3.2 Course Management Tests

#### TC-CO-001: Create Course

| Field | Value |
|-------|-------|
| Test ID | TC-CO-001 |
| Description | Create a new course under a program |
| Preconditions | Program exists, user has TRAINING_MANAGE_PROGRAM |
| Steps | 1. Navigate to Courses page |
| | 2. Click "New Course" |
| | 3. Fill required fields |
| | 4. Assign to program |
| | 5. Save |
| Expected Result | Course saved and associated with program |
| Pass Criteria | Course visible in course list |

#### TC-CO-002: View Courses by Program

| Field | Value |
|-------|-------|
| Test ID | TC-CO-002 |
| Description | View courses filtered by program |
| Preconditions | Courses exist under programs |
| Steps | 1. Navigate to Courses page |
| | 2. Select program from filter |
| Expected Result | Only courses from selected program shown |
| Pass Criteria | Correct filtering |

#### TC-CO-003: Assign Instructor to Course

| Field | Value |
|-------|-------|
| Test ID | TC-CO-003 |
| Description | Assign instructor to course |
| Preconditions | Course exists, instructor exists |
| Steps | 1. Edit course |
| | 2. Select instructor |
| | 3. Save |
| Expected Result | Instructor assigned |
| Pass Criteria | Instructor shows in course details |

---

### 3.3 Enrollment Management Tests

#### TC-EN-001: Create Enrollment

| Field | Value |
|-------|-------|
| Test ID | TC-EN-001 |
| Description | Enroll employee in training program |
| Preconditions | Program exists, employee exists, user has TRAINING_MANAGE_ENROLLMENT |
| Steps | 1. Navigate to Enrollments page |
| | 2. Click "New Enrollment" |
| | 3. Select program |
| | 4. Select employee |
| | 5. Save |
| Expected Result | Employee enrolled |
| Pass Criteria | Employee appears in enrollment list |

#### TC-EN-002: View Enrollments

| Field | Value |
|-------|-------|
| Test ID | TC-EN-002 |
| Description | View enrollment list |
| Preconditions | Enrollments exist |
| Steps | 1. Navigate to Enrollments page |
| Expected Result | Enrollments displayed |
| Pass Criteria | All relevant fields shown |

#### TC-EN-003: Update Enrollment Status

| Field | Value |
|-------|-------|
| Test ID | TC-EN-003 |
| Description | Update enrollment status |
| Preconditions | Enrollment exists |
| Steps | 1. Edit enrollment |
| | 2. Mark attendance |
| | 3. Set completion status |
| | 4. Save |
| Expected Result | Status updated |
| Pass Criteria | Status reflected in list |

#### TC-EN-004: Cancel Enrollment

| Field | Value |
|-------|-------|
| Test ID | TC-EN-004 |
| Description | Cancel enrollment |
| Preconditions | Enrollment exists |
| Steps | 1. Edit enrollment |
| | 2. Change status to Cancelled |
| | 3. Save |
| Expected Result | Enrollment cancelled |
| Pass Criteria | Status shows Cancelled |

#### TC-EN-005: Waitlist Handling

| Field | Value |
|-------|-------|
| Test ID | TC-EN-005 |
| Description | Test waitlist when capacity reached |
| Preconditions | Program at capacity |
| Steps | 1. Attempt to enroll employee |
| Expected Result | Added to waitlist |
| Pass Criteria | Status shows Waitlisted |

---

### 3.4 Instructor Management Tests

#### TC-IN-001: Add Instructor

| Field | Value |
|-------|-------|
| Test ID | TC-IN-001 |
| Description | Add new instructor |
| Preconditions | Employee exists |
| Steps | 1. Navigate to Instructors |
| | 2. Click "Add Instructor" |
| | 3. Select employee |
| | 4. Add specialization |
| | 5. Save |
| Expected Result | Instructor added |
| Pass Criteria | Instructor in list |

#### TC-IN-002: View Instructors

| Field | Value |
|-------|-------|
| Test ID | TC-IN-002 |
| Description | View instructor list |
| Preconditions | Instructors exist |
| Steps | 1. Navigate to Instructors |
| Expected Result | Instructors displayed |
| Pass Criteria | All details shown |

#### TC-IN-003: Rate Instructor

| Field | Value |
|-------|-------|
| Test ID | TC-IN-003 |
| Description | Rate an instructor |
| Preconditions | Instructor exists |
| Steps | 1. View instructor |
| | 2. Submit rating |
| | 3. Add feedback |
| Expected Result | Rating saved |
| Pass Criteria | Average rating updated |

---

### 3.5 Session Scheduling Tests

#### TC-SS-001: Create Session

| Field | Value |
|-------|-------|
| Test ID | TC-SS-001 |
| Description | Create training session |
| Preconditions | Program exists |
| Steps | 1. Navigate to Schedule |
| | 2. Click "New Session" |
| | 3. Select program |
| | 4. Set date, time, location |
| | 5. Save |
| Expected Result | Session created |
| Pass Criteria | Session in schedule |

#### TC-SS-002: Calendar View

| Field | Value |
|-------|-------|
| Test ID | TC-SS-002 |
| Description | View training calendar |
| Preconditions | Sessions exist |
| Steps | 1. Navigate to Schedule |
| | 2. Switch to calendar view |
| Expected Result | Sessions displayed on calendar |
| Pass Criteria | Dates and times correct |

---

### 3.6 Dashboard Tests

#### TC-DB-001: Dashboard Statistics

| Field | Value |
|-------|-------|
| Test ID | TC-DB-001 |
| Description | Verify dashboard shows correct statistics |
| Preconditions | Data exists in database |
| Steps | 1. Navigate to Dashboard |
| Expected Result | Dashboard shows counts |
| Pass Criteria | Total, Active, Completion counts correct |

#### TC-DB-002: Recent Activities

| Field | Value |
|-------|-------|
| Test ID | TC-DB-002 |
| Description | Verify recent activities display |
| Preconditions | Activities logged |
| Steps | 1. Navigate to Dashboard |
| Expected Result | Recent activities listed |
| Pass Criteria | Last 5-10 activities shown |

---

### 3.7 Report Tests

#### TC-RP-001: Enrollment Report

| Field | Value |
|-------|-------|
| Test ID | TC-RP-001 |
| Description | Generate enrollment report |
| Preconditions | Enrollments exist |
| Steps | 1. Navigate to Reports |
| | 2. Select Enrollment Report |
| Expected Result | Status breakdown displayed |
| Pass Counts accurate |

#### TC-RP-002: Completion Report

| Field | Value |
|-------|-------|
| Test ID | TC-RP-002 |
| Description | Generate completion report |
| Preconditions | Enrollments with completions |
| Steps | 1. Navigate to Reports |
| | 2. Select Completion Report |
| Expected Result | Completion rates displayed |
| Pass Criteria | Rates accurate by program |

---

### 3.8 Security Tests

#### TC-SC-001: Permission - View Program

| Field | Value |
|-------|-------|
| Test ID | TC-SC-001 |
| Description | User without permission cannot view programs |
| Preconditions | User lacks TRAINING_VIEW_PROGRAM |
| Steps | 1. User attempts to access Programs page |
| Expected Result | Access denied error |
| Pass Criteria | Error message displayed |

#### TC-SC-002: Permission - Manage Program

| Field | Value |
|-------|-------|
| Test ID | TC-SC-002 |
| Description | User without permission cannot create programs |
| Preconditions | User lacks TRAINING_MANAGE_PROGRAM |
| Steps | 1. User attempts to create program |
| Expected Result | Access denied error |
| Pass Criteria | Error message displayed |

---

### 3.9 Integration Tests

#### TC-INT-001: Employee Integration

| Field | Value |
|-------|-------|
| Test ID | TC-INT-001 |
| Description | Employee dropdown populated from FA |
| Preconditions | Employees exist |
| Steps | 1. Navigate to enrollment create |
| | 2. View employee dropdown |
| Expected Result | Employees from FA loaded |
| Pass Criteria | Employee names displayed |

#### TC-INT-002: Self-Enrollment Workflow

| Field | Value |
|-------|-------|
| Test ID | TC-INT-002 |
| Description | Employee self-enrolls in program |
| Preconditions | Program published, self-enrollment enabled |
| Steps | 1. Employee logs in |
| | 2. Views available programs |
| | 3. Enrolls in program |
| Expected Result | Enrollment created |
| Pass Criteria | Enrollment in list |

---

## 4. Test Execution

### 4.1 Execution Order

1. Unit tests (via phpunit)
2. Integration tests
3. System tests
4. UAT

### 4.2 Test Results Template

| Test ID | Test Name | Status | Notes |
|---------|-----------|--------|-------|
| TC-TR-001 | Create New Training Program | PASS/FAIL | |
| TC-TR-002 | View Program List | PASS/FAIL | |

### 4.3 Defect Reporting

| Field | Description |
|-------|-------------|
| Defect ID | Unique identifier |
| Test ID | Related test case |
| Severity | Critical/Major/Minor |
| Description | Detailed description |
| Steps to Reproduce | Reproduction steps |
| Expected Result | What should happen |
| Actual Result | What actually happened |

---

## 5. Acceptance Criteria

### 5.1 Functional Acceptance

| Requirement ID | Description | Test Coverage |
|----------------|-------------|---------------|
| FR-1.1 | Create Program | TC-TR-001 |
| FR-1.2 | View Programs | TC-TR-002 |
| FR-1.3 | Edit Program | TC-TR-005 |
| FR-1.4 | Delete Program | TC-TR-006 |
| FR-2.1 | Create Course | TC-CO-001 |
| FR-3.1 | Create Enrollment | TC-EN-001 |
| FR-3.2 | View Enrollments | TC-EN-002 |
| FR-4.1 | Add Instructor | TC-IN-001 |
| FR-5.1 | Create Session | TC-SS-001 |
| FR-7.1 | Dashboard | TC-DB-001 |

### 5.2 Non-Functional Acceptance

| Criteria | Target |
|----------|--------|
| Page Load Time | < 3 seconds |
| Database Queries | < 10 per page |
| Browser Compatibility | Chrome, Firefox, Edge |
| Access Control | All permissions enforced |
| Data Validation | All inputs validated |

---

## 6. Test Deliverables

| Deliverable | Description |
|-------------|-------------|
| Test Cases | This document |
| Test Data | Sample data for testing |
| Test Results | Execution results log |
| Defect Log | Issues found during testing |
| Test Summary | Final pass/fail report |

---

## 7. Test Schedule

| Phase | Duration | Activities |
|-------|----------|-----------|
| Unit Testing | 1 day | phpunit execution |
| Integration Testing | 2 days | Integration tests |
| System Testing | 3 days | End-to-end workflows |
| UAT | 5 days | User acceptance |
| Bug Fixing | Ongoing | Fix and retest |

---

## 8. Risk Management

### 8.1 Test Risks

| Risk | Mitigation |
|------|-------------|
| Test data not available | Create sample data first |
| Environment issues | Use isolated test environment |
| Scope creep | Track changes to requirements |
