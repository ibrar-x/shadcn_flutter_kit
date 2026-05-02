# Component Catalog

Use this catalog before creating custom widgets. Install with explicit namespaces, for example `flutter_shadcn add @shadcn/button`.

## Control

- `button`: Button system with variants, toggles, and groups.
- `clickable`: State-aware gesture surface with hover, focus, and press handling.
- `command`: Command palette with search, keyboard navigation, and custom result builders.
- `scrollbar`: Themeable scrollbar wrapper.
- `scrollview`: Middle-click drag scroll interceptor for desktop/web.
- `hover`: Hover timing helpers and state tracking widgets.
- `patch`: Consecutive tap tracking and click count details.

## Display

- `chat`: Chat bubbles, groups, and tails.
- `badge`: Compact labels and status markers.
- `avatar`: Initials/photo avatar with badge and group support.
- `chip`: Compact tag-style button with optional slots.
- `divider`: Horizontal and vertical separators with labels.
- `dot_indicator`: Animated dot indicators.
- `circular_progress_indicator`: Determinate/indeterminate circular progress.
- `linear_progress_indicator`: Determinate/indeterminate linear progress.
- `progress`: Normalized progress bar.
- `spinner`: Base spinner helpers.
- `number_ticker`: Animated numeric display.
- `skeleton`: Skeleton loading helpers.
- `code_snippet`: Code display container with action slot.
- `carousel`: Interactive carousel with transitions and autoplay.
- `feature_carousel`: Animated feature card carousel.
- `calendar`: Single, range, and multi-selection calendar.
- `keyboard_shortcut`: Styled keycap shortcuts.
- `text`: Typography helpers and fluent text modifiers.
- `text_animate`: Stream-aware incremental animated text.
- `selectable`: Selectable text with themed cursor/selection.
- `triple_dots`: Dots for menus/loading.
- `icon`: Theme-driven icon helpers.
- `tracker`: Horizontal tracker segments with tooltips.
- `tree`: Expandable/selectable hierarchical tree.
- `empty_state`: Empty, no-results, or error state block.
- `border_loading`: Animated border loader.

## Form

- `autocomplete`: Text autocomplete overlay.
- `history`: Recently-used color history helpers.
- `color_picker`: HSV/HSL/HEX color picker.
- `color_input`: Popover/dialog color selector.
- `hsl`: HSL gradient slider.
- `hsv`: HSV gradient slider.
- `chip_input`: Tokenizing chip text input.
- `select`: Dropdown/select with groups and keyboard navigation.
- `checkbox`: Animated tri-state checkbox.
- `control`: Controller mixins and helpers.
- `date_picker`: Calendar-backed date picker.
- `file_input`: File extension to icon utilities.
- `file_picker`: Drag-drop, tile, and mobile file picker UI.
- `dropzone`: Dropzone surface for file uploads.
- `text_field`: Text input with autocomplete and actions.
- `text_area`: Resizable multi-line text input.
- `input`: Single-line text input with feature hooks.
- `input_otp`: Fixed-length OTP input.
- `form_field`: Modal or popover editor field.
- `formatted_input`: Multi-part formatted input helpers.
- `form`: Form state, validation, and submit helpers.
- `object_input`: Date, time, and duration object inputs.
- `phone_input`: International phone input.
- `radio_group`: Radio items and cards.
- `slider`: Single and range sliders.
- `multiple_choice`: Single/multiple choice widgets.
- `item_picker`: Grid/list picker with chips and search.
- `formatter`: Reusable text input formatters.
- `switch`: Boolean toggle control.
- `time_picker`: Time and duration picker.
- `validated`: Validation wrapper exposing error state.
- `star_rating`: Interactive rating input.

## Layout

- `app`: App wrapper with shadcn theme and overlay handling.
- `scaffold`: Page scaffold with headers, footers, loading indicators.
- `card`: Card container and surface blur variant.
- `card_image`: Image card with title/subtitle.
- `alert`: Alert panels.
- `collapsible`: Independent collapsible sections.
- `accordion`: Single-expansion accordion.
- `group`: Absolute-position layout surface.
- `hidden`: Animated visibility helper.
- `basic`: Leading/title/content/trailing row layout.
- `fade_scroll`: Edge fade overlays for scrollables.
- `outlined_container`: Animated outlined surface.
- `scrollable_client`: Two-dimensional viewport-aware scroll surface.
- `scrollable`: Two-dimensional scrollable and faded viewport utilities.
- `media_query`: Responsive content switcher.
- `sortable`: Drag/drop sorting primitives.
- `table`: Resizable table with frozen cells.
- `overflow_marquee`: Smooth marquee for overflowing content.
- `steps`: Vertical step list.
- `resizable`: Resizable panels.
- `timeline`: Chronological timeline.
- `stage_container`: Breakpoint-snapping responsive container.
- `window`: Desktop-style window system.
- `flex`: Registry flex component.
- `filter_bar`: Search/sort/chip/date filter toolbar.

## Navigation

- `breadcrumb`: Breadcrumb trail.
- `navigation_bar`: Destination navigation bar.
- `navigation_menu`: Dropdown-style navigation menu.
- `pagination`: Page navigation controls.
- `tabs`: Tab primitives.
- `tab_container`: Coordinated tab state.
- `tab_list`: Horizontal tab header row.
- `tab_pane`: Sortable tab strip and content card.
- `switcher`: Swipeable animated viewport.
- `stepper`: Multi-step progress.
- `subfocus`: Hierarchical keyboard focus scope.

## Overlay

- `overlay`: Shared overlay manager utilities.
- `dialog`: Modal dialog primitives.
- `alert_dialog`: Modal alert dialog.
- `drawer`: Drawer and sheet overlays.
- `popover`: Anchored floating surfaces.
- `popup`: Styled popup container.
- `tooltip`: Hover tooltip overlays.
- `refresh_trigger`: Pull-to-refresh wrapper.
- `hover_card`: Rich hover/long-press previews.
- `toast`: Transient toast notifications.
- `menu`: Menu primitives and items.
- `menubar`: Desktop menubar.
- `context_menu`: Desktop context menu.
- `dropdown_menu`: Dropdown menu overlay.
- `swiper`: Swipe-triggered drawer/sheet overlays.
- `eye_dropper`: Color sampling layer.

## Utility

- `alpha`: Transparency checkerboard painter.
- `async`: Widgets for sync/async values.
- `focus_outline`: Keyboard focus outline.
- `color`: RGB/HSV/HSL color utilities.
- `image`: Legacy image collection placeholder.
- `locale_utils`: Date/time/duration and file-size locale helpers.
- `debug`: Debug overlays and layout inspection.
- `shadcn_localizations`: Localization delegate and translations.
- `shadcn_localizations_en`: English translations.
- `shadcn_localizations_extensions`: Localized formatting helpers.
- `wrapper`: Conditional wrapper.
- `timeline_animation`: Keyframe animation utilities.
- `repeated_animation_builder`: Looping animation builder.
- `error_system`: Error handling UI and repository mapping.

## Shared Primitives

Important shared dependencies include `theme`, `typography`, `color_extensions`, `clickable`, `form_control`, `form_value_supplier`, `style_value`, `border_utils`, `constants`, `animation_queue`, `wrap_utils`, `animated_value_builder`, `slider_value`, `util`, `controlled_animation`, `text_input_utils`, `chip_utils`, `geometry_extensions`, `hidden`, `overlay`, `hover`, `subfocus`, `basic_layout`, `text_modifiers`, `icon_extensions`, `localizations`, `fade_scroll`, `keyboard_shortcut_utils`, `resizer`, `lucide_icons`, `radix_icons`, `outlined_container`, `sheet_overlay`, `focus_outline`, `axis`, `phone_number`, `axis_insets`, `bootstrap_icons`, `chart_color_scheme`, `color_scheme`, `color_schemes`, `color_shades`, `design_tokens`, `generated_colors`, `platform_utils`, `preset_themes`, `tween_utils`, `widget_extensions`, and `density`.
