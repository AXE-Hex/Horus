# HORUS Design System
## Horus University – Egypt Digital Product Design Standard

**Document status:** Design System v1.1 — University Super App direction
**Scope:** One Horus University application with permission-adaptive features
**Primary platforms:** Android, iOS, Web, Windows, macOS, Linux
**Framework target:** Flutter
**Brand:** Horus University – Egypt (HUE)
**Design direction:** Institutional + Premium + Modern + Academic + Technology

---

# 1. Purpose

This document is the single visual and interaction standard for all Horus digital products.

It exists to prevent design drift, duplicated component styles, inconsistent spacing, arbitrary colors, mismatched cards, conflicting navigation patterns, and different UX behavior between screens.

All new UI work must follow this document unless a deliberate design-system change is approved.

The goals are:

1. Preserve the recognizable Horus University identity.
2. Create one coherent digital product language.
3. Support Light and Dark mode.
4. Support Arabic RTL and English LTR correctly.
5. Adapt one university super app across compact, medium, and expanded devices.
6. Keep accessibility, responsiveness, and maintainability first-class.
7. Let developers and Codex build new screens without inventing new visual rules.

---

# 2. Brand Foundation

## 2.1 Brand personality

Horus digital products must feel:

- Academic
- Trustworthy
- Premium
- Modern
- Structured
- Calm
- Technological
- Institutional

They must not feel:

- Gaming-oriented
- Cyberpunk
- Overly futuristic
- Decorative at the expense of usability
- Excessively glassy
- Visually noisy
- Like a generic admin template
- Like unrelated products stitched together

---

# 3. Official Visual Identity

## 3.1 Primary identity

The official visual language is based on:

- Deep Navy
- Horus Gold
- White / warm neutral surfaces
- The official HUE logo
- The Eye of Horus symbol
- University/campus photography
- Approved college artwork

The official HUE logo remains the master institutional identity.

The product design must support it rather than redesign or distort it.

---

# 4. Logo System

## 4.1 Approved logo assets

Primary repository assets:

```text
assets/images/Logo_light.png
assets/images/Logo_dark.png
```

Use these assets as the official identity source.

Do not redraw the official logo casually.

Do not replace the Eye of Horus with a newly generated symbol in production.

---

## 4.2 Logo variants

Use the correct variant depending on background.

### Light surface

Use the official light-background logo variant.

### Dark surface

Use the official dark-background logo variant.

### Compact product mark

Where the full HUE lockup is too large, use the Eye of Horus emblem only if an approved isolated asset exists.

If an isolated emblem asset is not available, it should be produced once from the official artwork and stored as a reusable vector/asset rather than cropped repeatedly at runtime.

---

## 4.3 Logo usage

The logo may appear in:

- Authentication
- Splash / loading identity
- App shell
- Digital ID
- About
- Official documents
- University profile pages
- Premium hero sections
- App icon

The logo must not be repeated unnecessarily on every card.

---

## 4.4 Clear space

Maintain clear space around the full logo equal to at least the height of the Eye of Horus symbol’s central pupil.

Do not allow:

- Text touching the logo
- Buttons touching the logo
- Decorative graphics crossing the logo
- Cropping through the logo
- Unauthorized recoloring
- Stretched proportions

---

# 5. Core Design Principle

## One university super app, three adaptive presentations

Horus combines the university social feed, conversations, course collaboration,
academic services, university portal, and permissioned management workflows in
one application shell. Roles and permissions change available data and actions;
they do not switch users into separate visual products.

### Compact — phone

- Feed-first, mobile application composition.
- App bar, current feature, and no more than five primary bottom destinations.
- Secondary academic and account actions live inside their product areas.

### Medium — tablet

- Navigation rail where useful.
- Use two-pane list/detail layouts when they preserve selection and context.
- Support portrait and landscape without stretching phone cards.

### Expanded — desktop

- Compact, collapsible application navigation.
- Preserve a real application context bar and contained content widths.
- Use remaining space for relevant feature context; reserve wide layouts for
  genuine tables and communication workspaces.

All device classes share the same Horus tokens, components, backend, and route
authorization. Management workflows use permission-based entry points and the
same Horus identity; management is a product domain, not a separate shell.

Both products share:

- Brand colors
- Typography
- Components
- Icons
- Form patterns
- Status colors
- Motion rules
- Accessibility rules

---

# 6. Theme Behavior

## 6.1 Default behavior

The application must detect the device/system preference automatically.

At first launch:

```text
Language → Device language
Theme    → System
```

Do not show a mandatory first-run language/theme selection screen.

---

## 6.2 User override

Settings must offer:

```text
Appearance
○ System
○ Light
○ Dark
```

Default:

```text
System
```

---

## 6.3 Language behavior

At first launch:

1. Detect device language.
2. If supported, use it.
3. If unsupported, fall back to English.

The application must update direction automatically:

```text
Arabic → RTL
English → LTR
```

Language remains changeable from Settings.

---

## 6.4 Removed option

Do not provide a user-selectable:

```text
Design Style
Classic / Modern / Premium / etc.
```

Horus has one official design system.

---

# 7. Color System

The existing Navy + Gold direction is retained and formalized.

## 7.1 Navy

| Token | Hex | Usage |
|---|---|---|
| navy950 | `#040D1A` | deepest dark background |
| navy900 | `#0A1730` | dark navigation / dark surfaces |
| navy800 | `#0E2347` | premium hero |
| navy700 | `#16294F` | strong emphasis |
| navy600 | `#1B3A6B` | primary brand |
| navy500 | `#2C4E8A` | pressed / secondary |
| navy400 | `#3A6BC4` | dark-mode primary accent |
| navy300 | `#6F91D0` | subtle accent |
| navy200 | `#B9C9E8` | light accent |
| navy100 | `#E8EEFA` | light background accent |
| navy050 | `#F2F5FD` | light surface tint |

Primary brand token:

```text
brand.primary = navy600
```

Dark-mode primary:

```text
brand.primary.dark = navy400
```

---

## 7.2 Gold

| Token | Hex | Usage |
|---|---|---|
| gold700 | `#815F16` | deep contrast |
| gold600 | `#A07820` | pressed / accessible gold text |
| gold500 | `#D4AF37` | official accent |
| gold400 | `#E8C766` | dark-mode highlight |
| gold300 | `#F4E5A8` | borders / soft accents |
| gold100 | `#FBF1D8` | subtle backgrounds |
| gold050 | `#FEF9EC` | light tint |

Primary accent:

```text
brand.accent = gold500
```

Gold is a brand accent, not a generic warning color.

---

# 8. Semantic Colors

Semantic colors must remain independent from brand colors.

## 8.1 Success

Use for:

- Approved
- Completed
- Passed
- Paid
- Active success

Recommended family:

```text
success.surface
success.border
success.text
success.strong
```

Do not use pure saturated green backgrounds for large areas.

---

## 8.2 Warning

Use amber/orange, not Horus Gold.

Use for:

- Pending
- Attention
- Deadline
- Incomplete
- Moderate academic risk

---

## 8.3 Danger

Use for:

- Failed
- Rejected
- Blocked
- Destructive action
- Critical warning

Never use brand gold as danger.

---

## 8.4 Info

Use a calm blue separate from primary navy when information status needs distinction.

---

# 9. Surface System

## 9.1 Light

```text
background.primary     = warm off-white
background.secondary   = cool neutral
surface.primary        = white
surface.secondary      = very light neutral/navy tint
surface.elevated       = white
text.primary           = near-black/navy
text.secondary         = muted slate
border.default         = cool gray
```

Avoid pure white everywhere.

Use subtle tonal separation.

---

## 9.2 Dark

Primary dark surfaces should be navy-based, not generic black/gray.

Recommended structure:

```text
background.primary   = #081421
background.secondary = navy950
surface.primary      = navy900
surface.secondary    = #10213A
surface.elevated     = #142945
```

Dark mode should still feel like Horus.

---

# 10. College Accent Policy

College-specific colors are optional secondary accents.

They may be used only for:

- College hero
- College artwork
- College badge
- Small icon highlight
- Faculty identity chip

They must not replace:

- Primary buttons
- Main navigation
- Global links
- Core brand navy
- Core Horus gold

The overall product must remain recognizably Horus.

---

# 11. Typography

## 11.1 Typeface policy

Recommended:

### Latin / English
`Inter`

### Arabic
`IBM Plex Sans Arabic`

Fallback:

```text
system sans-serif
```

If the project does not yet bundle these fonts, implementation may begin with platform/system fonts, but typography tokens must still be respected.

---

## 11.2 Type scale

| Token | Size | Weight | Usage |
|---|---:|---:|---|
| displayLarge | 40 | 700 | marketing/hero only |
| displayMedium | 32 | 700 | major page hero |
| headlineLarge | 28 | 700 | screen title |
| headlineMedium | 24 | 700 | section hero |
| titleLarge | 20 | 600 | card/section title |
| titleMedium | 18 | 600 | subsection |
| titleSmall | 16 | 600 | compact title |
| bodyLarge | 16 | 400 | primary reading |
| bodyMedium | 14 | 400 | standard UI |
| bodySmall | 12 | 400 | secondary metadata |
| labelLarge | 14 | 600 | buttons |
| labelMedium | 12 | 600 | chips |
| labelSmall | 11 | 600 | dense metadata |

Avoid arbitrary font sizes.

---

# 12. Typography Rules

- Do not use more than three weights on one screen without a strong reason.
- Avoid uppercase long text.
- Uppercase may be used for short institutional labels.
- Avoid tight line height in Arabic.
- Arabic must be visually tested independently.
- Numeric data may use tabular figures when available.
- GPA, grades, balances, and analytics numbers should have clear numeric hierarchy.

---

# 13. Spacing System

Base grid:

```text
4 px
```

Approved spacing:

| Token | Value |
|---|---:|
| xs | 4 |
| sm | 8 |
| md | 12 |
| lg | 16 |
| xl | 20 |
| xxl | 24 |
| xxxl | 32 |
| huge | 40 |
| hero | 48 |

Existing spacing values should map to these tokens.

Do not add arbitrary values such as:

```text
13, 17, 19, 23
```

unless a documented visual exception exists.

---

# 14. Screen Padding

## Mobile

```text
horizontal = 20
top        = 16
section    = 24
```

## Tablet

```text
horizontal = 24–32
```

## Desktop

```text
horizontal = 32–48
```

Large desktop content should not stretch infinitely.

---

# 15. Radius System

| Token | Value |
|---|---:|
| xs | 8 |
| sm | 10 |
| md | 12 |
| lg | 14 |
| xl | 16 |
| xxl | 18 |
| card | 20 |
| pill | 999 |

Use:

- Inputs: 12–14
- Buttons: 12–14
- Standard cards: 16–20
- Hero cards: 20–24
- Chips: pill

Do not mix unrelated corner radii within one component family.

---

# 16. Borders

Default border:

```text
1px neutral
```

Brand border:

```text
1px navy
```

Premium border:

```text
1px gold300/gold400
```

Avoid gold borders around every card.

---

# 17. Shadows

Horus uses restrained elevation.

## Level 0
No shadow.

## Level 1
Subtle card separation.

## Level 2
Dropdown / menu / sticky surface.

## Level 3
Dialog / modal.

## Level 4
Special premium hero only.

Dark mode uses less shadow and more border/tonal elevation.

---

# 18. Glassmorphism

Glassmorphism is allowed only for premium or identity surfaces.

Allowed:

- Digital ID
- Hero card
- Premium profile surface
- Special achievement
- Splash identity accent
- Large dashboard identity card

Not allowed by default:

- Forms
- Tables
- Settings rows
- Standard lists
- Dialogs
- Every card

Blur must never reduce readability.

---

# 19. Gradients

Approved gradient usage:

- Navy institutional gradient
- Gold premium gradient
- Subtle Navy → transparent overlay for photography
- Minimal premium hero surfaces

Do not use multiple unrelated gradients in one screen.

---

# 20. Cards

Only three primary card families should exist.

## 20.1 Standard Card

Use for normal content.

Style:

```text
surface.primary
radius 16–20
1px border
minimal/no shadow
```

Examples:

- Course row
- Setting section
- Notification group
- Staff information
- Profile content

---

## 20.2 Academic Highlight Card

Use for high-value academic information.

Examples:

- GPA
- Next lecture
- Exam
- Registration status
- Attendance risk
- Upcoming deadline

May use:

- Navy accent
- Small icon
- Status chip

Avoid decorative overload.

---

## 20.3 Premium/Hero Card

Use sparingly.

Examples:

- Digital ID
- College hero
- Achievement
- Main dashboard identity
- University announcement hero

May use:

- Gradient
- Gold
- Brand artwork
- subtle glass
- image overlay

---

# 21. Buttons

## 21.1 Primary

```text
background: navy600
text: white
radius: 12–14
height: 48–52
```

Dark mode may use navy400 or a contrast-safe equivalent.

---

## 21.2 Secondary

Outlined or tonal.

Use for:

- Alternate actions
- Cancel
- Secondary workflow

---

## 21.3 Tertiary

Text/icon button.

Use for low-emphasis actions.

---

## 21.4 Destructive

Use danger color.

Never style destructive actions in gold.

---

## 21.5 Gold button

Gold is allowed only for rare premium actions.

Do not make every primary action gold.

---

# 22. Inputs

All text fields must share one pattern.

Required:

- Clear label
- Optional helper text
- Error text
- Focus state
- Disabled state
- Read-only state
- Leading/trailing icon rules
- Correct RTL behavior

Recommended height:

```text
48–52 px
```

Avoid floating labels when they reduce clarity.

---

# 23. Forms

Rules:

1. Group related fields.
2. Put labels outside/above when forms are complex.
3. Keep destructive actions separated from submit.
4. Preserve entered data during validation failures.
5. Focus the first invalid field.
6. Support keyboard navigation on desktop.
7. Use correct input type.
8. Use explicit confirmation for irreversible operations.

---

# 24. Navigation

## 24.1 Compact — Mobile

Use a bottom navigation bar for the most frequent destinations.

Maximum recommended destinations:

```text
4–5
```

Avoid more than five.

---

## 24.2 Medium — Tablet

Use:

- Navigation rail
- Side navigation
- Responsive top actions

---

## 24.3 Expanded — Desktop

Use a persistent side navigation.

Must support:

- Collapsed/expanded mode
- Section groups
- Active state
- Permission-based visibility
- Keyboard focus

Navigation visibility is not security.

Database and route authorization remain authoritative.

---

# 25. App Bar

Use a standardized hierarchy:

```text
Leading
Title / context
Optional subtitle
Primary action
Secondary menu
```

Avoid different app-bar heights across screens without reason.

---

# 26. Tabs

Use tabs for switching between views of the same object.

Do not use tabs for unrelated modules.

Tab labels must remain short.

Scrollable tabs are allowed on mobile.

---

# 27. Chips and Badges

Use chips for:

- Status
- Role
- Faculty
- Tag
- Filter

Do not use chips as decorative elements.

Semantic status chips must use semantic color families.

---

# 28. Tables

Control must use standardized tables.

Required support:

- Column sorting
- Search
- Filters
- Pagination
- Empty state
- Loading state
- Error state
- Selection
- Bulk action bar
- Responsive fallback

Avoid horizontal overflow when a better responsive pattern exists.

---

# 29. Mobile Data Tables

On narrow screens, replace dense tables with:

- Stacked cards
- Key/value rows
- Expandable details
- Horizontal table only when unavoidable

---

# 30. Dialogs

Use dialogs for:

- Confirmation
- Small focused edits
- High-risk action confirmation
- Short forms

Do not put full workflows in dialogs.

---

# 31. Bottom Sheets

Prefer on mobile for:

- Filters
- Quick actions
- Sorting
- Small selection tasks

Do not use for critical destructive confirmation without clear hierarchy.

---

# 32. Toasts / Snackbars

Use for short transactional feedback.

Examples:

- Saved
- Copied
- Upload completed
- Retry available

Do not use snackbars for important persistent errors.

---

# 33. Loading States

There must be three standard loading patterns.

## Skeleton
Use when structure is predictable.

## Inline Spinner
Use for small local actions.

## Page Loader
Use only when the entire screen truly cannot render.

Avoid showing an empty white page with only a spinner.

---

# 34. Empty States

Every empty state should contain:

1. Clear title
2. One-sentence explanation
3. Optional action
4. Optional subtle icon/illustration

Avoid:

```text
No data
```

as the entire experience.

---

# 35. Error States

Errors must explain:

- What happened
- What the user can do
- Whether retry is possible

Never expose raw backend exceptions to users.

---

# 36. Offline State

When applicable:

- Clearly indicate offline mode.
- Preserve cached content.
- Queue safe operations if supported.
- Never imply a write succeeded unless confirmed.

---

# 37. Success States

Use concise success feedback.

Do not use full-screen celebrations for ordinary academic actions.

Premium celebration is acceptable only for:

- Graduation milestone
- Major achievement
- Official completion

---

# 38. Motion

Motion is functional, restrained, and consistent.

The previously discussed liquid-drop logo animation is **not** part of this Design System.

---

## 38.1 Motion durations

Recommended:

```text
micro      100–150ms
standard   180–240ms
panel      240–320ms
hero       320–450ms
```

Avoid long animations during frequent workflows.

---

## 38.2 Motion uses

Allowed:

- Route transition
- Tab transition
- Expansion/collapse
- Button state
- Loading
- Card insertion
- Dialog
- Hero image transition

Avoid decorative animation that delays task completion.

---

## 38.3 Reduced motion

Respect system accessibility settings.

When reduced motion is enabled:

- Disable large movement
- Avoid parallax
- Reduce scale transitions
- Prefer fade/instant transition

---

# 39. Imagery

## 39.1 University photography

Repository assets include campus imagery.

Use photography for:

- Welcome
- Login background/hero
- University profile
- Campus information
- Institutional announcements

Do not use large campus photographs behind dense text without overlay.

---

## 39.2 Image overlay

When text sits on photography:

```text
navy gradient overlay
```

Contrast must remain accessible.

---

## 39.3 College artwork

College artwork may be used in:

- College hero
- College selection
- College portal
- College cards
- Promotional academic content

Do not use college artwork behind forms or tables.

---

## 39.4 Image consistency

All college images must follow consistent:

- Aspect ratio
- Crop
- Overlay
- Radius
- Brightness
- Text placement

---

# 40. Iconography

Use one icon family consistently.

Preferred:

- Material Symbols / Material Icons aligned with Flutter

Rules:

- Same stroke/fill style per screen.
- Do not mix random icon packs.
- Status icons must be immediately understandable.
- Avoid decorative icons with no semantic meaning.

---

# 41. Authentication

Authentication must be intentionally simple.

Recommended structure:

```text
Official HUE identity
Short welcome copy
Student ID / Email
Password
Sign in
Forgot password
Secondary account/help link
```

Do not overload Login with dashboards, statistics, or heavy artwork.

---

# 42. First Launch

No mandatory appearance/language setup screen.

Flow:

```text
Launch
  ↓
Detect language
  ↓
Detect system theme
  ↓
Authentication / authorized destination
```

User preferences remain changeable later.

---

# 43. Academic overview (secondary to Home / Feed)

Academic summary screens may answer:

1. What do I have next?
2. Is anything urgent?
3. How am I doing academically?
4. What action should I take now?

Recommended hierarchy:

```text
Greeting / identity
Next academic event
Urgent alerts
Quick actions
Academic snapshot
Upcoming schedule
Recent announcements
```

Do not present every module equally.

---

# 44. Management overview (permission-driven secondary destination)

Management overview screens may answer:

1. What needs attention?
2. What changed?
3. What requires approval?
4. What is abnormal?
5. What is the operational state?

Recommended hierarchy:

```text
Operational overview
Attention items
KPIs
Trends
Pending approvals
Recent changes
Shortcuts
```

---

# 45. Course Screen Pattern

Recommended structure:

```text
Course header
Instructor / metadata
Next session
Progress / status
Tabs:
  Overview
  Materials
  Assignments
  Attendance
  Grades
```

Only show tabs that actually exist.

---

# 46. Registration Pattern

Registration must prioritize correctness.

Recommended:

```text
Term status
Eligibility / blocks
Available courses
Prerequisite status
Credits selected
Schedule conflicts
Review
Confirmation
```

Warnings must clearly distinguish:

- Hard block
- Warning
- Informational notice

---

# 47. Grades Pattern

Grades should clearly show:

- Course
- Credit hours
- Component grades
- Total
- Letter grade
- GPA contribution
- Term GPA
- Cumulative GPA

Never use color alone to communicate pass/fail.

---

# 48. Attendance Pattern

Use clear status:

```text
Present
Absent
Late
Excused
```

Provide textual labels with color.

---

# 49. Digital ID

Digital ID is one of the few premium surfaces.

Allowed:

- Navy gradient
- Gold accent
- subtle glass
- security pattern
- Eye of Horus watermark
- controlled animation

Must remain:

- High contrast
- Scannable
- Fast to open
- Readable offline if supported

---

# 50. Feed Pattern

Feed must prioritize content clarity.

Post structure:

```text
Author
Role/faculty metadata
Timestamp
Content
Media
Engagement
Actions
```

Avoid excessive decoration around each post.

---

# 51. Profile

Profile should separate:

### Public academic identity
- Name
- Avatar
- College
- Department
- Role
- Bio

### Private account information
- Contact
- Sensitive academic/account fields

Never visually encourage users to believe protected fields are directly editable if authorization forbids it.

---

# 52. Settings

Settings should use grouped sections.

Recommended:

```text
Account
Appearance
Language
Notifications
Privacy
Accessibility
Help
About
Sign out
```

Do not create custom visual styling for every settings row.

---

# 53. Accessibility

Minimum requirements:

- WCAG AA contrast where applicable
- 44x44 minimum interactive target
- Screen-reader labels
- Logical focus order
- Keyboard support on desktop/web
- Text scaling
- Reduced motion
- Color-independent status meaning
- RTL correctness

Accessibility is not optional polish.

---

# 54. RTL

Arabic is a first-class interface, not a mirrored afterthought.

Must verify:

- Alignment
- Navigation order
- Back arrow direction
- Progress indicators
- Charts
- Date formatting
- Icons with directional meaning
- Tables
- Forms
- Mixed Arabic/English values

---

# 55. Dates and Numbers

Display dates according to active locale.

Store dates in backend canonical form.

Do not hardcode English month names.

Numbers may remain Western digits unless product requirements explicitly change.

---

# 56. Responsive Breakpoints

Recommended:

```text
compact     < 600
medium      600–1023
expanded    1024–1439
large       >= 1440
```

Do not build screens around one specific phone size.

---

# 57. Responsive Behavior

## Compact
- Single column
- Bottom navigation
- Bottom sheets
- Stacked cards

## Medium
- Wider cards
- Navigation rail
- Split content where useful

## Expanded
- Side navigation
- Multi-column layouts
- Persistent panels
- Data tables

## Large
- Max-width content
- Higher density
- Avoid excessive empty space

---

# 58. Desktop Content Width

Content should usually have a maximum readable width.

Recommended:

```text
standard content: 1200–1440
reading content: 720–900
```

Do not stretch text to the full width of ultrawide screens.

---

# 59. Design Tokens in Flutter

Core design values must live in centralized files.

Recommended structure:

```text
lib/core/theme/
├── app_colors.dart
├── app_spacing.dart
├── app_radius.dart
├── app_borders.dart
├── app_shadows.dart
├── app_text_styles.dart
├── app_theme.dart
└── app_motion.dart
```

If current project organization differs, migrate gradually rather than duplicating tokens.

---

# 60. Shared Component Library

Reusable components belong in a shared component layer.

Recommended:

```text
lib/shared/widgets/
├── app_button.dart
├── app_card.dart
├── app_text_field.dart
├── app_badge.dart
├── app_chip.dart
├── app_dialog.dart
├── app_empty_state.dart
├── app_error_state.dart
├── app_loading.dart
├── app_section_header.dart
├── app_stat_card.dart
├── app_avatar.dart
└── app_search_field.dart
```

Only create a shared component when it is genuinely reusable.

---

# 61. Component Variants

Use explicit variants rather than copy/paste style changes.

Example:

```dart
AppButton(
  variant: AppButtonVariant.primary,
)
```

Preferred over:

```dart
ElevatedButton(
  style: ButtonStyle(
    // arbitrary one-off styling
  ),
)
```

---

# 62. No Raw Styling Rule

Do not introduce arbitrary values in feature widgets when an existing token fits.

Avoid:

```dart
Color(0xFF...)
EdgeInsets.all(17)
BorderRadius.circular(13)
TextStyle(fontSize: 15.5)
```

when standardized tokens exist.

Feature code should consume design tokens/components.

---

# 63. Codex Design Rule

Before creating or modifying UI, Codex must inspect:

```text
docs/DESIGN_SYSTEM.md
lib/core/theme/
lib/shared/widgets/
```

Codex must reuse the existing system before introducing a new visual primitive.

---

# 64. New Component Decision Rule

Before creating a new component:

1. Search shared widgets.
2. Check if an existing component can be extended.
3. Check Design System tokens.
4. Create a new component only when necessary.
5. Document reusable variants.

---

# 65. Visual Consistency Checklist

Before completing a UI task, verify:

- Uses approved colors
- Uses approved spacing
- Uses approved radius
- Uses shared typography
- Uses correct card family
- Uses correct status colors
- Supports Light/Dark
- Supports RTL/LTR
- Responsive at all breakpoints
- Loading state exists
- Empty state exists
- Error state exists
- Accessibility labels exist
- No arbitrary new component style

---

# 66. Mobile-first content rules

Compact experiences may use:

- Larger touch areas
- More visual hierarchy
- Hero academic cards
- College imagery
- Quick actions
- Timetable-first surfaces
- Moderate animation

Mobile layouts must remain institutional and must not become playful or game-like.

---

# 67. Management workflow rules

Permissioned management screens may use:

- Dense tables
- Compact filters
- Sticky toolbars
- Split panes
- Bulk actions
- Audit metadata
- Advanced search
- Analytics

Management workflows may use compact filters and tables where the task needs
them, while retaining the shared Horus application shell and brand surfaces.

---

# 68. Status Density

Compact:

```text
more whitespace
larger cards
fewer simultaneous controls
```

Expanded management workflows:

```text
tighter spacing
smaller controls
more visible information
```

Both still use the same tokens.

---

# 69. Theme Mapping

## Light theme

Primary:

```text
navy600
```

Accent:

```text
gold500
```

Background:

```text
warm white / navy050
```

Surface:

```text
white
```

---

## Dark theme

Primary:

```text
navy400
```

Accent:

```text
gold400
```

Background:

```text
#081421
```

Surface:

```text
navy900
```

---

# 70. Premium Visual Rule

Premium does not mean:

- More shadows
- More gradients
- More blur
- More gold
- More animation

Premium means:

- Better hierarchy
- Better spacing
- Better typography
- Precise contrast
- Consistent materials
- Deliberate brand placement

---

# 71. University Photography Rule

Campus photography should feel authentic.

Do not:

- Overprocess
- Oversaturate
- Use strong filters
- Mix unrelated visual treatments

Use:

- Subtle navy overlay
- Controlled crop
- Clear focus
- Consistent aspect ratio

---

# 72. Eye of Horus Motif

The Eye of Horus may be used as a subtle design motif.

Allowed:

- Low-opacity watermark
- Digital ID security pattern
- Authentication background accent
- Empty-state decoration
- Premium hero texture

Recommended opacity:

```text
2%–6%
```

Do not use it at high opacity behind body text.

---

# 73. Loading Identity

The application may use a subtle HUE identity during startup.

It must be:

- Short
- Non-blocking
- Accessible
- Not dependent on complex decorative animation
- Skippable by system completion

No special liquid-drop animation is specified.

---

# 74. Authentication Background

Preferred options:

### Option A
Clean surface with subtle HUE motif.

### Option B
Campus photography with navy gradient overlay.

### Option C
Split layout on desktop:
- identity/photography side
- login form side

Mobile should prioritize form clarity.

---

# 75. System Feedback

Every asynchronous user action must result in one of:

```text
Loading
Success
Error
Retry
```

Never leave the UI in an ambiguous state.

---

# 76. Destructive Actions

Examples:

- Delete
- Remove
- Revoke
- Cancel enrollment
- Ban
- Archive

Must use:

- Danger color
- Clear confirmation
- Exact object name where possible

Avoid vague confirmation:

```text
Are you sure?
```

Prefer:

```text
Remove this student from the group?
```

---

# 77. Permissions UX

Users should not see actions they cannot normally perform.

However:

UI hiding is not authorization.

Backend authorization remains authoritative.

When permission changes while the app is running:

- refresh permission state
- invalidate inaccessible routes
- handle API denial gracefully

---

# 78. Skeleton Rules

Skeletons should mimic final content shape.

Do not use random blocks.

Examples:

- Post skeleton
- Course card skeleton
- Table row skeleton
- Dashboard KPI skeleton

---

# 79. Charts

Control charts must:

- Use accessible colors
- Include labels/legends
- Support hover/keyboard where possible
- Avoid 3D chart effects
- Avoid unnecessary pie charts
- Display exact values in tooltips/tables

Gold should be an accent, not every data series.

---

# 80. Analytics Colors

Chart palettes must be separate from brand tokens.

Brand Navy and Gold may highlight the primary series.

Additional data series should use controlled accessible colors.

---

# 81. Notifications

Priority hierarchy:

```text
Critical
Important
Normal
Informational
```

Do not use red for all notifications.

Unread indication should not rely only on color.

---

# 82. Search

Search fields should:

- Use shared search component
- Support clear action
- Preserve query where useful
- Debounce remote search
- Show empty/no-result state
- Support RTL

---

# 83. Filters

On mobile:

```text
bottom sheet
```

On desktop:

```text
toolbar / side panel
```

Active filters must be visible and removable.

---

# 84. Pagination

Large datasets must not load indefinitely without control.

Use:

- Pagination
- Cursor-based incremental loading
- Virtualized lists

Never break selected/favorite/cart-like state when moving between pages.

---

# 85. Media

Media components must support:

- Loading
- Failure
- Retry
- Placeholder
- Aspect ratio
- Full-screen preview when applicable

Do not auto-play audio/video by default.

---

# 86. File Components

File rows/cards must show:

- Name
- Type
- Size
- Owner/uploader if useful
- Date
- Download/open action
- Permission state

---

# 87. Dark Mode Imagery

Do not invert photos.

Apply subtle overlays when needed.

Logo variant must match surface.

---

# 88. Internationalization

No hardcoded user-facing strings.

All UI text must use localization resources.

Do not concatenate translated fragments to form sentences.

---

# 89. Truncation

Use truncation only when:

- Full value is available by expansion/tooltip/details
- Context remains clear

Never truncate:

- Critical error
- Important confirmation
- Grade result
- Financial total

without a way to inspect it.

---

# 90. Content Tone

UI language should be:

- Clear
- Formal but not bureaucratic
- Brief
- Action-oriented

Avoid marketing language inside operational workflows.

---

# 91. Empty Dashboard

If no data exists:

Do not show broken/empty KPI shells.

Show a meaningful state explaining why no data exists.

---

# 92. Onboarding

Onboarding should be minimal.

Do not make users configure preferences already inferable from:

- System language
- System theme
- Account role
- University profile

Only ask for information that cannot be inferred safely.

---

# 93. Avatar Rules

Avatar priority:

1. User uploaded photo
2. Official university avatar if available
3. Initials placeholder

Never use unrelated stock faces as production fallback.

---

# 94. Badges

Role badges should be textual and subtle.

Example:

```text
Professor
Teaching Assistant
Student
```

Do not create a different bright color for every role.

---

# 95. Academic Status

Academic status should use standardized labels.

Example:

```text
Registered
Pending
Approved
Rejected
Completed
Withdrawn
```

Each must have one consistent visual state system-wide.

---

# 96. Financial Status

Examples:

```text
Paid
Pending
Overdue
Cancelled
Refunded
```

Use standardized semantic colors and wording.

---

# 97. Design Audit Rule

During migration of legacy screens, classify each screen:

```text
Keep
Improve
Replace
Standardize
Remove
```

Do not redesign every screen at once without tracking functional parity.

---

# 98. Migration Strategy

Recommended migration order:

1. Theme/tokens
2. Shared components
3. Authentication
4. App shell/navigation
5. Dashboard
6. Courses
7. Registration
8. Grades
9. Attendance
10. Profile
11. Settings
12. Feed
13. Digital ID
14. College portal
15. Control/admin workflows

---

# 99. No Big-Bang Rewrite

Do not replace the full UI in one uncontrolled commit.

Migrate screen-by-screen while preserving:

- Routing
- Data behavior
- Authorization
- Localization
- Existing functionality

---

# 100. Definition of Done for UI Work

A UI task is complete only when:

1. Screen uses Design System tokens.
2. No arbitrary styling is introduced.
3. Light mode verified.
4. Dark mode verified.
5. Arabic RTL verified.
6. English LTR verified.
7. Compact layout verified.
8. Expanded layout verified when relevant.
9. Loading state verified.
10. Empty state verified.
11. Error state verified.
12. Accessibility considered.
13. Existing behavior remains functional.
14. Static analysis/tests pass.

---

# 101. Flutter Implementation Rules

Prefer:

```dart
Theme.of(context)
```

and centralized tokens.

Avoid creating large local theme blocks in individual screens.

Reusable visual components should not know business logic.

Feature widgets may compose shared components but should not redefine them.

---

# 102. Material 3

Horus uses Material 3 as the base interaction system.

Material components should be customized through:

```text
ThemeData
ColorScheme
TextTheme
Component themes
```

before introducing custom replacements.

---

# 103. Theme Components

`AppTheme` should centrally configure at minimum:

- ColorScheme
- Scaffold
- AppBar
- NavigationBar
- NavigationRail
- Card
- Divider
- InputDecoration
- ElevatedButton
- OutlinedButton
- TextButton
- Dialog
- BottomSheet
- Snackbar
- Checkbox
- Radio
- Switch
- DataTable where applicable

---

# 104. Existing Design Assets

Current design foundation already includes concepts equivalent to:

```text
AppColors
AppSpacing
AppRadius
AppBorders
AppTextStyles
AppTheme
Shared Widgets
```

These should be evolved into the canonical design system rather than duplicated.

---

# 105. Final Brand Direction

Horus is not intended to look like a generic university app.

The final experience should be recognizable through:

```text
Deep Navy
+
Controlled Gold
+
Official HUE Identity
+
Academic hierarchy
+
Modern digital clarity
+
Consistent responsive components
```

The product should feel institutional without feeling old, and modern without becoming visually experimental.

---

# 106. Codex Enforcement Summary

For every UI task:

```text
READ:
docs/DESIGN_SYSTEM.md
AGENTS.md
relevant theme files
relevant shared components
```

Then:

```text
REUSE → EXTEND → CREATE
```

in that order.

Codex must not invent:

- Random colors
- Random radii
- Random spacing
- New button styles
- New card families
- New input styles
- New typography scales

without updating the Design System intentionally.

---

# 107. Approval Baseline

The following decisions are approved as the current baseline:

- HUE Navy + Gold remains the core identity.
- Official HUE logo assets remain authoritative.
- Light + Dark are supported.
- Theme defaults to System.
- Language defaults to device language.
- Unsupported language falls back to English.
- Arabic is RTL.
- English is LTR.
- Mandatory first-run language/theme selection is removed.
- User-selectable design style is removed.
- Horus is one university super app; roles change capabilities, not product identity.
- Compact, medium, and expanded layouts adapt composition to the device.
- Home opens the university feed; academic summaries and management workflows are secondary destinations.
- Glassmorphism is limited to premium surfaces.
- Gold is an accent, not a universal primary/action/status color.
- The liquid-drop logo animation concept is not part of the design system.
- UI authorization visibility never replaces backend authorization.
- All new UI must be responsive and token-based.

---

# 108. Next Implementation Step

Before broad screen redesign:

1. Audit current theme files.
2. Map existing values to these tokens.
3. Create missing tokens only once.
4. Standardize shared components.
5. Build visual test/example screens for:
   - Buttons
   - Inputs
   - Cards
   - Statuses
   - Navigation
   - Typography
   - Light/Dark
6. Migrate real application screens gradually.

---

**End of HORUS Design System v1.0**
