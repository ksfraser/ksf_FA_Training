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

## Development Workflow

All development is done in the **devel tree** (`~/Documents/ksf_FA_Training`). Do **not** edit files in the UAT bind point directly.

### Workflow Steps
1. **Develop** in this repo (feature branches preferred)
2. **Test**: run repo-appropriate tests
3. **Lint**: `php -l` on modified PHP files (no syntax errors)
4. **Commit** and **Push** branch to GitHub
5. **Merge** to `master` when ready
6. **Push** `master` to GitHub
7. **Deploy** to UAT by pulling in the Infrastructure bind point:

   ```
   cd ~/ksf_Infrastructure/fa_modules/ksf_FA_Training
   git stash -u
   git pull origin master
   git stash pop
   ```

### UAT Bind Point
| Path | Purpose |
|------|---------|
| `~/Documents/ksf_FA_Training` | Devel tree — all development, testing, commits |
| `~/ksf_Infrastructure/fa_modules/ksf_FA_Training` | UAT bind point — deployment target, integration testing (if mirrored) |

