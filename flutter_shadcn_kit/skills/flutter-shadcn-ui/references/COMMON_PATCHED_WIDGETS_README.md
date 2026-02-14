# Common Patched Widgets

Use this file before creating new registry components. Prefer these registry/shared widgets over Material/Cupertino widgets where equivalents exist.

## Core guidance
- Prefer `registry/components/*` widgets (e.g., `scaffold`, `button`, `select`, `drawer`, `dialog`).
- Prefer `registry/shared/*` primitives and theme utilities for behavior/styling helpers.
- If no registry equivalent exists for primitive layout elements (`Row`, `Column`, `Flex`, `Container`), use `package:flutter/widgets.dart` (not Material widgets).

## Flutter/Material To Registry Extraction
This section lists commonly used Flutter/Material widgets and the closest registry equivalent(s) that already exist.

- `Scaffold` -> `layout/scaffold` (`Scaffold`)
- `AppBar` -> `layout/scaffold` (`AppBar`)
- `Card` -> `layout/card` (`Card`, `SurfaceCard`)
- `Divider` / `VerticalDivider` -> `display/divider`
- `Chip` / `InputChip` / `ChoiceChip` -> `display/chip`
- `TextField` -> `form/text_field` or `form/input`
- `DropdownButton` / `DropdownMenu` -> `form/select`
- `Checkbox` -> `form/checkbox`
- `RadioListTile` / `Radio` groups -> `form/radio_group`
- `Switch` -> `form/switch`
- `Slider` / `RangeSlider` -> `form/slider`
- `LinearProgressIndicator` -> `display/linear_progress_indicator` or `display/progress`
- `CircularProgressIndicator` -> `display/circular_progress_indicator`
- `Tooltip` -> `overlay/tooltip`
- `AlertDialog` -> `overlay/alert_dialog` or `overlay/dialog`
- `Dialog` -> `overlay/dialog`
- `BottomSheet` / `showModalBottomSheet` -> `overlay/drawer` (`openSheet`, `openSheetOverlay`)
- `Drawer` -> `overlay/drawer` (`openDrawer`, `openDrawerOverlay`)
- `PopupMenuButton` / `PopupMenuItem` -> `overlay/menu`, `overlay/dropdown_menu`, `overlay/context_menu`
- `TabBar` / `TabBarView` / `DefaultTabController` -> `navigation/tabs`, `navigation/tab_list`, `navigation/tab_container`, `navigation/tab_pane`
- `Stepper` -> `navigation/stepper` or `layout/steps`
- `Pagination` patterns -> `navigation/pagination`
- `Breadcrumb` patterns -> `navigation/breadcrumb`
- `SnackBar` / transient toasts -> `overlay/toast`
- `ExpansionPanelList` / collapsible sections -> `layout/accordion` or `layout/collapsible`
- `DataTable` -> `layout/table`
- `ListWheel` / carousels -> `display/carousel` or `display/feature_carousel`
- `RefreshIndicator` -> `overlay/refresh_trigger`
- `Autocomplete` -> `form/autocomplete`
- `CalendarDatePicker` / date dialogs -> `display/calendar` + `form/date_picker`
- `TimePicker` -> `form/time_picker`

### Framework-only primitives (no direct registry replacement required)
- `Row`, `Column`, `Flex`, `Expanded`, `Spacer`, `Stack`, `Positioned`, `Container`, `SizedBox`, `Padding`, `Align`, `Center`, `Wrap`, `SafeArea`, `LayoutBuilder`
- Use these from `package:flutter/widgets.dart` unless a registry component gives a better high-level abstraction.

## Shared Primitives And Utilities
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
- `lucide_icons`: Lucide icon font mappings used by controls.
- `radix_icons`: Radix icon font mappings used by menus.
- `outlined_container`: Outlined container primitive with surface blur support.
- `sheet_overlay`: Sheet overlay context helper.
- `focus_outline`: Focus outline primitive for accessibility states.
- `axis`: Axis alignment helpers used by chat and layout components.
- `phone_number`: Phone number primitives for form validation and formatting.
- `README`: Shared helpers from README.md.
- `__borrow_info`: Shared helpers from utils/_impl/core/__borrow_info.dart.
- `axis_insets`: Shared helpers from utils/_impl/core/axis_insets.dart.
- `axis_insets_directional`: Shared helpers from utils/_impl/core/axis_insets_directional.dart.
- `axis_insets_geometry`: Shared helpers from utils/_impl/core/axis_insets_geometry.dart.
- `bootstrap_icons`: Shared helpers from icons/bootstrap_icons.dart.
- `bootstrap_icons_list`: Shared helpers from icons/bootstrap_icons_list.dart.
- `chart_color_scheme`: Shared helpers from theme/_impl/core/chart_color_scheme.dart.
- `color_scheme`: Shared helpers from theme/_impl/core/color_scheme.dart.
- `color_schemes`: Shared helpers from theme/_impl/core/color_schemes.dart.
- `color_shades`: Shared helpers from theme/_impl/core/color_shades.dart.
- `design_tokens`: Shared helpers from theme/_impl/core/design_tokens.dart.
- `generated_colors`: Shared helpers from theme/generated_colors.dart.
- `lucide_icons_list`: Shared helpers from icons/lucide_icons_list.dart.
- `platform_utils`: Shared helpers from utils/platform_utils.dart.
- `preset_themes`: Shared helpers from theme/preset_themes.dart.
- `radix_icons_list`: Shared helpers from icons/radix_icons_list.dart.
- `single_chart_color_scheme`: Shared helpers from theme/_impl/core/single_chart_color_scheme.dart.
- `tween_utils`: Shared helpers from utils/tween_utils.dart.
- `typography`: Shared helpers from theme/typography.dart.
- `widget_extensions`: Shared helpers from utils/widget_extensions.dart.
- `shared_manifest`: Shared helpers from shared_manifest.json.
- `shared_manifest.schema`: Shared helpers from shared_manifest.schema.json.
- `density`: Shared helpers from theme/_impl/core/density.dart.

## Registry Components By Category
### control
- `button`: Shadcn-style button system with variants, toggles, and groups.
- `clickable`: State-aware gesture surface with hover, focus, and press handling.
- `command`: Command palette with search, keyboard navigation, and customizable result builders.
- `scrollbar`: Themeable scrollbar wrapper built on RawScrollbar.
- `scrollview`: Middle-click drag scroll interceptor for desktop/web.
- `hover`: Hover timing helpers plus lightweight state tracking widgets.
- `patch`: Tracks consecutive taps and exposes click count details.

### display
- `chat`: Chat bubbles, groups, and tail helpers for conversational layouts.
- `badge`: Compact label/status components built on button styles.
- `avatar`: Initials/photo avatar with badge and group support.
- `chip`: Compact tag-style button with optional leading/trailing widgets.
- `divider`: Horizontal and vertical separators with optional label support.
- `dot_indicator`: Animated dot indicator for carousels/steppers with optional tap behavior.
- `circular_progress_indicator`: Determinate/indeterminate spinner with theme overrides and optional animation.
- `linear_progress_indicator`: Determinate/indeterminate progress bar with optional spark effects and theming.
- `number_ticker`: Animated number display with formatter or custom builder.
- `spinner`: Base spinner helpers for resolving color and size with theming.
- `progress`: Normalized linear progress bar with theme overrides.
- `skeleton`: Skeletonizer helpers with theme-aware config and extensions.
- `code_snippet`: Stylized code container with action slot and theme overrides.
- `carousel`: Interactive carousel with sliding/fading transitions and autoplay controls.
- `calendar`: Date picker and calendar widgets for single, range, and multi selection.
- `keyboard_shortcut`: Displays keyboard shortcuts as styled keycaps.
- `text`: Typography helpers and fluent text modifiers.
- `selectable`: Selectable text with themed cursor and selection behavior.
- `triple_dots`: Configurable row/column of dots for menu or loading indicators.
- `icon`: Theme-driven icon size/color helpers and WrappedIcon.
- `tracker`: Horizontal tracker segments with tooltips.
- `tree`: Hierarchical tree view with expandable, selectable nodes.
- `feature_carousel`: Animated feature card carousel with autoplay, swipe, and CTA support. (WIP)
- `empty_state`: Standardized empty state block for empty, no-results, or error.
- `border_loading`: Animated border loader wrapper (sweep/linear/radial gradients + tracer mode + circle/custom shapes).
- `text_animate`: Stream-aware animated text renderer for incremental updates.

### form
- `autocomplete`: Autocomplete overlay for text inputs with keyboard navigation and theming.
- `history`: Grid + storage helpers that track recently used colors for reuse.
- `color_picker`: HSV/HSL/HEX color picker with popovers, eye dropper, and history controls.
- `color_input`: Popover/dialog color selector that integrates the picker, history, and eye-dropper tools.
- `hsl`: Gradient slider that controls hue, saturation, lightness, or alpha for HSL colors.
- `hsv`: Gradient slider for HSV color component control (hue, saturation, value, alpha).
- `chip_input`: Inline text input that converts typed tokens into chip widgets with removable buttons and autocomplete hooks.
- `select`: Dropdown/select control with popup menus, grouped items, and keyboard navigation.
- `checkbox`: Animated checkbox with tri-state support and controllers.
- `control`: Controller mixins and helpers for form components.
- `date_picker`: Popover/dialog calendar for single-date and range selection.
- `file_input`: Utilities for mapping file extensions to icon widgets.
- `file_picker`: UI-only drag-drop, tile, and mobile file picker surfaces with upload list management.
- `text_field`: Text input with rich features, autocomplete, and actions.
- `input`: Single-line text input with feature hooks, popovers, and controller integration.
- `input_otp`: Fixed-length OTP input field with clipboard integration, paste handling, and focus management.
- `form_field`: Modal or popover editor field for complex objects.
- `formatted_input`: Low-level formatted-field helpers that sync multiple InputPart segments.
- `form`: Composable form state, validation, and submit helpers.
- `object_input`: Date, time, and duration inputs powered by formatted editors and pickers.
- `phone_input`: International phone number input with country selector and formatting helpers.
- `radio_group`: Exclusive selection group with radio items and cards.
- `slider`: Single-value and range sliders with keyboard navigation.
- `multiple_choice`: Choice widgets with single or multiple selection and form integration.
- `item_picker`: Grid/list picker with selection chips, search, and in-place actions.
- `formatter`: Reusable text input formatters (uppercase/lowercase, numeric, math, HEX, etc.) and helpers for selection clipping.
- `switch`: Toggle control for boolean values with themed styling.
- `text_area`: Resizable multi-line text input built on text field primitives.
- `time_picker`: Popover/dialog picker for time and duration values.
- `validated`: Validation wrapper that exposes form error state.
- `star_rating`: Interactive star rating input with theming support.
- `dropzone`: Dropzone surface for file uploads.

### layout
- `card`: Card container with optional surface blur variant.
- `card_image`: Interactive card that pairs an image with title/subtitle content.
- `alert`: Flexible alert panels with destructive/resilient styling.
- `collapsible`: Independent sections that toggle their own visibility
- `group`: Absolute-position layout surface with explicit offsets and sizes.
- `hidden`: Animated visibility helper with axis-aware size control.
- `accordion`: Single-expansion accordion with configurable triggers and theming.
- `basic`: Flexible row layout for leading/title/content/trailing sections.
- `fade_scroll`: Edge fade overlays for scrollable content.
- `outlined_container`: Animated outlined container with theme-aware borders and blur.
- `scrollable_client`: Two-dimensional scroll surface with builder callbacks for viewport-aware layouts.
- `media_query`: Responsive helper that shows primary or alternate content based on width constraints.
- `sortable`: Drag-and-drop sorting primitives with drop zones and scrolling.
- `table`: Resizable table layout with headers, footers, and frozen cells.
- `overflow_marquee`: Smooth marquee for overflowing content with fade edges and looped timing controls.
- `steps`: Vertical step list with numbered indicators and connectors.
- `resizable`: Resizable panels with draggable dividers.
- `timeline`: Vertical timeline for chronological entries.
- `scaffold`: Layout scaffold with headers, footers, and loading indicators.
- `stage_container`: Responsive container that snaps to breakpoint widths.
- `window`: Desktop-style window system with drag, resize, and snapping.
- `flex`: Flex component for the registry.
- `scrollable`: Two-dimensional scrollable client and faded viewport utilities.
- `filter_bar`: Controlled filter toolbar for list/table pages with search, sort, chips, date range, and clear-all.
- `app`: App wrapper with shadcn theme and overlay handling.

### navigation
- `breadcrumb`: Horizontal breadcrumb trail with arrow/slash separators and overflow handling.
- `navigation_bar`: Themed navigation bar supporting destinations, overflow, and responsive layout.
- `navigation_menu`: Dropdown-style navigation menu with popovers, groups, and keyboard navigation.
- `pagination`: Page navigation controls with skip, previous/next, and ellipsis handling.
- `tabs`: Tabbed navigation primitives with lists and panes.
- `tab_container`: Coordinated tab state manager with customizable builders.
- `tab_list`: Horizontal tab header row with active indicator.
- `tab_pane`: Sortable tab strip with integrated content card.
- `switcher`: Swipeable viewport that animates between children along an axis.
- `stepper`: Multi-step progress with interactive step indicators.
- `subfocus`: Hierarchical focus scope for keyboard navigation.

### overlay
- `eye_dropper`: Layer that lets users sample colors from the screen with preview adornments.
- `alert_dialog`: Modal alert dialog with customizable header, content, and actions.
- `dialog`: Modal dialog primitives with alert dialog and overlay handlers.
- `popover`: Anchored overlay surfaces for floating content.
- `overlay`: Shared overlay handler/manager utilities and helpers.
- `popup`: Styled popup container for menus and dropdowns.
- `tooltip`: Hover-triggered tooltip overlays with themed containers.
- `refresh_trigger`: Pull-to-refresh wrapper with customizable indicator, extents, and completion animations.
- `hover_card`: Hover or long-press triggered popovers for rich previews.
- `toast`: Overlay toast notifications with configurable timing.
- `drawer`: Sliding drawer and sheet overlays with drag support.
- `menu`: Menu primitives, items, and popup container.
- `menubar`: Horizontal desktop-style menubar with dropdown menus and keyboard navigation.
- `context_menu`: Desktop-style context menu overlay for editable text and custom actions.
- `dropdown_menu`: Dropdown menu overlay built on menu primitives.
- `swiper`: Swipe-triggered overlays for drawers and sheets.

### utility
- `alpha`: Checkerboard painter for transparency indicators.
- `async`: Utility for widgets that work with both synchronous and asynchronous values.
- `focus_outline`: Keyboard focus visualization outline with theming support.
- `color`: Helper utilities for converting and transforming colors across RGB/HSV/HSL spaces.
- `image`: Placeholder entry preserving legacy image collection support.
- `locale_utils`: Date/time/duration unit helpers and file size formatting locales.
- `debug`: Debug overlays and container helpers for layout inspection.
- `shadcn_localizations`: Full localization delegate and base translations.
- `shadcn_localizations_en`: English translation bundle for ShadcnLocalizations.
- `shadcn_localizations_extensions`: Formatting helpers for localized dates, times, durations, and picker labels.
- `wrapper`: Conditional wrapper for preserving widget structure.
- `timeline_animation`: Keyframe-based animation timeline utilities.
- `repeated_animation_builder`: Looping animation builder with interpolated values.
- `error_system`: Production-ready error handling system with UI components and repository mapping.

## Common Replacements
- Screen shell: use `layout/scaffold` (`Scaffold`, `AppBar`) instead of Material `Scaffold`/`AppBar`.
- Action controls: use `control/button` (`PrimaryButton`, `SecondaryButton`, `GhostButton`).
- Selection/input: use `form/select`, `form/text_field`, `form/checkbox`, `form/date_picker` etc.
- Overlays: use `overlay/drawer` (`openSheet`, `openDrawer`) and `overlay/dialog`, `overlay/popover`, `overlay/menu`.

## Authoring Rule
- New components should first check this file and `components.json` for existing patched widgets before adding Material dependencies.
