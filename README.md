# 🎓 Hue - Enterprise University Portal

<div align="center">
  <h3>Next-Generation Academic Management & Social Platform</h3>
  <p>Available in English & Arabic (متوفر باللغتين الإنجليزية والعربية)</p>
</div>

---

## 📖 Project Overview (نظرة عامة على المشروع)

**Hue** is a robust, enterprise-grade university portal application built entirely in Flutter. It functions as a centralized ecosystem connecting students, teaching staff, academic leadership, and administration. By integrating a seamless social feed with powerful academic management tools, Hue redefines the modern university experience.

**Hue (هيو)** هو تطبيق بوابة جامعية متكامل وموجه للمؤسسات مبني باستخدام إطار عمل Flutter. يعمل كبيئة مركزية تربط بين الطلاب وأعضاء هيئة التدريس والقيادات الأكاديمية والإدارة. يدمج النظام بين أدوات التواصل الاجتماعي الأكاديمي وإدارة شؤون الطلاب بشكل عصري، مما يعيد تعريف التجربة الجامعية الرقمية.

---

## 🌟 Main Features (الميزات الرئيسية)

- **Role-Based Access Control (RBAC):** Highly granular permission system supporting over 10 distinct roles (e.g., Rector, Dean, Professor, Student, Admin).
- **Glassmorphism UI:** Stunning, modern, and adaptive UI supporting both Light and Dark themes natively.
- **Real-time Synchronization:** Powered by Supabase for instant database updates, real-time posts, and academic notifications.
- **Academic Dashboard:** Dedicated secure views for schedules, grades, attendance, and faculty management.
- **Social Feed:** Interactive community feed allowing authorized users to create posts and university-wide announcements.
- **Bilingual Support:** Full i18n localization (English and Arabic) using the `slang` package.

---

## 🏗️ System Architecture (هيكلية النظام)

Hue strictly follows modular and clean architecture-inspired principles to ensure absolute scalability, testing compatibility, and maintainability.

### Technology Stack

- **Framework:** Flutter (Cross-platform support: Web, Linux, Windows, iOS, Android)
- **Backend & Database:** Supabase (PostgreSQL, Authentication, Realtime, Storage)
- **State Management:** Riverpod (Declarative, safe, and reactive state caching)
- **Routing:** GoRouter (Deep linking capable, fully typed routing)
- **Localization:** Slang (Type-safe i18n generation)
- **Design Language:** Google Fonts, Lucide Icons, Custom Animated Glassmorphism

### Core Folder Structure

```text
lib/
├── core/             # Core utilities (auth, router, theme, i18n, core data access)
├── features/         # Feature-first modular design
│   ├── admin/        # System administration & user management portal
│   ├── auth/         # Login, registration, and session flow
│   ├── feed/         # Social community, announcements, and posts
│   ├── home/         # Main taskbar and navigation host
│   ├── students/     # Student-specific academic dashboards
│   └── onboarding/   # Initial college & department selection setups
└── main.dart         # System entry point and top-level provider scope
```

---

## 🚀 Installation & Environment Setup (التثبيت وإعداد البيئة)

### Prerequisites

- Flutter SDK (Stable release)
- Dart SDK
- Supabase Project details (URL & Anon Key)

### Workflow Instructions

1. **Clone the Repository:**

   ```bash
   git clone <repository_url>
   cd hue
   ```

2. **Environment Setup:**

   ```bash
   cp .env.example .env
   ```

   Open `.env` and fill in your Supabase credentials:

   ```
   SUPABASE_URL=your_supabase_url_here
   SUPABASE_ANON_KEY=your_supabase_anon_key_here
   ```

3. **Install Dependencies:**

   ```bash
   flutter pub get
   ```

4. **Generate i18n Files (If modifying translations):**

   ```bash
   dart run slang
   ```

5. **Run the Project:**
   ```bash
   flutter run --dart-define-from-file=.env -d chrome  # For Web
   flutter run --dart-define-from-file=.env -d linux   # For Linux Desktop
   ```

   > **Note:** The `--dart-define-from-file=.env` flag is required to inject Supabase credentials at build time. If using VS Code, the included `.vscode/launch.json` handles this automatically.

---

## 🔒 Security Considerations (الاعتبارات الأمنية)

- **Row Level Security (RLS):** All data access is strictly controlled at the PostgreSQL database level via Supabase RLS policies. Users can conceptually only access data explicitly permitted by their roles.
- **Stateful Authentication:** JWT-based stateless authentication flow handled seamlessly by the Supabase SDK.
- **Client-Side Validation & Enforcements:** Conditional UI rendering ensures unauthorized users cannot interact with privileged actions (e.g., the "Create Post" FAB is dynamically hidden for users lacking the `createPost` permission).

---

## 🛤️ Deployment Notes & Future Roadmap (النشر وخارطة الطريق المستقبلية)

- **CI/CD Implementation:** The structure is primed to be combined with CI/CD platforms (like GitHub Actions) to enforce static analysis (`flutter analyze`) and automated builds.
- **Current Phase:** Actively undergoing deep enterprise-level system auditing, refactoring, and UI perfection.
- **Future Goals:**
  1. Advanced analytics dashboard for Rectors and Deans.
  2. Integration of AI-driven tools for academic scheduling.
  3. Comprehensive internal messaging and forum subsystems.

---

_Maintained by the Elite Software Engineering Team._
