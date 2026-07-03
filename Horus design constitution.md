# 📜 دستور التصميم — Horus Portal
**الإصدار:** 1.0.0 | **آخر تحديث:** 2026 | **المسؤول:** فريق تطوير Horus

> هذا الملف هو المرجع الوحيد والنهائي لكل قرار تصميمي في التطبيق.
> أي شاشة أو مكوّن أو لون لا يتوافق مع هذا الدستور يُعدّ **مرفوضاً** ويجب تصحيحه.

---

## الفهرس

1. [الهوية البصرية للجامعة](#1-الهوية-البصرية-للجامعة)
2. [نظام الألوان](#2-نظام-الألوان)
3. [الطباعة والخطوط](#3-الطباعة-والخطوط)
4. [المسافات والشبكة](#4-المسافات-والشبكة)
5. [المكوّنات الأساسية](#5-المكوّنات-الأساسية)
6. [نظام الحيوية والحركة](#6-نظام-الحيوية-والحركة)
7. [قواعد تجربة المستخدم UX](#7-قواعد-تجربة-المستخدم-ux)
8. [بنية الشاشات](#8-بنية-الشاشات)
9. [نظام الأيقونات](#9-نظام-الأيقونات)
10. [الوضع الليلي](#10-الوضع-الليلي)
11. [الترجمة والاتجاه RTL](#11-الترجمة-والاتجاه-rtl)
12. [قواعد الكود المرتبطة بالتصميم](#12-قواعد-الكود-المرتبطة-بالتصميم)
13. [قواعد محظورة لا تُكسر](#13-قواعد-محظورة-لا-تُكسر)

---

## 1. الهوية البصرية للجامعة

### 1.1 الروح العامة للتصميم

تطبيق Horus Portal هو **بوابة أكاديمية رسمية** تخدم طلاب وأعضاء هيئة تدريس جامعة حورس.
الهوية البصرية تعكس:

- **الرسمية والمصداقية** → ألوان جامعية داكنة رصينة
- **التميز والإنجاز** → لمسات ذهبية في نقاط القيمة المهمة
- **الحداثة والسهولة** → واجهة نظيفة، مقروءة، بدون تعقيد بصري
- **الحيوية والتفاعل** → حركات هادفة تعطي إحساساً بأن النظام "حيّ"

### 1.2 ألوان اللوجو الجامعي

```
اللون الأول   : أزرق كحلي داكن  → #0A1730
اللون الثاني  : ذهبي جامعي      → #D4AF37
اللون الثالث  : أبيض            → #FFFFFF
```

هذه الألوان الثلاثة هي **جوهر كل قرار بصري** في التطبيق.
أي لون آخر هو لون **دعم فقط** ويجب أن ينبثق من هذه العائلة.

---

## 2. نظام الألوان

### 2.1 البالتة الكاملة

#### 🔵 عائلة الأزرق الجامعي (Primary)

| الاسم | الكود | الاستخدام |
|---|---|---|
| `navy-950` | `#040D1A` | خلفية أعمق ما يكون (بطاقة ID) |
| `navy-900` | `#0A1730` | خلفية البطاقة الجامعية، رأس الصفحات الرسمية |
| `navy-800` | `#0E2347` | تدرّج ثانوي داخل البطاقات الداكنة |
| `navy-700` | `#16294F` | حدود البطاقات الداكنة |
| `navy-600` | `#1B3A6B` | الأزرار الأساسية، أيقونات التنقل النشطة |
| `navy-500` | `#2C4E8A` | حالة hover على الأزرار |
| `navy-400` | `#3A6BC4` | أيقونات وشارات ثانوية |
| `navy-100` | `#E8EEFA` | خلفية بطاقات الفئة الأكاديمية (فاتح) |
| `navy-050` | `#F2F5FD` | خلفية قسم بأكمله |

#### 🟡 عائلة الذهبي (Accent / Achievement)

| الاسم | الكود | الاستخدام |
|---|---|---|
| `gold-600` | `#A07820` | ذهبي داكن للنص على خلفيات فاتحة |
| `gold-500` | `#D4AF37` | اللون الذهبي الأساسي — الأرقام المهمة، الأيقونات الرئيسية |
| `gold-400` | `#E8C766` | تدرّج ذهبي للأزرار الذهبية |
| `gold-300` | `#F4E5A8` | نهاية تدرّج shimmer |
| `gold-100` | `#FBF1D8` | خلفية بطاقات الفئة "مميز / إنجاز" |
| `gold-050` | `#FEF9EC` | خلفية شريط تنبيه ذهبي |

#### ⚪ عائلة المحايد (Neutral)

| الاسم | الكود | الاستخدام |
|---|---|---|
| `neutral-900` | `#111827` | النص الرئيسي (عنوان) |
| `neutral-700` | `#374151` | النص الثانوي |
| `neutral-500` | `#6B7280` | تسميات، placeholder |
| `neutral-300` | `#D1D5DB` | حدود البطاقات العادية |
| `neutral-100` | `#F3F4F6` | خلفية ثانوية للصفحة |
| `neutral-050` | `#F9FAFB` | خلفية بطاقة عادية |
| `white`      | `#FFFFFF` | خلفية أساسية للتطبيق |

#### 🟢🔴🟠 ألوان الحالة (Semantic)

| الحالة | اللون الأساسي | خلفية فاتحة | استخدام |
|---|---|---|---|
| نجاح / نشط | `#16A34A` | `#F0FDF4` | درجة ممتازة، حضور كامل، تسجيل ناجح |
| تحذير / معلّق | `#D97706` | `#FFFBEB` | درجة متوسطة، طلب قيد المراجعة |
| خطر / رسوب | `#DC2626` | `#FEF2F2` | غياب زائد، فاتورة متأخرة، رسوب |
| معلومة | `#2563EB` | `#EFF6FF` | إشعار عام، ملاحظة |

### 2.2 التدرجات الرسمية (Gradients)

```dart
// التدرج الجامعي الأساسي — للبطاقات الرسمية فقط
const universityCardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF0A1730), Color(0xFF16294F)],
);

// التدرج الذهبي — للأزرار الذهبية والشارات
const goldGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFFD4AF37), Color(0xFFE8C766)],
);

// التدرج الذهبي للنص (shimmer)
const goldTextGradient = LinearGradient(
  colors: [Color(0xFFD4AF37), Color(0xFFF4E5A8), Color(0xFFD4AF37)],
  stops: [0.0, 0.5, 1.0],
);
```

### 2.3 قواعد استخدام الذهبي — مهمة جداً

```
✅ مسموح:
- رقم المعدل التراكمي في بطاقة الطالب
- أيقونات البطاقة الجامعية
- الخط الفاصل "بوابة الطالب" في تسجيل الدخول
- شارات الإنجاز (مثل "تفوق أكاديمي")
- حدود بطاقة ID الجامعية
- نقطة أو خط تمييزي في القوائم
- الزر الأساسي في شاشة Login فقط

❌ ممنوع:
- استخدام الذهبي كلون خلفية لصفحة كاملة
- نص عادي أو وصفي بلون ذهبي
- أيقونات التنقل اليومية
- بطاقات المحتوى العام (جدول، حضور، مواد عادية)
- أكثر من 3 عناصر ذهبية في نفس الشاشة
```

---

## 3. الطباعة والخطوط

### 3.1 الخطوط المعتمدة

```dart
// الخط العربي الرئيسي
const String arabicFont = 'Cairo';
// المصدر: Google Fonts — Cairo
// الأوزان المستخدمة: 400 (Regular), 500 (Medium), 600 (SemiBold), 700 (Bold)

// الخط الإنجليزي / الأرقام
const String latinFont = 'Inter';
// المصدر: Google Fonts — Inter
// الأوزان المستخدمة: 400, 500, 600
```

**لماذا Cairo؟**
- وضوح استثنائي في الأحجام الصغيرة
- شخصية عصرية لكن رصينة تناسب التطبيقات الأكاديمية
- دعم ممتاز للأرقام العربية والإنجليزية
- متوافق مع Google Fonts

### 3.2 نظام الأحجام (Type Scale)

```dart
class AppTextStyles {

  // ━━ عناوين ━━
  static const displayLarge = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static const headlineLarge = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.3,
  );

  static const headlineMedium = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static const headlineSmall = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ━━ نصوص أساسية ━━
  static const bodyLarge = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const bodyMedium = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static const bodySmall = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // ━━ تسميات وشارات ━━
  static const labelLarge = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const labelMedium = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.2,
  );

  static const labelSmall = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // ━━ أرقام وكودات (Inter) ━━
  static const monoLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );

  static const monoMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const monoSmall = TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
}
```

### 3.3 قواعد استخدام الخطوط

```
✅ قواعد إلزامية:
- المعدل التراكمي والأرقام الدراسية → Inter (monoLarge/monoMedium)
- الرقم الجامعي وكودات المقررات → Inter (monoSmall)
- كل النصوص العربية → Cairo
- عناوين الشاشات → headlineLarge (w600)
- أسماء المقررات في القوائم → bodyMedium (w500)
- تسميات الحقول → labelMedium

❌ ممنوع:
- استخدام fontWeight أعلى من w700 في أي نص
- fontSize أقل من 11px في أي شاشة
- خلط Cairo وInter في نفس الجملة
- letter-spacing سالبة على نصوص عربية
```

---

## 4. المسافات والشبكة

### 4.1 نظام المسافات (Spacing Scale)

```dart
class AppSpacing {
  static const double xs   = 4.0;
  static const double sm   = 8.0;
  static const double md   = 12.0;
  static const double lg   = 16.0;
  static const double xl   = 20.0;
  static const double xxl  = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;
}
```

**القاعدة الذهبية:** كل مسافة في التطبيق يجب أن تكون مضاعفاً لـ 4.
لا يوجد `padding: 7` أو `margin: 13` — فقط 4، 8، 12، 16، 20، 24، 32، 40.

### 4.2 نظام الزوايا (Border Radius)

```dart
class AppRadius {
  static const double xs  = 8.0;   // شارات صغيرة، chip
  static const double sm  = 10.0;  // أزرار صغيرة، التبويبات (tabs)
  static const double md  = 12.0;  // حقول الإدخال، أزرار عادية
  static const double lg  = 14.0;  // بطاقات صغيرة
  static const double xl  = 16.0;  // بطاقات متوسطة (الحالة الأكثر شيوعاً)
  static const double xxl = 18.0;  // بطاقات كبيرة
  static const double card= 20.0;  // بطاقة جامعية
  static const double full= 999.0; // دائري (avatars, dots)
}
```

**قاعدة التطابق:** داخل نفس الشاشة، كل البطاقات من نفس النوع يجب أن يكون لها نفس الـ radius.
مثال: كل بطاقات "الإجراءات السريعة" في الـ Dashboard → `AppRadius.xl` (16px) — دائماً.

### 4.3 هوامش الشاشة

```dart
// الهامش الأفقي القياسي لكل الشاشات
const double screenHorizontalPadding = 20.0;

// الهامش الرأسي من الأعلى (بعد AppBar)
const double screenTopPadding = 16.0;

// المسافة بين الأقسام الكبيرة داخل الشاشة
const double sectionSpacing = 24.0;

// المسافة بين العناصر داخل نفس القسم
const double itemSpacing = 10.0;
```

### 4.4 حدود العناصر (Borders)

```dart
class AppBorders {
  // الحد القياسي لكل البطاقات العادية
  static const standard = BorderSide(
    color: Color(0xFFE5E7EB), // neutral-200
    width: 0.5,
  );

  // حد بطاقات الفئة الجامعية (أزرق فاتح)
  static const navy = BorderSide(
    color: Color(0xFFCDD7EF),
    width: 0.5,
  );

  // حد بطاقات الذهبي
  static const gold = BorderSide(
    color: Color(0xFFD4AF37),
    width: 1.0,
  );

  // حد بطاقات الذهبي الخفيف
  static const goldSubtle = BorderSide(
    color: Color(0x40D4AF37), // 25% opacity
    width: 1.0,
  );
}
```

**قاعدة الحدود:** البطاقات العادية → `width: 0.5` فقط.
لا توجد حدود عريضة (> 1.5px) إلا في حالات التركيز (focused) أو التحديد (selected).

---

## 5. المكوّنات الأساسية

### 5.1 البطاقة القياسية (AppCard)

```dart
// الشكل المرجعي لكل بطاقة في التطبيق
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(AppRadius.xl), // 16
    border: Border.all(
      color: const Color(0xFFE5E7EB),
      width: 0.5,
    ),
  ),
  padding: const EdgeInsets.all(AppSpacing.lg), // 16
  child: ...,
)

// ❌ ممنوع على البطاقة العادية:
// - BoxShadow (أي نوع)
// - BackdropFilter
// - gradient كخلفية
// - border width > 0.5
```

### 5.2 البطاقة الجامعية (UniversityCard)

```dart
// للبطاقة الجامعية للطالب / رأس الصفحات الرسمية فقط
Container(
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0A1730), Color(0xFF16294F)],
    ),
    borderRadius: BorderRadius.circular(AppRadius.card), // 20
    border: Border.all(
      color: const Color(0x40D4AF37), // ذهبي 25%
      width: 1.0,
    ),
  ),
  child: ...,
)
```

### 5.3 الأزرار (AppButton)

```dart
// الزر الأساسي (Primary) — أزرق جامعي
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1B3A6B),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md), // 12
    ),
    elevation: 0,
  ),
  child: Text('تسجيل الدخول', style: AppTextStyles.labelLarge),
)

// الزر الذهبي (Gold) — لشاشة Login فقط
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    elevation: 0,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
    padding: EdgeInsets.zero,
  ),
  child: Ink(
    decoration: const BoxDecoration(
      gradient: goldGradient,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Center(
      child: Text('تسجيل الدخول',
        style: AppTextStyles.labelLarge.copyWith(color: const Color(0xFF0A1730)),
      ),
    ),
  ),
)

// الزر الثانوي (Secondary)
OutlinedButton(
  style: OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF1B3A6B),
    minimumSize: const Size(double.infinity, 48),
    side: const BorderSide(color: Color(0xFFCDD7EF), width: 1.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
    ),
  ),
  child: ...,
)

// ❌ ممنوع:
// - elevation > 0 على أي زر عادي
// - BorderRadius.circular(30) أو أكثر على الأزرار الكبيرة
// - ألوان خارج البالتة المعتمدة
```

### 5.4 حقول الإدخال (AppTextField)

```dart
InputDecoration(
  filled: true,
  fillColor: const Color(0xFFF9FAFB),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.md), // 12
    borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.md),
    borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 0.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.md),
    borderSide: const BorderSide(color: Color(0xFF1B3A6B), width: 1.5),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.md),
    borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.0),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  labelStyle: AppTextStyles.labelMedium.copyWith(color: Color(0xFF6B7280)),
  hintStyle: AppTextStyles.bodyMedium.copyWith(color: Color(0xFF9CA3AF)),
  prefixIconColor: const Color(0xFF1B3A6B),
)
```

### 5.5 الشارات والوسوم (AppBadge)

```dart
// شارة النجاح (درجة A / حضور 100%)
_Badge(label: 'A', background: Color(0xFFF0FDF4), textColor: Color(0xFF16A34A))

// شارة التحذير (درجة B / غياب متوسط)
_Badge(label: '+B', background: Color(0xFFFBF1D8), textColor: Color(0xFF8A6A12))

// شارة الخطر (درجة D / غياب كثير)
_Badge(label: 'D', background: Color(0xFFFEF2F2), textColor: Color(0xFFDC2626))

// شارة الذهبي (تفوق، شرف)
_Badge(label: 'تفوق', background: Color(0xFFFBF1D8), textColor: Color(0xFF8A6A12),
       border: Border.all(color: Color(0xFFD4AF37), width: 1.0))

// الشكل:
Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(AppRadius.xs), // 8
    border: border,
  ),
  child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: textColor)),
)
```

### 5.6 قسم العنوان داخل الشاشة (SectionHeader)

```dart
// يستخدم قبل كل قسم (أكاديمي، مالي، إلخ)
Row(
  children: [
    Container(
      width: 3,
      height: 16,
      decoration: BoxDecoration(
        color: const Color(0xFF1B3A6B),
        borderRadius: BorderRadius.circular(2),
      ),
    ),
    const SizedBox(width: 8),
    Text(title, style: AppTextStyles.headlineSmall),
    const Spacer(),
    if (onSeeAll != null)
      GestureDetector(
        onTap: onSeeAll,
        child: Text('عرض الكل',
          style: AppTextStyles.labelMedium.copyWith(color: Color(0xFF1B3A6B)),
        ),
      ),
  ],
)
```

### 5.7 شريط التنبيه الحيّ (LiveAlertBanner)

```dart
// للتنبيهات اللحظية (محاضرة قادمة، موعد تسجيل، إلخ)
Container(
  decoration: BoxDecoration(
    color: const Color(0xFFFEF9EC), // gold-050
    border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
    borderRadius: BorderRadius.circular(AppRadius.lg),
  ),
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
  child: Row(
    children: [
      // نقطة نابضة ذهبية
      _PulsingDot(color: Color(0xFFD4AF37)),
      const SizedBox(width: 10),
      Expanded(child: Text(message, style: AppTextStyles.labelMedium)),
      const Icon(Icons.chevron_left, size: 16, color: Color(0xFF8A6A12)),
    ],
  ),
)
```

### 5.8 شريط التقدم (AppProgressBar)

```dart
// للدرجات والحضور
ClipRRect(
  borderRadius: BorderRadius.circular(4),
  child: LinearProgressIndicator(
    value: percentage, // 0.0 → 1.0
    minHeight: 5,
    backgroundColor: const Color(0xFFF3F4F6),
    valueColor: AlwaysStoppedAnimation(_getProgressColor(percentage)),
  ),
)

Color _getProgressColor(double value) {
  if (value >= 0.85) return const Color(0xFFD4AF37); // ذهبي = ممتاز
  if (value >= 0.70) return const Color(0xFF1B3A6B); // أزرق = جيد
  if (value >= 0.60) return const Color(0xFFD97706); // أمبر = متوسط
  return const Color(0xFFDC2626);                    // أحمر = ضعيف
}
```

---

## 6. نظام الحيوية والحركة

### 6.1 مبادئ الحركة

```
1. الحركة هادفة — كل Animation لها سبب يفهمه المستخدم
2. الحركة خفيفة — لا تشتت الانتباه عن المحتوى
3. الحركة سريعة — 150ms - 350ms في معظم الحالات
4. الحركة متسقة — نفس النوع من الانتقال في نفس نوع الحدث
```

### 6.2 توقيتات الحركة المعتمدة

```dart
class AppDurations {
  static const micro  = Duration(milliseconds: 100); // hover, press
  static const fast   = Duration(milliseconds: 150); // toggle, badge
  static const normal = Duration(milliseconds: 250); // بطاقة تظهر
  static const medium = Duration(milliseconds: 350); // انتقال بين شاشات
  static const slow   = Duration(milliseconds: 500); // shimmer يدخل
  static const shimmer= Duration(milliseconds: 2000); // دورة shimmer كاملة
  static const pulse  = Duration(milliseconds: 1400); // نبضة النقطة الحية
}
```

### 6.3 منحنيات الحركة المعتمدة

```dart
class AppCurves {
  static const enter  = Curves.easeOut;       // عنصر يدخل للشاشة
  static const exit   = Curves.easeIn;        // عنصر يخرج من الشاشة
  static const spring = Curves.easeOutBack;   // عنصر "يقفز" بثقة
  static const smooth = Curves.easeInOut;     // حركة مستمرة (pulse, shimmer)
}
```

### 6.4 تأثيرات الحيوية المعتمدة

#### أ. الـ Shimmer الذهبي — للأرقام المهمة جداً

```dart
// يُستخدم على: المعدل التراكمي في بطاقة الطالب فقط
ShaderMask(
  shaderCallback: (bounds) => const LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF4E5A8), Color(0xFFD4AF37)],
    stops: [0.0, 0.5, 1.0],
  ).createShader(bounds),
  child: Text('3.85', style: AppTextStyles.monoLarge.copyWith(color: Colors.white)),
)
// مع AnimationController يُحرّك الـ gradient horizontally بـ Duration(seconds: 3)
```

#### ب. النقطة النابضة (Pulse Dot) — للتنبيهات الحية

```dart
// يُستخدم على: شريط التنبيه اللحظي فقط
class PulsingDot extends StatefulWidget {
  // AnimationController يتكرر كل 1400ms
  // scale: 1.0 → 1.6 → 1.0 مع fadeOut في النصف الثاني
  // اللون: gold-500 للتنبيهات الجامعية، أخضر للإشعارات العادية
}
```

#### ج. أشرطة التقدم المتحركة (Animated Bars)

```dart
// تُستخدم على: شاشة الدرجات، الحضور، التقدم الأكاديمي
// الشريط يبدأ من 0% ويصل للقيمة الحقيقية عند أول ظهور للشاشة
// Duration: 800ms, Curve: easeOut
```

#### د. الدخول المتدرّج للبطاقات (Staggered Entry)

```dart
// كل بطاقة في القائمة تظهر بتأخير 60ms عن السابقة
// fadeIn + slideY(begin: 0.05, end: 0) بـ Duration(250ms)
// أقصى تأخير: 300ms (أي 5 بطاقات فقط لها stagger، الباقي يظهر فوراً)
```

#### هـ. تأثير الضغط (Press Feedback)

```dart
// كل عنصر قابل للضغط يجب أن يكون له:
GestureDetector(
  onTapDown: (_) => setState(() => _isPressed = true),
  onTapUp: (_) => setState(() => _isPressed = false),
  onTapCancel: () => setState(() => _isPressed = false),
  child: AnimatedScale(
    scale: _isPressed ? 0.97 : 1.0,
    duration: AppDurations.micro,
    child: ...,
  ),
)
// HapticFeedback.lightImpact() على كل ضغطة بطاقة
// HapticFeedback.mediumImpact() على الأزرار الأساسية
```

### 6.5 انتقالات الشاشات (Page Transitions)

```dart
// انتقال قياسي للشاشات الجديدة
// slideFromRight للشاشات الفرعية (RTL: slideFromLeft)
// fadeIn فقط للنوافذ المنبثقة (modals, bottom sheets)
// لا يوجد flip أو rotation في أي انتقال
```

---

## 7. قواعد تجربة المستخدم UX

### 7.1 قواعد التحميل (Loading States)

```
1. أي شاشة تحتاج بيانات → تعرض Skeleton (هياكل رمادية) لا Spinner دوّار
2. Skeleton يطابق شكل المحتوى الفعلي (بطاقة بنفس الحجم والشكل)
3. بيانات الطالب الأساسية (اسم، كلية، مستوى) → cached محلياً وتظهر فوراً
4. وقت انتظار > 3 ثواني → رسالة "جارٍ التحميل..." تحت الـ Skeleton
5. فشل التحميل → رسالة واضحة + زر "إعادة المحاولة" بلون أزرق جامعي
```

### 7.2 قواعد الأخطاء والفراغ (Error & Empty States)

```
أخطاء:
- لا يُعرض أبداً stack trace أو رسائل تقنية للمستخدم
- رسالة الخطأ: "حدث خطأ، يرجى المحاولة مرة أخرى"
- اللون: أحمر semantic فقط في border و icon، لا خلفية حمراء كاملة

حالات الفراغ (Empty State):
- أيقونة (outline, navy-400)
- عنوان موضح (headlineSmall)
- وصف مختصر (bodySmall, neutral-500)
- زر إجراء إن وُجد (Primary Button)
- لا صور SVG معقدة في الـ Empty State
```

### 7.3 قواعد الإشعارات والتنبيهات

```
SnackBar:
- المدة: 3 ثواني للنجاح، 5 ثواني للخطأ
- الموقع: أسفل الشاشة دائماً (BottomCenter)
- الشكل: border-radius 12, بدون ظل، margin: 16px
- نجاح: خلفية green-600 (#16A34A)
- خطأ: خلفية red-600 (#DC2626)
- معلومة: خلفية navy-600 (#1B3A6B)
- تحذير: خلفية amber-600 (#D97706)

Bottom Sheets:
- border-radius أعلى: 20px
- حجم المقبض: 40px عرض، 4px ارتفاع، neutral-300
- padding داخلي: 24px من كل الجهات
- لا modal barriers معتمة بالكامل، opacity: 0.5 كحد أقصى
```

### 7.4 قواعد القوائم والبطاقات القابلة للضغط

```
- حد أدنى لارتفاع العنصر القابل للضغط: 44px (معيار Apple/Material)
- فراغ من بداية النص للأيقونة: 12px دائماً
- Divider بين العناصر: neutral-100 (0xFFF3F4F6)، لا يمتد لأطراف الشاشة
  (indent: 56px = أيقونة + مسافة)
```

### 7.5 قواعد النماذج (Forms)

```
- تسمية كل حقل فوقه (label above) — لا floating label
- رسالة الخطأ أسفل الحقل مباشرة بـ labelSmall أحمر
- ترتيب: label → field → error message
- المسافة بين الحقول: 16px
- الزر الإرسال دائماً في أسفل النموذج، عرض كامل
- تعطيل الزر (disabled, opacity 0.5) ما دام الحقول الإلزامية فارغة
```

---

## 8. بنية الشاشات

### 8.1 القالب القياسي لكل شاشة

```
┌─────────────────────────────┐
│  SafeArea                   │  ← إلزامي
│  ┌───────────────────────┐  │
│  │  AppBar (44px)        │  │  ← يحتوي: زر رجوع (يسار) + عنوان (وسط) + إجراء (يمين)
│  └───────────────────────┘  │
│  ┌───────────────────────┐  │
│  │  Body                 │  │  ← SingleChildScrollView أو ListView
│  │  padding: H=20, T=16  │  │
│  │                       │  │
│  │  [SectionHeader]      │  │
│  │  [Cards / List]       │  │
│  │  [SectionHeader]      │  │
│  │  [Cards / List]       │  │
│  │  bottom padding: 40px │  │  ← عشان يظهر المحتوى فوق الـ NavBar
│  └───────────────────────┘  │
└─────────────────────────────┘
```

### 8.2 AppBar القياسي

```dart
AppBar(
  backgroundColor: Colors.white, // أو شفاف مع SliverAppBar
  elevation: 0,
  scrolledUnderElevation: 0.5, // خط رفيع عند التمرير
  leading: IconButton(
    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
    color: const Color(0xFF111827),
    onPressed: () => context.pop(),
  ),
  title: Text(title, style: AppTextStyles.headlineSmall),
  centerTitle: true,
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(0.5),
    child: Divider(height: 0.5, color: Color(0xFFE5E7EB)),
  ),
)
```

### 8.3 شريط التنقل السفلي (BottomNavigationBar)

```dart
// 4 تبويبات فقط: الرئيسية، الكليات، لوحتي (Dashboard)، الإعدادات
NavigationBar(
  backgroundColor: Colors.white,
  elevation: 0,
  indicatorColor: const Color(0xFFE8EEFA), // navy-100
  selectedIndex: _currentIndex,
  destinations: [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded, color: Color(0xFF1B3A6B)),
      label: 'الرئيسية',
    ),
    // ...
  ],
)
// + Divider أعلاه بـ 0.5px neutral-200
```

### 8.4 تسلسل الأولويات البصرية في الشاشة

```
المستوى 1 — أعلى قيمة: المعدل، الرقم الجامعي، الحالة الحيّة (ذهبي/أبيض على داكن)
المستوى 2 — عالٍ: عناوين الأقسام، بطاقات الإجراءات الأكثر استخداماً (navy)
المستوى 3 — متوسط: قوائم البيانات، بطاقات المعلومات (أبيض عادي)
المستوى 4 — منخفض: تسميات، تواريخ، كودات المقررات (neutral-500)
```

---

## 9. نظام الأيقونات

### 9.1 المكتبة المعتمدة

```dart
// الأيقونة الوحيدة المعتمدة في التطبيق:
package: lucide_icons

// سبب الاختيار: خط رفيع واضح (outline only)، متسق، ومرتبط بمعاني واضحة
// الحجم القياسي: 20px للأيقونات داخل البطاقات والقوائم
// الحجم الصغير: 16px للـ labels والـ trailing
// الحجم الكبير: 24px فقط في Empty States والـ onboarding
```

### 9.2 أيقونات الفئات — قياسية ومثبّتة

```dart
// لا يتغير أي أيقونة من هذه القائمة في أي شاشة
const categoryIcons = {
  'الدرجات'        : LucideIcons.fileText,
  'الجدول'         : LucideIcons.calendar,
  'الحضور'         : LucideIcons.clipboardCheck,
  'خطة الدراسة'    : LucideIcons.targetArrow,
  'التسجيل'        : LucideIcons.pencil,
  'الفواتير'        : LucideIcons.receipt,
  'الدفع'          : LucideIcons.creditCard,
  'البطاقة الرقمية' : LucideIcons.id,
  'الإشعارات'      : LucideIcons.bell,
  'الإعدادات'      : LucideIcons.settings,
  'الأمان'         : LucideIcons.shieldCheck,
  'الدعم'          : LucideIcons.lifebuoy,
  'تسجيل الخروج'  : LucideIcons.logOut,
};
```

### 9.3 ألوان الأيقونات

```
أيقونة داخل بطاقة عادية: navy-600 (#1B3A6B) على خلفية navy-100 (#E8EEFA)
أيقونة "إنجاز / مميز"  : gold-600 (#A07820) على خلفية gold-100 (#FBF1D8)
أيقونة التنقل النشطة   : navy-600 على مؤشر navy-100
أيقونة التنقل غير النشطة: neutral-400 (#9CA3AF)
أيقونة في بطاقة داكنة  : gold-500 (#D4AF37) على داكن
```

---

## 10. الوضع الليلي (Dark Mode)

### 10.1 مبدأ الوضع الليلي

```
التطبيق يدعم وضعاً ليلياً واحداً فقط.
الوضع الليلي ليس "عكس" الوضع النهاري — له منطقه الخاص.
الهوية الذهبية والجامعية تبدو أكثر فخامة في الوضع الليلي.
```

### 10.2 جدول استبدال الألوان في الوضع الليلي

| الوضع النهاري | الوضع الليلي | الوصف |
|---|---|---|
| `#FFFFFF` | `#0F172A` | خلفية الصفحة |
| `#F9FAFB` | `#1E293B` | خلفية البطاقة |
| `#F3F4F6` | `#334155` | خلفية ثانوية |
| `#E5E7EB` | `#334155` | حدود البطاقات |
| `#111827` | `#F1F5F9` | النص الرئيسي |
| `#374151` | `#CBD5E1` | النص الثانوي |
| `#6B7280` | `#94A3B8` | النص الثالثي |
| `#1B3A6B` | `#3A6BC4` | اللون الأزرق الأساسي |
| `#E8EEFA` | `#1E2A45` | خلفية أيقونة أكاديمية |
| `#FBF1D8` | `#2A2110` | خلفية أيقونة ذهبية |
| `#D4AF37` | `#D4AF37` | **الذهبي لا يتغير أبداً** |
| `#0A1730` | `#0A1730` | **البطاقة الجامعية لا تتغير** |

---

## 11. الترجمة والاتجاه RTL

### 11.1 قواعد RTL الإلزامية

```
1. كل padding/margin يستخدم EdgeInsetsDirectional لا EdgeInsets
   ✅ EdgeInsetsDirectional.only(start: 16, end: 8)
   ❌ EdgeInsets.only(left: 16, right: 8)

2. أيقونة الرجوع في AppBar تُقلب تلقائياً بـ Directionality
   → استخدم Icons.arrow_back_ios_new_rounded (Flutter يعكسه تلقائياً)

3. كل Row يستخدم textDirection من context، لا hardcoded
4. ListView أفقي (horizontal): يبدأ من اليمين في العربية
5. SliverGrid: يحترم RTL تلقائياً

المحتوى الثابت يسار/يمين:
- الرقم الجامعي وكودات المقررات (CS101): يبقى LTR دائماً
- التاريخ الميلادي: يبقى LTR
- كل النصوص العربية: RTL
```

### 11.2 قواعد الترجمة الكودية

```dart
// ✅ دائماً:
Text(t.dashboard.welcome_back)  // نص مترجم
Text(t.grades.gpa_label)

// ❌ ممنوع:
Text('مرحباً بك')   // نص عربي مكتوب مباشرة في الكود
Text('Welcome')     // نص إنجليزي مكتوب مباشرة في الكود
Text('GPA')         // حتى الاختصارات التقنية — تُترجم أو تُعرَّف في ملف i18n
```

---

## 12. قواعد الكود المرتبطة بالتصميم

### 12.1 ملف `app_theme.dart` — المرجع الوحيد للألوان

```dart
// ✅ الطريقة الصحيحة
color: AppColors.navy600
color: AppColors.gold500
color: AppColors.semanticSuccess

// ❌ ممنوع
color: const Color(0xFF1B3A6B)  // لا hardcoded colors خارج AppColors
color: Colors.blue              // ممنوع تماماً
color: Colors.amber             // ممنوع تماماً
color: Theme.of(context).primaryColor  // مسموح فقط عبر امتداد AppColors
```

### 12.2 بنية ملف التصميم

```
lib/core/theme/
├── app_colors.dart         ← كل الألوان وقيمها
├── app_text_styles.dart    ← كل أنواع النصوص
├── app_spacing.dart        ← المسافات والزوايا
├── app_theme.dart          ← ThemeData الكاملة (تجمع الثلاثة)
└── app_animations.dart     ← AppDurations, AppCurves

lib/shared/widgets/
├── app_card.dart           ← AppCard, UniversityCard
├── app_button.dart         ← PrimaryButton, GoldButton, SecondaryButton
├── app_text_field.dart     ← AppTextField
├── app_badge.dart          ← AppBadge (success, warning, danger, gold)
├── app_section_header.dart ← SectionHeader
├── app_progress_bar.dart   ← AppProgressBar
├── live_alert_banner.dart  ← LiveAlertBanner + PulsingDot
└── app_skeleton.dart       ← Skeleton loaders لكل نوع بطاقة
```

### 12.3 ترتيب الـ Widget tree داخل الشاشة

```dart
// كل شاشة تتبع هذا الترتيب بالضبط:
Scaffold(
  backgroundColor: AppColors.white,    // أو dark equivalent
  appBar: AppBar(...),                 // القياسي دائماً
  body: SafeArea(
    child: CustomScrollView(           // أو SingleChildScrollView
      slivers: [
        // أو ListView
      ],
    ),
  ),
)

// ❌ ممنوع:
// - Stack كعنصر رئيسي للشاشة
// - GestureDetector يلفّ Scaffold كاملاً
// - Padding مباشر على Scaffold
```

---

## 13. قواعد محظورة لا تُكسر

هذه القواعد لا تقبل أي استثناء أو نقاش:

```
🚫 01 — لا BackdropFilter / blur في أي مكان في التطبيق
        (كانت موجودة في النسخة القديمة وأُلغيت للأبد)

🚫 02 — لا BoxShadow على البطاقات العادية
        (الحدود الرفيعة كافية للعمق البصري)

🚫 03 — لا ألوان خارج ملف app_colors.dart
        (حتى لو "تبدو قريبة" من البالتة)

🚫 04 — لا نصوص مكتوبة مباشرة في الكود بدون ترجمة
        (صفر استثناءات حتى في أدوات المطورين)

🚫 05 — لا gradient على البطاقات العادية
        (فقط UniversityCard والـ GoldButton)

🚫 06 — لا animation مدتها > 500ms على عناصر تفاعلية
        (التأخير يُشعر المستخدم ببطء التطبيق)

🚫 07 — لا أكثر من 3 ألوان مختلفة في نفس البطاقة الواحدة

🚫 08 — لا fontSize < 11px في أي نص يقرأه المستخدم

🚫 09 — لا element قابل للضغط بدون press animation (scale 0.97)

🚫 10 — لا يُعرض خطأ تقني للمستخدم (stack trace، رسائل API، إلخ)

🚫 11 — لا مزج بين نمط Glass القديم وأي شاشة جديدة
        (الشاشات القديمة تُحوَّل بالكامل، لا تخليط)

🚫 12 — لا تُضاف شاشة جديدة دون مراجعتها مقابل هذا الدستور
```

---

## ملحق — خريطة الألوان حسب الفئة

```
📚 الفئة الأكاديمية (درجات، جدول، حضور)
   → أيقونة: navy-600 على navy-100
   → شريط تقدم: navy-600 (جيد) أو gold-500 (ممتاز)

💰 الفئة المالية (فواتير، دفع)
   → أيقونة: أحمر/برتقالي semantic على خلفياتهم
   → حالات: success-green للمدفوع، danger-red للمتأخر

🎓 الفئة الجامعية (بطاقة، ID)
   → خلفية: navy-gradient كاملة
   → نص: أبيض
   → تمييز: gold-500

⚡ التنبيهات الحية
   → خلفية: gold-050 (#FEF9EC)
   → حد: gold-500 بـ 50% opacity
   → نقطة: gold-500 نابضة

⚙️ الإعدادات والمساعدة
   → كل شيء neutral
   → لا ألوان جامعية أو ذهبية إلا في شعار الجامعة
```

---

*هذا الدستور ملزم لكل من يعمل على المشروع.
أي تغيير في هذا الملف يتطلب موافقة قائد فريق التصميم
ويُوثَّق برقم إصدار جديد وتاريخ التعديل.*

**Horus Portal Design System · v1.0.0 · 2026**
