# Horus

> Modern university platform built with Flutter, designed for students, faculty, academic leadership, and student affairs.

<div align="center">
  <img src="assets/images/Logo_light.png" width="140" alt="Horus Logo">
  <br>
  <strong>Smart University Platform</strong>
  <br>
  Academic Operations • Student Services • Campus Life • Social Feed
</div>

---

## Overview

**Horus** is a full-featured university platform built in Flutter to unify academic, student-service, and community workflows in one system.

It provides a single digital environment for:
- Students
- Teaching staff
- Academic leadership
- Student affairs teams

Horus combines:
- role-based access control
- academic dashboards
- course registration workflows
- notifications
- institutional information
- internal social feed features
- multilingual user experience

The result is a modern, scalable university portal that is easier to manage, easier to extend, and easier for users to navigate.

---

## Arabic Summary | ملخص عربي

**حورس** هو نظام جامعي حديث مبني باستخدام Flutter، يهدف إلى توحيد الخدمات الأكاديمية وخدمات الطلاب والمجتمع داخل منصة واحدة.

يوفر النظام بيئة رقمية موحدة تخدم:
- الطلاب
- أعضاء هيئة التدريس
- القيادات الأكاديمية
- شؤون الطلاب

ويجمع بين:
- نظام صلاحيات متقدم
- لوحات أكاديمية وخدمية
- تسجيل المقررات
- الإشعارات
- عرض بيانات الكليات والأقسام
- منشورات داخلية وتواصل مؤسسي
- دعم متعدد اللغات

---

## Key Highlights

- Built with **Flutter** for multi-platform delivery
- Powered by **Supabase** for backend services
- Structured with a **feature-first modular architecture**
- Uses **Riverpod** for state management
- Uses **GoRouter** for app navigation
- Supports **Arabic, English, German, and Chinese**
- Designed with a modern UI system including glass-style interfaces and rich animations
- Supports multiple user roles with granular permissions

---

## Core Features

### 1) Authentication and Identity
- Secure sign-in flow
- Password recovery
- Profile loading and session handling
- Role-aware user experience

### 2) Role-Based Access Control
Horus includes a granular permissions model covering multiple institutional roles such as:
- Students
- Professors
- Lecturers
- Teaching assistants
- Academic advisors
- Deans and department heads

Permissions control what each user can:
- view
- create
- approve
- manage
- configure

### 3) Student Experience
- Student dashboard
- Digital ID
- Transcript and academic progress
- Attendance and schedules
- Exam schedule
- Subject results
- Registration and payments
- Invoices and finance-related screens
- Notifications and support access

### 4) Staff and Academic Experience
- Staff dashboard
- Grade management
- Attendance management
- TA and group management
- Academic advising workflows
- Course and schedule management
- Student record access based on permissions

### 5) Enrollment Workflows
- Course selection
- Section and schedule selection
- Registration request submission
- Advisor approval flow
- Dean/advisor assignment views

### 6) Community and Communication
- Internal feed
- Posts and announcements
- Comments and likes
- Notifications center
- Forums and tutorial access

### 7) Settings and Preferences
- Theme switching
- UI style switching
- Language selection
- Notification preferences
- About and privacy pages

---

## Technology Stack

| Area | Technology |
|---|---|
| Frontend | Flutter |
| Language | Dart |
| State Management | Riverpod |
| Routing | GoRouter |
| Backend | Supabase |
| Localization | Slang |
| Animations | flutter_animate |
| Local Storage | shared_preferences |

---

## Project Structure

```text
lib/
├── core/
│   ├── app/
│   ├── auth/
│   ├── config/
│   ├── data/
│   ├── error/
│   ├── i18n/
│   ├── router/
│   ├── security/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── academic/
│   ├── admin/
│   ├── auth/
│   ├── colleges/
│   ├── enrollment/
│   ├── feed/
│   ├── home/
│   ├── onboarding/
│   ├── settings/
│   ├── shared/
│   ├── splash/
│   ├── students/
│   └── welcome/
│
└── main.dart
```

### Architecture Notes
- Feature-first organization
- Clear separation between core infrastructure and feature modules
- Repositories used for data access
- Presentation layer separated from data models and providers
- Designed for maintainability and extension

---

## Supported Platforms

Horus is structured for multi-platform support across:
- Android
- iOS
- macOS
- Linux
- Windows
- Web

> Platform-specific identifiers and app naming have been aligned to **Horus**.

---

## Environment Setup

### Requirements
- Flutter SDK
- Dart SDK
- Supabase project and keys

### Setup Steps

1. Clone the repository
```bash
git clone <repository_url>
cd Horus
```

2. Install dependencies
```bash
flutter pub get
```

3. Configure environment values
Create or provide the required environment configuration for:
- `SUPABASE_URL`
- `SUPABASE_PUBLISHABLE_KEY` (preferred; `SUPABASE_ANON_KEY` remains supported for existing CI)
- any additional API values used by the app

The default URL targets the existing Horus project (`reyvrbvdgojpnbecvzwn`).
Copy `.env.example` to `.env`, obtain that project's publishable key, and keep
`.env` uncommitted. Never use a secret or `service_role` key in Flutter.

4. Generate code if needed
```bash
dart run build_runner build -d
dart run slang
```

5. Run the app
```bash
flutter run --dart-define-from-file=.env
```

Android builds use JDK 17 with the checked-in Gradle, Android Gradle Plugin,
and Kotlin Gradle Plugin versions. If Flutter selects another Java installation,
point it to a JDK 17 directory with `flutter config --jdk-dir=/path/to/jdk-17`.

---

## Development Notes

### Package Name
The internal Dart package name has been unified to:
- `horus`

### Branding
The visible project/app identity has been unified as:
- **Horus**

### Recommended Next Branding Step
If this project is moving toward production, replace placeholder bundle identifiers such as:
- `com.example.horus`

with your final production identifier, for example:
- `com.gt.horus`
- `com.axe.horus`
- or your organization’s official namespace

---

## Security and Access

Horus is designed around institutional access boundaries.

Key principles include:
- authenticated access
- role-aware routing
- permission-gated sections
- controlled administrative operations
- backend-backed data access policies

For production deployment, it is recommended to additionally review:
- final bundle identifiers
- signing configuration
- environment management
- secret handling
- release pipeline controls
- Supabase security policies

---

## Status

Current project state indicates:
- strong UI maturity
- broad feature coverage
- modular code organization
- multi-role academic platform scope

This makes Horus suitable as a strong internal platform foundation, advanced prototype, or near-production institutional system depending on completion of deployment hardening and final integration details.

---

## Ownership, Rights, and Credits

### Intellectual Property Notice
**Horus is a proprietary project.**
All rights related to the system design, implementation, structure, branding, and project materials are reserved.

### Company Rights
**GT** retains company rights associated with this project and its protected assets, documentation, implementation work, and related deliverables, unless otherwise defined by separate written agreement.

### Supervision and Development
This project was developed under the **supervision and development leadership of Axe**.

### Internal Use and Distribution
Unauthorized copying, resale, redistribution, publication, or reuse of this project or its components without explicit permission is prohibited.

---

## Suggested Future Improvements

- finalize production bundle identifiers
- complete any placeholder screens or actions
- add CI/CD workflows
- add deployment documentation
- add release signing and environment profiles
- expand testing coverage
- document backend schema and policies
- add architecture diagrams for onboarding new developers

---

## Quick Navigation

For faster access, start here:
- `lib/main.dart` → app entry point
- `lib/core/app/` → app shell
- `lib/core/router/` → navigation
- `lib/core/auth/` → roles and permissions
- `lib/features/students/` → student flows
- `lib/features/staff/` → staff and academic workflows
- `lib/features/institutional/` → colleges and departments data
- `lib/features/enrollment/` → registration and finance flows
- `lib/features/feed/` → feed and announcements
- `lib/features/settings/` → user preferences and app info

---

## Maintainer Note

This README was rebuilt to be:
- clearer
- more modern
- easier to scan
- easier to onboard from
- more explicit about ownership and project identity

If needed, the next improvement can be:
1. a developer-focused README
2. an architecture README
3. a deployment README
4. an Arabic-first version of this document

---

<div align="center">
  <strong>Horus</strong>
  <br>
  Built with care for modern academic operations.
  <br><br>
  <strong>Rights reserved by GT</strong>
  <br>
  Under the supervision and development of <strong>Axe</strong>
</div>
