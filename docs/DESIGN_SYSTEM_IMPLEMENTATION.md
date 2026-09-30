# Horus Design System Migration

## Implemented

- Central Horus navy, gold, neutral, and semantic color scales in
  `lib/core/theme/app_colors.dart`.
- Material 3 Light and Horus Navy Dark themes, with shared component styling,
  normalized Cairo typography, and elevation tokens in `lib/core/theme/`.
- Canonical spacing, radius, border, shadow, motion, and responsive breakpoint
  tokens. Breakpoints are compact below 600 px, medium from 600 to 1023 px,
  expanded from 1024 to 1439 px, and large from 1440 px.
- Shared buttons expose primary, secondary, tertiary, and destructive variants.
  Cards expose standard, academic, and premium variants. Existing button and
  university-card wrappers remain for screens outside this migration batch.
- Inputs, badges, progress bars, and skeletons use the shared theme and tokens.
- Appearance defaults to System and Settings offers System, Light, and Dark.
  Existing `theme_mode` values continue to load; unknown values resolve to
  System.
- Startup restores a saved language when present. Otherwise Arabic devices use
  Arabic and other supported device locales are selected; unsupported locales
  fall back to English. The language remains changeable in Settings.
- The splash display is short and continues directly to authentication. The
  former language, theme, and UI-style onboarding routes and screens were
  removed; the welcome route remains available and directs users to sign-in.
- Login uses the official HUE logo assets, existing authentication controller,
  and HUE campus photography on wide layouts. Compact layouts keep the form
  focused and single-column.
- The shared home shell retains its role-derived tabs, uses Material bottom
  navigation below 600 px, and uses NavigationRail on wider layouts.
- Main academic and student flows use repository state and shared loading,
  error, and empty components. Digital ID and payment summaries do not invent
  missing user or financial data.
- College/control dashboards consume scoped records; static embedded dean
  names, college headcounts, and research totals were removed from the legacy
  catalog.
- Feed, enrollment, professor screens, settings, notifications, forums, and
  sessions received visual/data cleanup. Unsupported inert actions were removed.

## Retired visual-style preference

There is no selectable Classic/Modern/Glass preference, style provider, or
persisted visual-style value consulted on startup. Some older screen files
still carry constant `isGlass = false` branches and glass-named compatibility
widgets; they do not expose a user-selectable style or enable blur.

## Scope remaining

The listed primary flows now use the shared theme or a lighter existing
presentation, but not every section has been visually compared route-by-route
at phone, tablet, and desktop widths. Control workflows still need a full
density/table/filter pass. Glass-named shared widgets remain as compatibility
wrappers and render the standard surface treatment without large blur.

## Follow-up order

1. Student dashboard and Digital ID.
2. Grades, attendance, schedules, and registration workflows.
3. Feed, shared files, and messaging.
4. College portal and administrative dashboards/tables.

Complete responsive visual QA and migrate remaining bespoke card/input/action
styles using these tokens. Keep authorization and database contracts unchanged.
