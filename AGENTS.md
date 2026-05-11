# AGENTS.md - ksf_FA_Training#

## Architecture Overview#

**FA Module** for Training Management - courses, enrollments, and certifications.

### Core Principles#
- **SOLID**, **DRY**, **TDD**, **DI**, **SRP**#

## Repository Structure#

```
ksf_FA_Training/
├── sql/#
│   ├── fa_training_courses.sql#
│   ├── fa_training_enrollments.sql#
│   ├── fa_training_sessions.sql#
│   └── fa_training_certifications.sql#
├── includes/#
│   ├── courses_db.inc#
│   ├── enrollments_db.inc#
│   ├── sessions_db.inc#
│   └── certifications_db.inc#
├── pages/#
├── hooks.php#
├── composer.json#
└── ProjectDocs/#
```

## Dependencies#

- **ksf_FA_Training_Core** (business logic)#
- **ksf_FA_HRM** (link to employees)#
- **FrontAccounting 2.4+**#
