# HUE — التقرير الشامل للتطبيق

> **آخر تحديث:** 02 مارس 2026 · إضافة إدارة الكليات والأقسام المتقدمة وإضافة قاعدة بيانات المشاريع

---

## 📌 الفهرس

1. [نظرة عامة](#1-نظرة-عامة)
2. [حالة الكود — Flutter Analyze](#2-حالة-الكود)
3. [التقنيات والمكتبات](#3-التقنيات-والمكتبات)
4. [المعمارية والهيكل](#4-المعمارية-والهيكل)
5. [نظام الأدوار والصلاحيات](#5-نظام-الأدوار)
6. [مصفوفة الوصول — من يرى ماذا؟](#6-مصفوفة-الوصول)
7. [خريطة المسارات الكاملة](#7-خريطة-المسارات)
8. [النواقص والتحذيرات](#8-النواقص)
9. [تفاصيل الصفحات](#9-تفاصيل-الصفحات)
10. [توصيات التحسين](#10-توصيات-التحسين)
11. [الإحصائيات الختامية](#11-الإحصائيات)

---

## 1. نظرة عامة

**HUE** هو تطبيق Flutter متكامل لإدارة الحياة الجامعية، يخدم الطلاب، الأساتذة، والإدارة. مبني على Clean Architecture مع Supabase، يدعم 4 لغات ونمطين بصريين.

| البُعد           | القيمة                             |
| ---------------- | ---------------------------------- |
| إجمالي الصفحات   | **61 صفحة**                        |
| المسارات المسجلة | **54 مساراً**                      |
| الأدوار          | **24 دوراً** في **7 فئات**         |
| الصلاحيات        | **34 صلاحية** مختلفة               |
| اللغات           | AR · EN · DE · ZH                  |
| الأنماط البصرية  | Glass Design · Classic Design      |
| حالة المحلل      | ✅ 0 أخطاء · 0 تحذيرات · 0 إشعارات |

---

## 2. حالة الكود

| النوع    | النتيجة |
| -------- | ------- |
| Errors   | ✅ 0    |
| Warnings | ✅ 0    |
| Info     | ✅ 0    |

### أحدث الإصلاحات المطبَّقة

| الملف                        | الإصلاح                                                                         |
| ---------------------------- | ------------------------------------------------------------------------------- |
| `administration_screen.dart` | إضافة `import 'dart:ui' as ui` لحل تعارض `TextDirection.rtl`                    |
| `administration_screen.dart` | حذف `roles.dart` الزائد، وإصلاح `unnecessary_underscores`                       |
| `invoices_screen.dart`       | إصلاح `unnecessary_underscores`                                                 |
| `settings_screen.dart`       | استبدال `activeColor` المُهمَل بـ `activeThumbColor` (3 مواضع)                  |
| **Institutional Phase 2**    | **إضافة شاشات تفصيلية متطورة للكليات والأقسام مع إدارة العمداء ورؤساء الأقسام** |
| **Database Migration 06**    | **إنشاء جدول `department_projects` لدعم المشاريع البرمجية والبحثية**            |

---

## 3. التقنيات والمكتبات

### 🔵 الأساس

| المكتبة          | الإصدار   | الاستخدام                           |
| ---------------- | --------- | ----------------------------------- |
| Flutter          | stable    | إطار العمل الأساسي                  |
| Dart SDK         | `^3.10.7` | لغة البرمجة                         |
| Supabase Flutter | `^2.0.2`  | قاعدة البيانات + المصادقة + Storage |

### 🟢 إدارة الحالة والتوجيه

| المكتبة             | الإصدار   | الاستخدام                |
| ------------------- | --------- | ------------------------ |
| flutter_riverpod    | `^3.1.0`  | إدارة الحالة الرئيسية    |
| hooks_riverpod      | `^3.1.0`  | دمج Hooks مع Riverpod    |
| flutter_hooks       | `^0.21.3` | برمجة الواجهة بنمط Hooks |
| riverpod_annotation | `^4.0.0`  | تعريف مزودات الحالة      |
| riverpod_generator  | `^4.0.0`  | توليد الكود تلقائياً     |
| go_router           | `^17.1.0` | نظام التنقل بين الصفحات  |

### 🟡 التدويل (i18n)

| المكتبة            | الإصدار   | الاستخدام              |
| ------------------ | --------- | ---------------------- |
| slang              | `^4.0.0`  | نظام الترجمة           |
| slang_flutter      | `^4.0.0`  | تكامل Slang مع Flutter |
| slang_build_runner | `^4.12.1` | توليد ملفات الترجمة    |

### 🟣 واجهة المستخدم

| المكتبة                  | الإصدار  | الاستخدام                               |
| ------------------------ | -------- | --------------------------------------- |
| google_fonts             | `^8.0.1` | الخطوط (Outfit · Inter · ShareTechMono) |
| lucide_icons             | any      | أيقونات الواجهة                         |
| flutter_animate          | `^4.5.2` | الحركات والانتقالات                     |
| loading_animation_widget | `^1.3.0` | مؤشرات التحميل                          |

### 🔴 الأدوات والأمان

| المكتبة            | الإصدار   | الاستخدام              |
| ------------------ | --------- | ---------------------- |
| shared_preferences | `^2.2.2`  | تخزين محلي (الإعدادات) |
| intl               | `^0.20.2` | تنسيق التاريخ والأرقام |
| build_runner       | `^2.4.8`  | توليد الكود            |
| custom_lint        | `^0.8.1`  | قواعد Lint مخصصة       |
| riverpod_lint      | `^3.1.0`  | Lint خاص بـ Riverpod   |
| AXE Fingerprint    | مخصص      | البصمة الأمنية للتطبيق |
| BrandingVerifier   | مخصص      | التحقق من هوية التطبيق |

### 🏗️ نمط توليد الكود

```
lib/features/admin/data/repositories/
├── users_repository.dart         ← الكود الأصلي
└── users_repository.g.dart       ← مولَّد تلقائياً بـ build_runner

lib/features/admin/presentation/providers/
├── users_provider.dart           ← الكود الأصلي
└── users_provider.g.dart         ← مولَّد تلقائياً
```

---

## 4. المعمارية والهيكل

### نمط Clean Architecture

```
Feature/
├── data/
│   ├── models/          — نماذج البيانات (Dart classes)
│   └── repositories/    — التعامل المباشر مع Supabase
├── presentation/
│   ├── providers/       — منطق الحالة (Riverpod Notifiers)
│   ├── screens/         — الصفحات
│   └── widgets/         — مكونات الواجهة
```

### تدفق البيانات

```
Supabase DB
    ↓
Repository (dart class)
    ↓
Riverpod Provider (AsyncNotifier)
    ↓
ConsumerWidget (UI)
```

### نقطة الدخول

```dart
main()
 ├── BrandingVerifier.verify()          — التحقق من هوية التطبيق
 ├── Axe                     — البصمة الأمنية
 ├── Supabase.initialize()              — تهيئة الخلفية
 ├── LocaleSettings.useDeviceLocale()   — اللغة التلقائية للجهاز
 └── runApp(TranslationProvider → ProviderScope → HueApp)
```

### هيكل المجلدات

```
lib/
├── main.dart
├── core/
│   ├── app/             — HueApp widget
│   ├── auth/            — AuthController · AuthState · roles.dart
│   ├── config/          — EnvConfig · BuildConfig
│   ├── i18n/            — ملفات Slang (AR / EN / DE / ZH)
│   ├── router/          — GoRouter · route_guard.dart
│   ├── security/        — Axe · BrandingVerifier
│   ├── theme/           — ThemeProvider · StyleProvider · LowPerfProvider
│   └── utils/           — ResponsiveHelper
└── features/
    ├── academic/         14 صفحة · نماذج · مستودعات
    ├── admin/             9 صفحات · 6 مزودات · 6 مستودعات · 4 نماذج
    ├── auth/              2 صفحة
    ├── enrollment/        5 صفحات · مزودَان
    ├── feed/              1 صفحة
    ├── home/              1 صفحة
    ├── onboarding/        8 صفحات
    ├── settings/          5 صفحات
    ├── shared/            9 صفحات
    ├── splash/            1 صفحة
    ├── students/          2 صفحة
    └── welcome/           1 صفحة
```

---

## 5. نظام الأدوار

### فئات الأدوار (7 فئات)

| الفئة              | الكود                | عدد الأدوار |
| ------------------ | -------------------- | ----------- |
| الإدارة والتقنية   | `adminIT`            | 4           |
| القيادة الأكاديمية | `academicLeadership` | 4           |
| هيئة التدريس       | `teachingStaff`      | 3           |
| شؤون الطلاب        | `studentAffairs`     | 3           |
| أدوار الطلاب       | `studentRoles`       | 5           |
| الخدمات والأمن     | `facilitiesSecurity` | 3           |
| الأدوار الخارجية   | `externalRoles`      | 2           |

---

### جدول الأدوار الكامل مع الصلاحيات

#### 🔴 الإدارة والتقنية (`adminIT`)

| #   | الدور              | الاسم العربي      | المستوى  | الصلاحيات الرئيسية                                              |
| --- | ------------------ | ----------------- | -------- | --------------------------------------------------------------- |
| 1   | `superAdmin`       | مدير النظام العام | 0 — أعلى | **جميع الصلاحيات** (34 من 34)                                   |
| 2   | `admin`            | مسؤول نظام        | 1        | جميع الصلاحيات **عدا** `manageSystem` (33/34)                   |
| 3   | `itSupport`        | المسؤول التقني    | 1        | `manageSystem` · `manageUsers` · `viewAuditLogs` · الملف الشخصي |
| 4   | `financialAuditor` | المراقب المالي    | 2        | `manageFinances` · `viewAuditLogs` · الملف الشخصي               |

#### 🟡 القيادة الأكاديمية (`academicLeadership`)

| #   | الدور                 | الاسم العربي     | المستوى | الصلاحيات الرئيسية                                                                                                                                               |
| --- | --------------------- | ---------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 5   | `rector`              | مدير الجامعة     | 1       | `manageColleges` · `manageDepartments` · `manageCourses` · `manageSchedules` · `approveEnrollments` · `viewAuditLogs` · `manageFinances` · `createAnnouncements` |
| 6   | `dean`                | عميد الكلية      | 2       | `manageDepartments` · `manageCourses` · `manageSchedules` · `approveEnrollments` · `createAnnouncements`                                                         |
| 7   | `departmentHead`      | رئيس القسم       | 3       | `manageCourses` · `manageSchedules` · `approveEnrollments` · `manageTAs` · `createAnnouncements`                                                                 |
| 8   | `academicCoordinator` | المنسق الأكاديمي | 4       | `manageCourses` · `manageSchedules` · `createAnnouncements`                                                                                                      |

#### 🟢 هيئة التدريس (`teachingStaff`)

| #   | الدور               | الاسم العربي      | المستوى | الصلاحيات الرئيسية                                                                                                              |
| --- | ------------------- | ----------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------- |
| 9   | `professor`         | عضو هيئة تدريس    | 3       | `manageGrades` · `manageAttendance` · `createAnnouncements` · `uploadMaterials` · `manageTAs` · `manageGroups` · `accessForums` |
| 10  | `lecturer`          | محاضر             | 4       | `manageGrades` · `manageAttendance` · `createAnnouncements` · `uploadMaterials` · `accessForums`                                |
| 11  | `teachingAssistant` | معيد / مساعد باحث | 5       | `manageAttendance` · `uploadMaterials` · `accessForums`                                                                         |

#### 🔵 شؤون الطلاب (`studentAffairs`)

| #   | الدور              | الاسم العربي         | المستوى | الصلاحيات الرئيسية                                                  |
| --- | ------------------ | -------------------- | ------- | ------------------------------------------------------------------- |
| 12  | `registrarOfficer` | مشرف القبول والتسجيل | 3       | `manageEnrollments` · `approveEnrollments`                          |
| 13  | `academicAdvisor`  | المرشد الأكاديمي     | 4       | `adviseStudents` · `viewGrades` · `viewSchedule` · `viewAttendance` |
| 14  | `librarian`        | أمين المكتبة         | 4       | `manageLibrary` · `uploadMaterials`                                 |

#### 🟣 أدوار الطلاب (`studentRoles`)

| #   | الدور                 | الاسم العربي | المستوى | الصلاحيات الرئيسية                                                                                                      |
| --- | --------------------- | ------------ | ------- | ----------------------------------------------------------------------------------------------------------------------- |
| 15  | `classRepresentative` | رئيس الدفعة  | 5       | `viewGrades` · `viewSchedule` · `enrollCourses` · `submitRatings` · `accessForums` · `createAnnouncements`              |
| 16  | `regularStudent`      | طالب منتظم   | 6       | `viewGrades` · `viewSchedule` · `viewAttendance` · `enrollCourses` · `submitRatings` · `accessForums` · `viewMaterials` |
| 17  | `student`             | طالب         | 7       | `viewGrades` · `viewSchedule` · `viewAttendance` · `enrollCourses` · `viewMaterials`                                    |
| 18  | `freshman`            | طالب مستجد   | 7       | `viewGrades` · `viewSchedule` · `viewAttendance` · `enrollCourses` · `viewMaterials`                                    |
| 19  | `alumni`              | خريج         | 8       | `viewGrades` · `accessForums` · `viewMaterials` · `viewJobBoard`                                                        |

#### ⚪ الخدمات والأمن (`facilitiesSecurity`)

| #   | الدور             | الاسم العربي | المستوى   | الصلاحيات                                                                      |
| --- | ----------------- | ------------ | --------- | ------------------------------------------------------------------------------ |
| 20  | `dormSupervisor`  | مشرف السكن   | 5         | `viewProfile` · `editOwnProfile` · `viewNotifications` · `submitSupportTicket` |
| 21  | `securityOfficer` | مسؤول الأمن  | 5         | `viewProfile` · `viewNotifications` · `submitSupportTicket`                    |
| 22  | `guest`           | زائر         | 10 — أدنى | `viewProfile` فقط                                                              |

#### 🟤 الأدوار الخارجية (`externalRoles`)

| #   | الدور       | الاسم العربي | المستوى | الصلاحيات                                                                     |
| --- | ----------- | ------------ | ------- | ----------------------------------------------------------------------------- |
| 23  | `parent`    | ولي الأمر    | 8       | `viewStudentProgress` · `viewGrades` · `viewAttendance` · `viewNotifications` |
| 24  | `recruiter` | جهة توظيف    | 9       | `viewJobBoard` · `viewProfile`                                                |

---

### قائمة الـ 34 صلاحية

| المجموعة        | الصلاحية              | الوصف                    |
| --------------- | --------------------- | ------------------------ |
| **النظام**      | `manageSystem`        | إدارة النظام بالكامل     |
|                 | `manageUsers`         | إدارة المستخدمين         |
|                 | `viewAuditLogs`       | مشاهدة سجلات التدقيق     |
|                 | `manageFinances`      | إدارة الأمور المالية     |
| **الأكاديمية**  | `manageColleges`      | إدارة الكليات            |
|                 | `manageDepartments`   | إدارة الأقسام            |
|                 | `manageCourses`       | إدارة المقررات           |
|                 | `manageSchedules`     | إدارة الجداول            |
|                 | `approveEnrollments`  | الموافقة على التسجيل     |
| **التدريس**     | `manageGrades`        | إدخال وتعديل الدرجات     |
|                 | `manageAttendance`    | إدارة الحضور             |
|                 | `createAnnouncements` | نشر الإعلانات            |
|                 | `uploadMaterials`     | رفع المواد الدراسية      |
|                 | `manageTAs`           | إدارة المعيدين           |
|                 | `manageGroups`        | إدارة المجموعات          |
| **شؤون الطلاب** | `manageEnrollments`   | إدارة عمليات التسجيل     |
|                 | `adviseStudents`      | إرشاد الطلاب أكاديمياً   |
|                 | `manageLibrary`       | إدارة المكتبة            |
| **الطلاب**      | `viewGrades`          | مشاهدة الدرجات           |
|                 | `viewSchedule`        | مشاهدة الجدول            |
|                 | `viewAttendance`      | مشاهدة الحضور            |
|                 | `enrollCourses`       | التسجيل في المقررات      |
|                 | `submitRatings`       | تقييم أعضاء هيئة التدريس |
|                 | `accessForums`        | الوصول للمنتديات         |
|                 | `viewMaterials`       | مشاهدة المواد الدراسية   |
| **المتابعة**    | `viewStudentProgress` | متابعة تقدم الطالب       |
|                 | `viewJobBoard`        | مشاهدة لوحة التوظيف      |
| **عام**         | `viewProfile`         | مشاهدة الملف الشخصي      |
|                 | `editOwnProfile`      | تعديل الملف الشخصي       |
|                 | `viewNotifications`   | مشاهدة الإشعارات         |
|                 | `submitSupportTicket` | إرسال طلب دعم            |

---

## 6. مصفوفة الوصول

> هذا الجدول مبني مباشرة من `route_guard.dart`.
> ✅ = وصول كامل · ❌ = محجوب كلياً · 👁 = قراءة فقط

### مفتاح الفئات

| الرمز      | الفئة              | الأدوار المشمولة                                                   |
| ---------- | ------------------ | ------------------------------------------------------------------ |
| 🔴 **ADM** | adminIT            | superAdmin · admin · itSupport · financialAuditor                  |
| 🟡 **LED** | academicLeadership | rector · dean · departmentHead · academicCoordinator               |
| 🟢 **TCH** | teachingStaff      | professor · lecturer · teachingAssistant                           |
| 🔵 **AFF** | studentAffairs     | registrarOfficer · academicAdvisor · librarian                     |
| 🟣 **STU** | studentRoles       | classRepresentative · regularStudent · student · freshman · alumni |
| ⚪ **SEC** | facilitiesSecurity | dormSupervisor · securityOfficer · guest                           |
| 🟤 **EXT** | externalRoles      | parent · recruiter                                                 |

---

### صفحات الطلاب

| الصفحة / المسار                  | 🔴 ADM | 🟡 LED | 🟢 TCH | 🔵 AFF | 🟣 STU | ⚪ SEC | 🟤 EXT |
| -------------------------------- | :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| `/students` — لوحة الطالب        |   ✅   |   ❌   |   ❌   |   ❌   |   ✅   |   ❌   |   ❌   |
| `/digital-id` — الهوية الرقمية   |   ✅   |   ❌   |   ❌   |   ❌   |   ✅   |   ❌   |   ❌   |
| `/grades` — الدرجات              |   ✅   |   ❌   |   ❌   |   ✅   |   ✅   |   ❌   |   ❌   |
| `/transcript` — كشف الدرجات      |   ✅   |   ❌   |   ❌   |   ✅   |   ✅   |   ❌   |   ❌   |
| `/progress` — التقدم الأكاديمي   |   ✅   |   ❌   |   ❌   |   ✅   |   ✅   |   ❌   |   ❌   |
| `/subject-result` — نتائج المادة |   ✅   |   ❌   |   ❌   |   ✅   |   ✅   |   ❌   |   ❌   |
| `/action-plan` — خطة العمل       |   ✅   |   ❌   |   ❌   |   ❌   |   ✅   |   ❌   |   ❌   |
| `/registration` — تسجيل المقررات |   ✅   |   ❌   |   ❌   |   ✅   |   ✅   |   ❌   |   ❌   |
| `/payment` — الدفع               |   ✅   |   ❌   |   ❌   |   ❌   |   ✅   |   ❌   |   ❌   |
| `/invoices` — الفواتير           |   ✅   |   ❌   |   ❌   |   ❌   |   ✅   |   ❌   |   ❌   |
| `/attendance` — الحضور           |   ✅   |   ❌   |   ✅   |   ❌   |   ✅   |   ❌   |   ❌   |

### صفحات هيئة التدريس

| الصفحة / المسار              | 🔴 ADM | 🟡 LED | 🟢 TCH | 🔵 AFF | 🟣 STU | ⚪ SEC | 🟤 EXT |
| ---------------------------- | :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| `/professor-dashboard`       |   ✅   |   ✅   |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/professor-profile`         |   ✅   |   ✅   |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/manage-tas` — المعيدون     |   ✅   |   ❌   |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/manage-groups` — المجموعات |   ✅   |   ❌   |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/professor-chat` — المحادثة |   ✅   |   ❌   |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |

### صفحات الإدارة (حصرية)

| الصفحة / المسار                     | 🔴 ADM | 🟡 LED | 🟢 TCH | 🔵 AFF | 🟣 STU | ⚪ SEC | 🟤 EXT |
| ----------------------------------- | :----: | :----: | :----: | :----: | :----: | :----: | :----: |
| `/admin` — لوحة التحكم              |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/users` — إدارة المستخدمين   |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/users/new`                  |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/users/details`              |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/colleges` — الكليات         |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/departments` — الأقسام      |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/audit-logs` — سجلات التدقيق |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/roles` — إدارة الأدوار      |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/admin/monitor` — المراقبة         |   ✅   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| `/students-mgmt`                    |   ✅   |   ❌   |   ❌   |   ✅   |   ❌   |   ❌   |   ❌   |

### صفحات مفتوحة (أي مستخدم مسجل)

> هذه الصفحات ليست في `routePermissions`، لذا يصل إليها أي مستخدم مصادق عليه.

`/home` · `/settings` · `/profile` · `/change-password` · `/about` · `/privacy-policy`  
`/notifications` · `/support` · `/biometrics` · `/sessions` · `/forums` · `/tutorials`  
`/college-details` · `/college-departments` · `/academic-staff` · `/department-detail`  
`/staff-rating-detail` · `/submit-rating` · `/forgot-password` · `/advisor-approval`  
`/dean-assignment` · `/transition`

---

### ملخص الصفحات المقيَّدة

| الفئة                     | عدد الصفحات المحجوبة عنها | الصفحات المحجوبة                                                                     |
| ------------------------- | ------------------------- | ------------------------------------------------------------------------------------ |
| 🟡 **القيادة الأكاديمية** | **16** صفحة محجوبة        | جميع صفحات الطلاب (11) + جميع صفحات المستخدمين الإداريين (9) + manage-tas/groups (2) |
| 🟢 **هيئة التدريس**       | **20** صفحة محجوبة        | جميع صفحات الطلاب (11) + جميع الإدارة (9) + manage-tas الخاصة بالقيادة               |
| 🔵 **شؤون الطلاب**        | **17** صفحة محجوبة        | صفحات التدريس (5) + معظم الإدارة (9) + صفحات طلابية محددة (3)                        |
| 🟣 **الطلاب**             | **21** صفحة محجوبة        | جميع صفحات التدريس (5) + جميع الإدارة (9) + بعض الصفحات الأكاديمية الخاصة (7)        |
| ⚪ **الخدمات والأمن**     | **27** صفحة محجوبة        | كل الصفحات المقيَّدة بدون استثناء                                                    |
| 🟤 **الخارجيون**          | **27** صفحة محجوبة        | كل الصفحات المقيَّدة بدون استثناء                                                    |

> **ملاحظة:** `superAdmin` يصل إلى **كل** الصفحات بدون استثناء (تجاوز مباشر من `canAccessRoute`).

---

## 7. خريطة المسارات

### المسارات العامة (9 مسارات)

| المسار                | الصفحة · الاسم العربي             |
| --------------------- | --------------------------------- |
| `/splash`             | SplashScreen · شاشة البداية       |
| `/` · `/welcome`      | WelcomeScreen · شاشة الترحيب      |
| `/login`              | LoginScreen · تسجيل الدخول        |
| `/language-selection` | LanguageScreen · اختيار اللغة     |
| `/ui-style-selection` | StyleScreen · اختيار النمط البصري |
| `/theme-selection`    | ThemeScreen · اختيار السمة        |
| `/colleges-selection` | CollegesScreen · الكليات          |
| `/transition`         | TransitionScreen · شاشة الانتقال  |

### المسارات المحمية (37 مسار)

| المسار                       | الصفحة · الاسم العربي                                      |
| ---------------------------- | ---------------------------------------------------------- |
| `/home`                      | HomeScreen · الصفحة الرئيسية                               |
| `/settings`                  | SettingsScreen · الإعدادات                                 |
| `/forgot-password`           | ForgotPasswordScreen · نسيت كلمة المرور                    |
| `/profile`                   | ProfileScreen · الملف الشخصي                               |
| `/change-password`           | ChangePasswordScreen · تغيير كلمة المرور                   |
| `/about`                     | AboutScreen · حول التطبيق                                  |
| `/privacy-policy`            | PrivacyPolicyScreen · سياسة الخصوصية                       |
| `/students`                  | StudentDashboardScreen · لوحة الطالب                       |
| `/digital-id`                | DigitalIDScreen · الهوية الرقمية                           |
| `/grades`                    | GradesScreen · الدرجات والنتائج                            |
| `/transcript`                | TranscriptScreen · كشف الدرجات                             |
| `/progress`                  | AcademicProgressScreen · التقدم الأكاديمي                  |
| `/subject-result`            | SubjectResultsScreen · نتائج المادة                        |
| `/action-plan`               | ActionPlanScreen · خطة العمل                               |
| `/schedule`                  | DailyScheduleScreen · الجدول اليومي                        |
| `/exam-schedule`             | ExamScheduleScreen · جدول الامتحانات                       |
| `/attendance`                | AttendanceScreen · الحضور والغياب                          |
| `/courses`                   | CoursesScreen · المقررات الدراسية                          |
| `/registration`              | RegistrationScreen · تسجيل المقررات                        |
| `/payment`                   | PaymentScreen · الدفع الإلكتروني                           |
| `/invoices`                  | InvoicesScreen · الفواتير                                  |
| `/notifications`             | NotificationsScreen · الإشعارات                            |
| `/support`                   | SupportScreen · الدعم الفني                                |
| `/biometrics`                | SecurityScreen · الأمان والخصوصية                          |
| `/sessions`                  | SessionsScreen · الجلسات النشطة                            |
| `/forums`                    | ForumsScreen · المنتديات                                   |
| `/tutorials`                 | TutorialsScreen · الشروحات                                 |
| `/college-details`           | CollegeDetailsScreen · تفاصيل الكلية                       |
| `/college-departments`       | CollegeDepartmentsScreen · أقسام الكلية                    |
| `/academic-staff`            | AcademicStaffScreen · أعضاء هيئة التدريس                   |
| `/department-detail`         | DepartmentDetailScreen · تفاصيل القسم                      |
| `/staff-rating-detail`       | StaffRatingDetailScreen · تفاصيل تقييم الكادر              |
| `/submit-rating`             | SubmitRatingScreen · إرسال التقييم                         |
| `/professor-profile`         | ProfessorProfileScreen · ملف الأستاذ                       |
| `/professor-dashboard`       | ProfessorDashboardScreen · لوحة الأستاذ                    |
| `/manage-tas`                | ManageTasScreen · إدارة المعيدين                           |
| `/manage-groups`             | ManageGroupsScreen · إدارة المجموعات                       |
| `/professor-chat`            | ProfessorChatScreen · محادثة الأستاذ                       |
| `/advisor-approval`          | AdvisorApprovalScreen · موافقة المرشد الأكاديمي            |
| `/dean-assignment`           | DeanAdvisorAssignmentScreen · تعيين المرشدين               |
| `/admin/colleges/details`    | admin_screens.CollegeDetailsScreen · تفاصيل الكلية (إدارة) |
| `/admin/departments/details` | DepartmentDetailsScreen · تفاصيل القسم (إدارة)             |
| `/students-mgmt`             | PlaceholderScreen · إدارة الطلاب (نائبة)                   |

### مسارات الإدارة (9 مسارات)

| المسار                 | الصفحة · الاسم العربي                       |
| ---------------------- | ------------------------------------------- |
| `/admin`               | AdministrationScreen · لوحة التحكم الإدارية |
| `/admin/users`         | UsersListScreen · قائمة المستخدمين          |
| `/admin/users/new`     | UserFormScreen · إنشاء مستخدم جديد          |
| `/admin/users/details` | UserFormScreen · تعديل بيانات المستخدم      |
| `/admin/colleges`      | CollegesManagementScreen · إدارة الكليات    |
| `/admin/departments`   | DepartmentsManagementScreen · إدارة الأقسام |
| `/admin/audit-logs`    | AuditLogsScreen · سجلات التدقيق             |
| `/admin/roles`         | RolesManagementScreen · إدارة الأدوار       |
| `/admin/monitor`       | PlaceholderScreen · المراقبة (نائبة)        |

---

## 8. النواقص والتحذيرات

### ⚠️ مسارات مفقودة في `app_router.dart`

| الصفحة · الاسم العربي                         | المسار المتوقع           | الأثر                                 |
| --------------------------------------------- | ------------------------ | ------------------------------------- |
| `SystemSettingsScreen` · إعدادات النظام       | `/admin/system-settings` | الصفحة تُبنى لكن لا يمكن الوصول إليها |
| `ProfessorsManagementScreen` · إدارة الأساتذة | `/admin/professors`      | الإدارة تملك صفحة أساتذة دون مسار     |
| `FeedScreen` · الموجز الإخباري                | `/feed`                  | لوحة الأخبار غير مُركَّبة في التطبيق  |

### 🔧 صفحات ببيانات وهمية

| الصفحة                     | الموضع                | الأثر                 |
| -------------------------- | --------------------- | --------------------- |
| `ManageTasScreen`          | واجهة الحالة الفارغة  | عرض بيانات غير حقيقية |
| `ProfessorDashboardScreen` | قسم الإجراءات السريعة | رفع وهمي              |
| `StaffRatingDetailScreen`  | قسم المراجعات         | تقييمات وهمية         |

### 🚧 مسارات نائبة

| المسار           | البديل المقترح              |
| ---------------- | --------------------------- |
| `/students-mgmt` | صفحة إدارة الطلاب الكاملة   |
| `/admin/monitor` | صفحة مراقبة الأداء المتقدمة |

---

## 9. تفاصيل الصفحات

### دليل الرموز

| الرمز | المعنى                            |
| ----- | --------------------------------- |
| ✅    | مربوط بـ Supabase أو مزود الحالة  |
| ❌    | واجهة فقط (بيانات ثابتة أو محلية) |
| ⚠️    | بيانات وهمية أو نقص مُبلَّغ عنه   |

---

### 🎓 القسم الأكاديمي — `features/academic`

<details>
<summary><b>AcademicProgressScreen</b> · التقدم الأكاديمي — <code>/progress</code></summary>

| القسم               | الحالة |
| ------------------- | ------ |
| بناء قسم الإكمال    | ❌     |
| بناء عنصر الإحصائية | ❌     |
| بناء بطاقة الفئة    | ❌     |

</details>

<details>
<summary><b>ActionPlanScreen</b> · خطة العمل — <code>/action-plan</code></summary>

| القسم             | الحالة |
| ----------------- | ------ |
| عنصر الخط الزمني  | ❌     |
| بناء رأس التقدم   | ❌     |
| بناء البطاقة      | ❌     |
| بناء قائمة المهام | ❌     |

</details>

<details>
<summary><b>AttendanceScreen</b> · الحضور والغياب — <code>/attendance</code></summary>

| القسم             | الحالة |
| ----------------- | ------ |
| مقياس الحضور      | ❌     |
| بطاقة حضور المقرر | ❌     |
| راسم الخط البياني | ❌     |

</details>

<details>
<summary><b>CoursesScreen</b> · المقررات الدراسية — <code>/courses</code></summary>

| القسم               | الحالة |
| ------------------- | ------ |
| بناء قائمة المقررات | ❌     |
| بناء بطاقة المقرر   | ❌     |

</details>

<details>
<summary><b>DailyScheduleScreen</b> · الجدول اليومي — <code>/schedule</code></summary>

| القسم               | الحالة |
| ------------------- | ------ |
| عنصر الجدول         | ❌     |
| بناء منقي الأيام    | ❌     |
| بناء الحالة الفارغة | ❌     |
| بناء مؤشر البث الحي | ❌     |

</details>

<details>
<summary><b>ExamScheduleScreen</b> · جدول الامتحانات — <code>/exam-schedule</code></summary>

| القسم                  | الحالة |
| ---------------------- | ------ |
| شريط التمرير للتاريخ   | ❌     |
| عداد الامتحان التنازلي | ❌     |
| بطاقة الامتحان         | ❌     |

</details>

<details>
<summary><b>GradesScreen</b> · الدرجات والنتائج — <code>/grades</code></summary>

| القسم               | الحالة |
| ------------------- | ------ |
| رأس المعدل التراكمي | ❌     |
| منقي الفصل الدراسي  | ❌     |
| بطاقة الدرجة        | ❌     |

</details>

<details>
<summary><b>ManageGroupsScreen</b> · إدارة المجموعات — <code>/manage-groups</code> — ✅ مربوط</summary>

| القسم                     | الحالة |
| ------------------------- | ------ |
| حالة إدارة شاشة المجموعات | ✅     |

</details>

<details>
<summary><b>ManageTasScreen</b> · إدارة المعيدين — <code>/manage-tas</code> — ⚠️ بيانات وهمية</summary>

| القسم               | الحالة          |
| ------------------- | --------------- |
| بطاقة المعيد        | ❌              |
| بناء الحالة الفارغة | ⚠️ بيانات وهمية |

</details>

<details>
<summary><b>ProfessorChatScreen</b> · محادثة الأستاذ — <code>/professor-chat</code> — ✅ مربوط</summary>

| القسم                    | الحالة |
| ------------------------ | ------ |
| حالة شاشة محادثة الأستاذ | ✅     |
| بناء جسم المحادثة        | ❌     |
| بناء فقاعة الرسالة       | ❌     |

</details>

<details>
<summary><b>ProfessorDashboardScreen</b> · لوحة الأستاذ — <code>/professor-dashboard</code> — ⚠️ جزئي</summary>

| القسم                  | الحالة          |
| ---------------------- | --------------- |
| شبكة الإدارة           | ✅              |
| لوحة الإجراءات السريعة | ⚠️ بيانات وهمية |
| شبكة إحصائيات بنتو     | ❌              |
| قائمة مجموعات بنتو     | ❌              |

</details>

<details>
<summary><b>ProfessorProfileScreen</b> · ملف الأستاذ — <code>/professor-profile</code></summary>

| القسم                     | الحالة |
| ------------------------- | ------ |
| بناء شريط التطبيق الزجاجي | ❌     |
| بناء الإجراءات السريعة    | ❌     |
| بناء قسم المعيدين         | ❌     |
| بناء قسم المجموعات        | ❌     |
| بناء قسم الملفات المشتركة | ❌     |
| بناء قسم الساعات المكتبية | ❌     |

</details>

<details>
<summary><b>SubjectResultsScreen</b> · نتائج المادة — <code>/subject-result</code> — 3 تخطيطات</summary>

| القسم                      | الحالة |
| -------------------------- | ------ |
| التخطيط الغامر (Immersive) | ❌     |
| التخطيط التحليلي           | ❌     |
| التخطيط المبسط             | ❌     |

</details>

<details>
<summary><b>TranscriptScreen</b> · كشف الدرجات — <code>/transcript</code></summary>

| القسم                   | الحالة |
| ----------------------- | ------ |
| الملخص الأكاديمي        | ❌     |
| عقدة الخط الزمني للفصول | ❌     |
| بطاقة مقرر كشف الدرجات  | ❌     |

</details>

---

### 🛡️ قسم الإدارة — `features/admin`

> إعادة بناء كاملة · تصميم Futuristic · مربوط بـ Supabase عبر 6 مزودات

**المزودات:**

| المزود                     | الوظيفة                       |
| -------------------------- | ----------------------------- |
| `admin_stats_provider`     | إحصائيات المستخدمين الحية     |
| `performance_provider`     | مراقبة زمن الاستجابة          |
| `roles_provider`           | إدارة الأدوار                 |
| `users_provider`           | عمليات إدارة المستخدمين       |
| `audit_repository`         | مستودع سجلات التدقيق          |
| `institutional_repository` | مستودع المؤسسات (كليات/أقسام) |

<details>
<summary><b>AdministrationScreen ⭐</b> · لوحة التحكم الإدارية — <code>/admin</code> — ✅ مُعاد بناؤه (1277 سطر)</summary>

| القسم                  | الوظيفة             | الحالة |
| ---------------------- | ------------------- | ------ |
| رأس لوحة التحكم        | بيانات المستخدم     | ✅     |
| قسم الإحصائيات الحية   | إحصائيات حية        | ✅     |
| لوحة الإجراءات السريعة | إجراءات سريعة       | ✅     |
| شبكة وحدات النظام      | 8 وحدات نظامية      | ✅     |
| قسم نبض النظام         | مراقب الأداء        | ✅     |
| قسم تحليل الأدوار      | توزيع الأدوار       | ✅     |
| خلفية الإدارة          | خلفية متحركة        | ❌     |
| راسم الشبكة المجسمة    | شبكة ثلاثية الأبعاد | ❌     |

</details>

<details>
<summary><b>AuditLogsScreen</b> · سجلات التدقيق — <code>/admin/audit-logs</code> — ✅</summary>

مربوطة بـ `audit_repository` عبر Supabase.

</details>

<details>
<summary><b>CollegesManagementScreen</b> · إدارة الكليات — <code>/admin/colleges</code> — ✅</summary>

| القسم             | الحالة |
| ----------------- | ------ |
| الجسم الرئيسي     | ✅     |
| بناء الزر الدائري | ❌     |

</details>

<details>
<summary><b>DepartmentsManagementScreen</b> · إدارة الأقسام — <code>/admin/departments</code> — ✅</summary>

| القسم             | الحالة |
| ----------------- | ------ |
| الجسم الرئيسي     | ✅     |
| بناء الزر الدائري | ❌     |

</details>

<details>
<summary><b>ProfessorsManagementScreen</b> · إدارة الأساتذة — ⚠️ مسار مفقود</summary>

الصفحة مكتملة، لكن `/admin/professors` غير مسجل في `app_router.dart`.

</details>

<details>
<summary><b>RolesManagementScreen</b> · إدارة الأدوار — <code>/admin/roles</code> — ✅</summary>

| القسم                   | الحالة |
| ----------------------- | ------ |
| حالة شاشة إدارة الأدوار | ✅     |
| عنصر الرتبة (Tile)      | ✅     |
| حالة حوار تحرير الرتبة  | ✅     |
| حوار تحرير الرتبة       | ❌     |

</details>

<details>
<summary><b>SystemSettingsScreen</b> · إعدادات النظام — ⚠️ مسار مفقود</summary>

`/admin/system-settings` غير مسجل في `app_router.dart`.

</details>

<details>
<summary><b>UserFormScreen</b> · نموذج المستخدم — <code>/admin/users/new</code> & <code>/admin/users/details</code> — ✅</summary>

| القسم                    | الحالة |
| ------------------------ | ------ |
| حالة شاشة نموذج المستخدم | ✅     |
| بناء منطقة الإدارة       | ✅     |
| بناء الحقل               | ❌     |
| بناء منقي الأدوار        | ❌     |

</details>

<details>
<summary><b>CollegeDetailsScreen (Admin) ⭐</b> · تفاصيل الكلية — <code>/admin/colleges/details</code> — ✅ مربوط</summary>

| القسم               | الحالة | الوظيفة                                     |
| ------------------- | ------ | ------------------------------------------- |
| تخصيص الثيم (Theme) | ✅     | ثيم ديناميكي فريد لكل كلية بناءً على المعرف |
| إدارة العميد (Dean) | ✅     | تعيين وتغيير العميد من قائمة المستخدمين     |
| قائمة الأقسام       | ✅     | عرض ديناميكي للأقسام مع الانتقال للتفاصيل   |

</details>

<details>
<summary><b>DepartmentDetailsScreen (Admin) ⭐</b> · تفاصيل القسم — <code>/admin/departments/details</code> — ✅ مربوط</summary>

| القسم            | الحالة | الوظيفة                                  |
| ---------------- | ------ | ---------------------------------------- |
| إدارة رئيس القسم | ✅     | تعيين وتغيير رئيس القسم مباشرة           |
| مشاريع القسم     | ✅     | مربوط بجدول `department_projects` الجديد |
| الكادر التدريسي  | 👁     | عرض تفصيلي للطاقم (قيد الربط الكامل)     |

</details>

<details>
<summary><b>UsersListScreen</b> · قائمة المستخدمين — <code>/admin/users</code> — ✅</summary>

| القسم                      | الحالة |
| -------------------------- | ------ |
| حالة شاشة قائمة المستخدمين | ✅     |
| بناء قائمة المستخدمين      | ✅     |
| عنصر المستخدم (Tile)       | ❌     |
| شريحة التصفية (Chip)       | ❌     |

</details>

---

### 🔐 المصادقة · 📋 التسجيل · ⚙️ الإعدادات · 🤝 المشترك

<details>
<summary><b>LoginScreen</b> · تسجيل الدخول — <code>/login</code> — ✅ Supabase Auth</summary>
حالة شاشة تسجيل الدخول ✅
</details>

<details>
<summary><b>ForgotPasswordScreen</b> · نسيت كلمة المرور — <code>/forgot-password</code></summary>
واجهة فقط، منطق استرداد كلمة المرور غير مكتمل.
</details>

<details>
<summary><b>InvoicesScreen</b> · الفواتير — <code>/invoices</code> — ✅ مربوط بالكامل</summary>

| القسم                | المزود                     | الحالة |
| -------------------- | -------------------------- | ------ |
| بطاقة الملخص المالي  | `invoiceSummaryProvider`   | ✅     |
| شريط تصفية التبويبات | `invoiceFilterProvider`    | ✅     |
| قائمة الفواتير       | `filteredInvoicesProvider` | ✅     |

</details>

<details>
<summary><b>RegistrationScreen</b> · تسجيل المقررات — <code>/registration</code> — ✅ مربوط</summary>
حالة شاشة التسجيل ✅ — باقي الأقسام واجهة فقط.
</details>

<details>
<summary><b>SettingsScreen</b> · الإعدادات — <code>/settings</code> — ✅ مزودات متعددة</summary>

| القسم                | المزود                             | الحالة |
| -------------------- | ---------------------------------- | ------ |
| بناء الرأس الغامر    | `authControllerProvider`           | ✅     |
| بناء قسم المظهر      | `themeControllerProvider`          | ✅     |
| بناء قسم التفضيلات   | `lowPerformanceControllerProvider` | ✅     |
| بناء زر تسجيل الخروج | `authControllerProvider`           | ✅     |

</details>

<details>
<summary><b>DigitalIDScreen</b> · الهوية الرقمية — <code>/digital-id</code> — ✅ هوية رقمية تفاعلية</summary>

| القسم                    | الحالة |
| ------------------------ | ------ |
| وجه البطاقة (الوجه)      | ✅     |
| خلفية البطاقة (الخلف)    | ✅     |
| بناء المحتوى             | ✅     |
| بناء عنصر المعلومات      | ✅     |
| راسم الدائرة الإلكترونية | ❌     |

</details>

<details>
<summary><b>NotificationsScreen</b> · الإشعارات — <code>/notifications</code> — ✅</summary>
بناء بلاطة الإشعار الجذبية (Gravity Tile) ✅ مربوط بـ `notification_provider`.
</details>

<details>
<summary><b>AdvisorApprovalScreen · DeanAdvisorAssignmentScreen</b> · موافقة المرشد وتعيينه — ✅</summary>
كلتاهما مربوطتان بشكل كامل بـ `advisor_provider`.
</details>

---

## 10. توصيات التحسين

### 🔴 أولوية عالية — يجب معالجتها

| #   | التوصية                                     | السبب                                                                                                                          |
| --- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| 1   | **تسجيل مسار `/admin/professors`**          | `ProfessorsManagementScreen` موجودة لكن لا يمكن الوصول إليها                                                                   |
| 2   | **تسجيل مسار `/admin/system-settings`**     | `SystemSettingsScreen` معزولة عن التطبيق                                                                                       |
| 3   | **تسجيل مسار `/feed`**                      | `FeedScreen` موجودة وغير مستخدمة                                                                                               |
| 4   | **ربط صفحات الطلاب بـ Supabase**            | `GradesScreen`، `AttendanceScreen`، `CoursesScreen`، `TranscriptScreen`، `ExamScheduleScreen` كلها واجهة فقط دون بيانات حقيقية |
| 5   | **إنشاء `/admin/system-settings` provider** | الصفحة موجودة لكن لا يوجد مزود حالة لها                                                                                        |

### 🟡 أولوية متوسطة — يُنصح بمعالجتها

| #   | التوصية                                                                             | السبب                                       |
| --- | ----------------------------------------------------------------------------------- | ------------------------------------------- |
| 6   | **استبدال البيانات الوهمية** في `StaffRatingDetailScreen` و`DepartmentDetailScreen` | تؤثر على مصداقية البيانات المعروضة          |
| 7   | **إكمال `ForgotPasswordScreen`**                                                    | منطق استرداد كلمة المرور عبر Supabase مفقود |
| 8   | **إكمال `PaymentScreen`**                                                           | صفحة الدفع واجهة فقط دون ربط حقيقي          |
| 9   | **إضافة قواعد RouteGuard لـ `/advisor-approval` و`/dean-assignment`**               | المسارات مفتوحة لأي مستخدم حالياً           |
| 10  | **إكمال `PlaceholderScreen` للمسارين** `/students-mgmt` و`/admin/monitor`           | يظهر للمستخدم صفحة فارغة                    |

### 🟢 تحسينات اختيارية — للرفع من الجودة

| #   | التوصية                                                                        |
| --- | ------------------------------------------------------------------------------ |
| 11  | إضافة `errorWidget` مركزي للـ `GoRouter` لمعالجة المسارات الخاطئة              |
| 12  | إضافة Deep Linking لمسارات الإشعارات (Notification → Route)                    |
| 13  | دمج `FeedScreen` في الـ `HomeScreen` كـ Tab بدلاً من تجاهلها                   |
| 14  | استخدام `shimmer` effect بدلاً من `CircularProgressIndicator` في صفحات التحميل |
| 15  | إضافة `Offline Mode` مع `Hive` أو `Drift` لتخزين البيانات محلياً               |
| 16  | إضافة Analytics لتتبع الاستخدام (Firebase Analytics أو PostHog)                |
| 17  | توليد PDF من `TranscriptScreen` وإرساله مباشرة من التطبيق                      |
| 18  | إضافة نظام Push Notifications حقيقي عبر Supabase Realtime                      |

---

## 11. الإحصائيات الختامية

| المقياس                      | القيمة                |
| ---------------------------- | --------------------- |
| **إجمالي الصفحات**           | 66                    |
| **المسارات المسجلة**         | 59                    |
| **المسارات العامة**          | 8                     |
| **المسارات المحمية**         | 42                    |
| **مسارات الإدارة (أدمن)**    | 16                    |
| **صفحات بدون مسار**          | 3 ⚠️                  |
| **صفحات مربوطة بـ Supabase** | ~22                   |
| **صفحات واجهة فقط**          | ~32                   |
| **صفحات ببيانات وهمية**      | 4                     |
| **مسارات نائبة**             | 2                     |
| **إجمالي الأدوار**           | 24                    |
| **فئات الأدوار**             | 7                     |
| **إجمالي الصلاحيات**         | 34                    |
| **أخطاء flutter analyze**    | 0 ✅                  |
| **تحذيرات flutter analyze**  | 0 ✅                  |
| **إشعارات flutter analyze**  | 0 ✅                  |
| **اللغات المدعومة**          | 4 (AR · EN · DE · ZH) |
| **مزودات Riverpod**          | 12+                   |
| **ملفات .g.dart (Code Gen)** | 12 ملفاً              |

---

_HUE Application Report · تم التحديث في 02 مارس 2026_
