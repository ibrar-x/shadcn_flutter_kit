# Registry Instructions

This document describes the current registry layout, the components.json schema, and how the copy/paste install works.

## Registry Folder Structure (current)

```
registry/
  components.json
  components.schema.json
  folder_structure.json
  shared/
    primitives/
    theme/
    utils/
    tokens/
  components/
    <category>/
      <component_id>/
        <component_id>.dart
        README.md
        meta.json
        preview.dart (optional)
        _impl/
          core/
          styles/
          themes/
          variants/
          utils/
          state/
          extensions/
  composites/
    <category>/
      <composite_id>/
        <composite_id>.dart
        README.md
        meta.json
        _impl/ (same taxonomy)
```

Notes:
- Each Dart file should contain a single public class; helpers live under `_impl/` folders by taxonomy.
- `components.json` is the source of truth for installable files and dependencies.
- `components.schema.json` validates `components.json`.

## components.json Structure (summary)

Top-level keys:
- `schemaVersion`: registry manifest version
- `defaults`: install paths
- `shared`: shared file groups (primitives, theme, utils)
- `components`: list of installable components (and composites)

Component entry shape:
```json
{
  "id": "error_system",
  "name": "Error System",
  "description": "...",
  "category": "utility",
  "tags": ["error", "system"],
  "files": [
    { "source": "registry/components/utility/error_system/error_system.dart",
      "destination": "{installPath}/components/utility/error_system/error_system.dart" }
  ],
  "shared": ["theme", "radix_icons"],
  "dependsOn": ["button", "card", "dialog"],
  "pubspec": { "dependencies": { "gap": "^3.0.1" } },
  "assets": [],
  "postInstall": []
}
```

Shared entry shape:
```json
{
  "id": "theme",
  "description": "Core theme data, color schemes, typography.",
  "files": [
    { "source": "registry/shared/theme/theme.dart",
      "destination": "{sharedPath}/theme/theme.dart" }
  ]
}
```


## Current Shared Groups
- `theme`: Core theme data, color schemes, and typography.
- `color_extensions`: Color utilities used by theme and components.
- `clickable`: Shared interactive primitive for state-aware widgets.
- `form_control`: Controlled component primitives for form integration.
- `form_value_supplier`: Minimal form value supplier interfaces.
- `menu_group`: Lightweight menu group metadata shared across components.
- `style_value`: Style helper for resolving widget/theme/default values.
- `border_utils`: Border radius helpers used by outlined containers.
- `constants`: Shared timing constants used across animations.
- `animation_queue`: Queue-driven animation controller used by carousel.
- `wrap_utils`: Value wrapping helpers for index looping.
- `animated_value_builder`: Value interpolator used by animated dividers and helpers.
- `slider_value`: Shared single/range value model used by slider components.
- `util`: General utility helpers, extensions, and context actions.
- `controlled_animation`: Lightweight wrapper for controlled animation curves.
- `text_input_utils`: Text input helpers for replacing or inserting text.
- `chip_utils`: Tokenizer helpers for chip-style inputs.
- `geometry_extensions`: Geometry helpers for optional resolution.
- `hidden`: Hidden widget with size-preserving transitions.
- `overlay`: Overlay and popover primitives for anchored surfaces.
- `hover`: Hover detection and delayed show helpers.
- `subfocus`: Hierarchical focus utilities for keyboard navigation.
- `basic_layout`: Basic layout helper for leading/content/trailing rows.
- `text_modifiers`: Text modifier helpers for fluent styling.
- `icon_extensions`: Icon helper extensions (small, muted).
- `localizations`: Minimal localized strings for registry components.
- `localizations_extensions`: Localization helpers for time, duration, and date parts.
- `fade_scroll`: Scroll edge fade helper for scrollable content.
- `keyboard_shortcut_utils`: Keyboard shortcut helpers and display handle.
- `resizer`: Resizable layout helpers for tables and panels.
- `wrap_utils`: Numeric wrap helpers for cyclic animations.
- `animation_queue`: Animation queue controller for chained numeric animations.
- `lucide_icons`: Lucide icon font mappings used by controls.
- `radix_icons`: Radix icon font mappings used by menus.
- `outlined_container`: Outlined container primitive with surface blur support.
- `sheet_overlay`: Sheet overlay context helper.
- `focus_outline`: Focus outline primitive for accessibility states.
- `axis`: Axis alignment helpers used by chat and layout components.
- `phone_number`: Phone number primitives for form validation and formatting.

## Current Widgets/Components (by category)
### animation
- `timeline_animation` — Timeline Animation

### control
- `button` — Button
- `clickable` — Clickable
- `command` — Command
- `hover` — Hover
- `patch` — Click Detector
- `scrollbar` — Scrollbar
- `scrollview` — Scroll View Interceptor
- `toggle` — Toggle

### display
- `avatar` — Avatar
- `avatar_group` — Avatar Group
- `badge` — Badge
- `calendar` — Calendar
- `carousel` — Carousel
- `chat` — Chat
- `chip` — Chip
- `circular_progress_indicator` — Circular Progress Indicator
- `code_snippet` — Code Snippet
- `divider` — Divider
- `dot_indicator` — Dot Indicator
- `empty_state` — Empty State
- `feature_carousel` — Feature Carousel
- `icon` — Icon Extensions
- `keyboard_shortcut` — Keyboard Shortcut
- `linear_progress_indicator` — Linear Progress Indicator
- `number_ticker` — Number Ticker
- `progress` — Progress
- `selectable` — Selectable Text
- `skeleton` — Skeleton
- `spinner` — Spinner
- `text` — Text
- `tracker` — Tracker
- `tree` — Tree
- `triple_dots` — More Dots

### form
- `autocomplete` — Autocomplete
- `checkbox` — Checkbox
- `chip_input` — Chip Input
- `choices` — Choices
- `color_input` — Color Input
- `color_picker` — Color Picker
- `control` — Control
- `date_picker` — Date Picker
- `dropzone` — Dropzone
- `file_input` — File Input
- `file_picker` — File Upload
- `form` — Form
- `form_field` — Form Field
- `formatted_input` — Formatted Input
- `formatter` — Formatter
- `history` — Color History
- `hsl` — HSL Color Slider
- `hsv` — HSV Color Slider
- `input` — Input
- `input_otp` — Input OTP
- `item_picker` — Item Picker
- `multiple_choice` — Multiple Choice
- `multiselect` — Multi Select
- `number_input` — Number Input
- `object_input` — Object Input
- `phone_input` — Phone Input
- `radio_card` — Radio Card
- `radio_group` — Radio Group
- `select` — Select
- `slider` — Slider
- `star_rating` — Star Rating
- `switch` — Switch
- `text_area` — Text Area
- `text_field` — Text Field
- `time_picker` — Time Picker
- `validated` — Validated

### layout
- `accordion` — Accordion
- `alert` — Alert
- `app` — App
- `app_bar` — App Bar
- `basic` — Basic
- `card` — Card
- `card_image` — CardImage
- `collapsible` — Collapsible
- `fade_scroll` — Fade Scroll
- `group` — Group
- `hidden` — Hidden
- `material` — Material
- `media_query` — Media Query Visibility
- `outlined_container` — Outlined Container
- `overflow_marquee` — Overflow Marquee
- `resizable` — Resizable
- `scaffold` — Scaffold
- `scrollable_client` — Scrollable Client
- `sortable` — Sortable
- `stage_container` — Stage Container
- `steps` — Steps
- `table` — Table
- `timeline` — Timeline
- `window` — Window

### navigation
- `breadcrumb` — Breadcrumb
- `expandable_sidebar` — Expandable Sidebar
- `navigation_bar` — Navigation Bar
- `navigation_menu` — Navigation Menu
- `navigation_rail` — Navigation Rail
- `navigation_sidebar` — Navigation Sidebar
- `pagination` — Pagination
- `stepper` — Stepper
- `subfocus` — Subfocus
- `switcher` — Switcher
- `tab_container` — Tab Container
- `tab_list` — Tab List
- `tab_pane` — Tab Pane
- `tabs` — Tabs

### overlay
- `alert_dialog` — AlertDialog
- `context_menu` — Context Menu
- `dialog` — Dialog
- `drawer` — Drawer
- `dropdown_menu` — Dropdown Menu
- `eye_dropper` — Eye Dropper
- `hover_card` — Hover Card
- `menu` — Menu
- `menubar` — Menubar
- `overlay` — Overlay
- `popover` — Popover
- `popup` — Popup
- `refresh_trigger` — Refresh Trigger
- `sheet` — Sheet
- `swiper` — Swiper
- `toast` — Toast
- `tooltip` — Tooltip

### utility
- `alpha` — Alpha
- `async` — Async
- `color` — Color Utils
- `debug` — Debug
- `error_system` — Error System
- `focus_outline` — Focus Outline
- `icon_fonts` — Icon Fonts
- `image` — Image
- `locale_utils` — Locale Utils
- `repeated_animation_builder` — Repeated Animation Builder
- `shadcn_localizations` — Shadcn Localizations
- `shadcn_localizations_en` — Shadcn Localizations (EN)
- `shadcn_localizations_extensions` — Shadcn Localizations Extensions
- `typography_fonts` — Typography Fonts
- `wrapper` — Wrapper

## How Copy/Paste Install Works (CLI flow)
1) User runs `flutter_shadcn add <component-id>` (or via init).
2) CLI loads `registry/manifests/components.json` and validates it with `components.schema.json`.
3) CLI resolves the component entry by id.
4) CLI expands:
   - `files` list for the component
   - `shared` groups (adds their files)
   - `dependsOn` components (adds their files and shared groups)
5) Files are copied to `{installPath}` (defaults to `lib/ui/shadcn`).
6) Shared files are copied to `{sharedPath}` (defaults to `lib/ui/shadcn/shared`).
7) `pubspec.dependencies` are merged into the project pubspec as needed.
8) `assets` and `postInstall` steps are applied if defined.

Key rules:
- The registry is the single source of truth; do not hand-copy files outside it.
- Keep `_impl` taxonomy consistent so CLI can sync and validate correctly.
- Update `components.json` whenever files are added/removed or shared dependencies change.

