part of '../button.dart';

/// A versatile, customizable button widget with comprehensive styling and interaction support.
///
/// [Button] is the foundational interactive widget in the shadcn_flutter design system,
/// providing a consistent and accessible button implementation with extensive customization
/// options. It supports multiple visual variants, sizes, shapes, and interaction patterns
/// while maintaining design system consistency.
///
/// ## Key Features
/// - **Multiple Variants**: Primary, secondary, outline, ghost, link, text, destructive, and more
/// - **Flexible Sizing**: From extra small to extra large with custom scaling
/// - **Shape Options**: Rectangle and circle shapes with customizable borders
/// - **Rich Interactions**: Hover, focus, press, and long press support
/// - **Accessibility**: Full keyboard navigation and screen reader support
/// - **Theming**: Deep integration with the design system theme
/// - **Form Integration**: Works seamlessly with form validation and state management
///
/// ## Visual Variants
/// The button supports various visual styles through named constructors:
/// - [Button.primary]: Prominent primary actions with filled background
/// - [Button.secondary]: Secondary actions with muted background
/// - [Button.outline]: Actions with outline border and transparent background
/// - [Button.ghost]: Subtle actions with minimal visual weight
/// - [Button.link]: Text-only actions that appear as links
/// - [Button.text]: Plain text actions with hover effects
/// - [Button.destructive]: Dangerous actions with destructive styling
/// - [Button.card]: Card-like appearance for container buttons
///
/// ## Layout and Content
/// Buttons can contain text, icons, or a combination of both using [leading] and [trailing]
/// widgets. The [child] widget is automatically aligned and sized according to the button's
/// style and density settings.
///
/// ## Interaction Handling
/// The button provides comprehensive gesture support including tap, long press, secondary
/// clicks, and tertiary clicks. All interactions respect the [enabled] state and provide
/// appropriate visual and haptic feedback.
///
/// Example:
/// ```dart
/// Button.primary(
///   onPressed: () => print('Primary action'),
///   leading: Icon(Icons.add),
///   trailing: Icon(Icons.arrow_forward),
///   child: Text('Create New'),
/// );
/// ```
class Button extends StatefulWidget {
  /// Whether the button is interactive.
  ///
  /// If null, the button is enabled when [onPressed] is not null. When false,
  /// the button appears disabled and doesn't respond to user input or fire callbacks.
  final bool? enabled;

  /// Whether to disable visual state transition animations.
  ///
  /// When true, the button immediately snaps between visual states instead of
  /// smoothly animating. Useful for performance optimization in lists or when
  /// animations would be distracting.
  final bool disableTransition;

  /// Widget displayed to the left of the main child content.
  ///
  /// Commonly used for icons that provide additional context about the button's
  /// action. Automatically spaced from the [child] with appropriate gaps.
  final Widget? leading;

  /// Widget displayed to the right of the main child content.
  ///
  /// Often used for icons indicating direction (arrows) or additional actions.
  /// Automatically spaced from the [child] with appropriate gaps.
  final Widget? trailing;

  /// The primary content displayed in the button.
  ///
  /// Typically contains text, icons, or other widgets that describe the button's
  /// action. Automatically aligned according to [alignment] and styled according
  /// to the button's [style].
  final Widget child;

  /// Callback invoked when the button is pressed.
  ///
  /// The primary interaction callback for the button. When null, the button becomes
  /// disabled unless [enabled] is explicitly set to true. The button automatically
  /// handles loading states, disabled states, and provides haptic feedback.
  final VoidCallback? onPressed;

  /// Focus node for keyboard navigation and focus management.
  ///
  /// If null, a focus node is automatically created. Useful for controlling focus
  /// programmatically or integrating with form focus traversal.
  final FocusNode? focusNode;

  /// Alignment of the child content within the button.
  ///
  /// Controls how the [child] is positioned within the button's bounds. Defaults
  /// to center alignment for most button types. When [leading] or [trailing] are
  /// provided, defaults to start alignment.
  final AlignmentGeometry? alignment;

  /// Visual styling configuration for the button.
  ///
  /// Defines the button's appearance including colors, padding, borders, and text
  /// styles. The [AbstractButtonStyle] provides state-aware styling that responds
  /// to hover, press, focus, and disabled states.
  final AbstractButtonStyle style;

  /// Callback invoked when the button's hover state changes.
  ///
  /// Called with true when the pointer enters the button area and false when it
  /// leaves. Useful for implementing custom hover effects or updating external state.
  final ValueChanged<bool>? onHover;

  /// Callback invoked when the button's focus state changes.
  ///
  /// Called with true when the button gains focus and false when it loses focus.
  /// Useful for accessibility features or coordinating focus with other widgets.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic feedback on press.
  ///
  /// If null, haptic feedback is automatically enabled on mobile platforms.
  /// When true, provides tactile feedback when the button is pressed. When false,
  /// no haptic feedback is provided regardless of platform.
  final bool? enableFeedback;

  /// Callback invoked when a tap down gesture begins.
  ///
  /// Provides the position and details of the initial touch/click. Useful for
  /// implementing custom press animations or tracking interaction start points.
  final GestureTapDownCallback? onTapDown;

  /// Callback invoked when a tap up gesture completes.
  ///
  /// Called after a successful tap gesture, providing the position details.
  /// Note that [onPressed] is typically preferred for button actions.
  final GestureTapUpCallback? onTapUp;

  /// Callback invoked when a tap gesture is canceled.
  ///
  /// Called when a tap gesture starts but is interrupted before completion,
  /// such as when the pointer moves outside the button area.
  final GestureTapCancelCallback? onTapCancel;

  /// Callback invoked when a secondary button (right-click) tap down begins.
  ///
  /// Useful for implementing context menus or alternative actions.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Callback invoked when a secondary button tap up completes.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Callback invoked when a secondary button tap is canceled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Callback invoked when a tertiary button (middle-click) tap down begins.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Callback invoked when a tertiary button tap up completes.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Callback invoked when a tertiary button tap is canceled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Callback invoked when a long press gesture begins.
  ///
  /// Provides the position where the long press started. Useful for implementing
  /// press-and-hold actions or showing additional options.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Callback invoked when a long press gesture completes.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Callback invoked when a long press gesture moves.
  ///
  /// Provides position updates during an active long press. Useful for
  /// implementing drag-from-long-press behaviors.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Callback invoked when a long press gesture ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Callback invoked when a secondary button long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Callback invoked when a tertiary button long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Whether to disable hover visual effects.
  ///
  /// When true, the button doesn't show visual changes on hover, though [onHover]
  /// callbacks are still called. Useful for custom hover implementations.
  final bool disableHoverEffect;

  /// Controller for managing button widget states externally.
  ///
  /// Allows external control over hover, pressed, focused, and other widget states.
  /// Useful for implementing custom state logic or coordinating with other widgets.
  final WidgetStatesController? statesController;

  /// Alignment for the button's margin within its allocated space.
  ///
  /// Controls how the button positions itself within its parent's constraints
  /// when the button is smaller than the available space.
  final AlignmentGeometry? marginAlignment;

  /// Whether to disable the focus outline.
  ///
  /// When true, removes the visual focus indicator that appears when the button
  /// is focused via keyboard navigation. Use carefully as this affects accessibility.
  final bool disableFocusOutline;

  /// Creates a [Button] with custom styling.
  ///
  /// This is the base constructor that allows complete customization of the button's
  /// appearance and behavior through the [style] parameter. For common use cases,
  /// consider using the named constructors like [Button.primary] or [Button.secondary].
  ///
  /// Parameters:
  /// - [statesController] (WidgetStatesController?, optional): External state management.
  /// - [leading] (Widget?, optional): Widget displayed before the main content.
  /// - [trailing] (Widget?, optional): Widget displayed after the main content.
  /// - [child] (Widget, required): Main content of the button.
  /// - [onPressed] (VoidCallback?, optional): Primary action callback.
  /// - [focusNode] (FocusNode?, optional): Focus management node.
  /// - [alignment] (AlignmentGeometry?, optional): Content alignment within button.
  /// - [style] (AbstractButtonStyle, required): Visual styling configuration.
  /// - [enabled] (bool?, optional): Whether button responds to interactions.
  /// - [disableTransition] (bool, default: false): Whether to disable state animations.
  /// - [onFocus] (`ValueChanged<bool>?`, optional): Focus state change callback.
  /// - [onHover] (`ValueChanged<bool>?`, optional): Hover state change callback.
  /// - [disableHoverEffect] (bool, default: false): Whether to disable hover visuals.
  /// - [enableFeedback] (bool?, optional): Whether to provide haptic feedback.
  /// - [marginAlignment] (AlignmentGeometry?, optional): Margin positioning.
  /// - [disableFocusOutline] (bool, default: false): Whether to hide focus outline.
  ///
  /// Example:
  /// ```dart
  /// Button(
  ///   style: ButtonStyle.primary(),
  ///   leading: Icon(Icons.save),
  ///   onPressed: () => saveDocument(),
  ///   child: Text('Save Document'),
  /// );
  /// ```
  const Button({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    required this.style,
    this.enabled,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a primary button with prominent styling for main actions.
  ///
  /// Primary buttons use a filled background with high contrast text, making them
  /// suitable for the most important action on a screen or in a section. They have
  /// the highest visual weight and should be used sparingly.
  ///
  /// The button uses the primary color from the theme and provides clear visual
  /// feedback for hover, focus, and press states.
  ///
  /// Parameters: Same as [Button] constructor, with [style] preset to [ButtonVariance.primary].
  ///
  /// Example:
  /// ```dart
  /// Button.primary(
  ///   onPressed: () => submitForm(),
  ///   child: Text('Submit'),
  /// );
  /// ```
  const Button.primary({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.primary,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a secondary button with muted styling for supporting actions.
  ///
  /// Secondary buttons use a subtle background color with medium contrast text,
  /// making them suitable for actions that are important but not primary. They have
  /// less visual weight than primary buttons and can be used more frequently.
  ///
  /// Example:
  /// ```dart
  /// Button.secondary(
  ///   onPressed: () => cancelAction(),
  ///   child: Text('Cancel'),
  /// );
  /// ```
  const Button.secondary({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.secondary,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates an outline button with a border and transparent background.
  ///
  /// Outline buttons feature a visible border and transparent background, providing
  /// a minimal yet distinct appearance. They're ideal for secondary actions that need
  /// to stand out more than ghost buttons but less than filled buttons. The outline
  /// style works well in layouts where visual hierarchy matters.
  ///
  /// Example:
  /// ```dart
  /// Button.outline(
  ///   onPressed: () => showMore(),
  ///   child: Text('Learn More'),
  /// );
  /// ```
  const Button.outline({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.outline,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a ghost button with minimal styling for subtle actions.
  ///
  /// Ghost buttons have no background by default and only show subtle hover effects.
  /// They're perfect for actions that need to be available but shouldn't draw attention
  /// away from more important content.
  ///
  /// Example:
  /// ```dart
  /// Button.ghost(
  ///   onPressed: () => showHelp(),
  ///   leading: Icon(Icons.help_outline),
  ///   child: Text('Help'),
  /// );
  /// ```
  const Button.ghost({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.ghost,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a link-styled button with underline decoration.
  ///
  /// Link buttons appear as inline text links, typically underlined on hover,
  /// making them suitable for navigation or inline actions within text. They have
  /// minimal visual presence and work well for tertiary actions or embedded links.
  ///
  /// Example:
  /// ```dart
  /// Button.link(
  ///   onPressed: () => openUrl(),
  ///   child: Text('View Documentation'),
  /// );
  /// ```
  const Button.link({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.link,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a text-only button with no background or border.
  ///
  /// Text buttons display only their text content without any background fill or
  /// border decoration. They're the most minimal button style, useful for actions
  /// that should be accessible but not visually prominent, such as "Skip" or "Not now".
  ///
  /// Example:
  /// ```dart
  /// Button.text(
  ///   onPressed: () => skipStep(),
  ///   child: Text('Skip'),
  /// );
  /// ```
  const Button.text({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.text,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a destructive button for actions that delete or destroy data.
  ///
  /// Destructive buttons use red/warning colors to clearly indicate that the action
  /// will remove, delete, or otherwise negatively affect user data. They should be
  /// used sparingly and typically require confirmation dialogs.
  ///
  /// Example:
  /// ```dart
  /// Button.destructive(
  ///   onPressed: () => deleteItem(),
  ///   leading: Icon(Icons.delete),
  ///   child: Text('Delete'),
  /// );
  /// ```
  const Button.destructive({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.destructive,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a fixed-style button with consistent dimensions.
  ///
  /// Fixed buttons maintain specific dimensions regardless of content, making them
  /// ideal for grids, toolbars, or layouts where uniform button sizing is required.
  /// They're commonly used in icon-heavy interfaces or when precise spacing matters.
  ///
  /// Example:
  /// ```dart
  /// Button.fixed(
  ///   onPressed: () => performAction(),
  ///   child: Icon(Icons.add),
  /// );
  /// ```
  const Button.fixed({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.fixed,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  /// Creates a card-style button with elevated appearance.
  ///
  /// Card buttons feature subtle shadows and borders to create a card-like elevated
  /// appearance. They work well in content-heavy layouts where buttons need to stand
  /// out from surrounding content, such as feature cards or call-to-action sections.
  ///
  /// Example:
  /// ```dart
  /// Button.card(
  ///   onPressed: () => selectOption(),
  ///   child: Column(
  ///     children: [
  ///       Icon(Icons.star),
  ///       Text('Premium'),
  ///     ],
  ///   ),
  /// );
  /// ```
  const Button.card({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.card,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  @override
  ButtonState createState() => ButtonState();
}

/// State class for [Button] widgets managing interactive state and rendering.
///
/// [ButtonState] handles the button's lifecycle, manages the [WidgetStatesController]
/// for tracking interactive states (pressed, hovered, focused, disabled), and
/// coordinates with the button's style system to apply appropriate visual changes
/// based on the current state.
///
/// This class is generic, allowing it to manage state for various button types
/// (primary, secondary, outline, etc.) through the type parameter [T].
///
/// The state class automatically:
/// - Creates or uses a provided [WidgetStatesController]
/// - Updates the disabled state based on [onPressed] availability
/// - Manages focus and hover interactions
/// - Applies style transitions and animations
class ButtonState<T extends Button> extends State<T> {
  bool get _shouldEnableFeedback {
    final platform = Theme.of(context).platform;
    return isMobile(platform);
  }

  AbstractButtonStyle? _style;
  ButtonStyleOverrideData? _overrideData;

  @override
  void initState() {
    super.initState();
    _style = widget.style;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var overrideData = Data.maybeOf<ButtonStyleOverrideData>(context);
    if (overrideData != _overrideData) {
      _overrideData = overrideData;
      if (overrideData != null) {
        _style = widget.style.copyWith(
          decoration: overrideData.decoration,
          mouseCursor: overrideData.mouseCursor,
          padding: overrideData.padding,
          textStyle: overrideData.textStyle,
          iconTheme: overrideData.iconTheme,
          margin: overrideData.margin,
        );
      } else {
        _style = widget.style;
      }
    }
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.style != oldWidget.style) {
      var overrideData = _overrideData;
      if (overrideData != null) {
        _style = widget.style.copyWith(
          decoration: overrideData.decoration,
          mouseCursor: overrideData.mouseCursor,
          padding: overrideData.padding,
          textStyle: overrideData.textStyle,
          iconTheme: overrideData.iconTheme,
          margin: overrideData.margin,
        );
      } else {
        _style = widget.style;
      }
    }
  }

  EdgeInsetsGeometry _resolveMargin(Set<WidgetState> states) {
    return _style!.margin(context, states);
  }

  Decoration _resolveDecoration(Set<WidgetState> states) {
    return _style!.decoration(context, states);
  }

  MouseCursor _resolveMouseCursor(Set<WidgetState> states) {
    return _style!.mouseCursor(context, states);
  }

  EdgeInsetsGeometry _resolvePadding(Set<WidgetState> states) {
    return _style!.padding(context, states);
  }

  TextStyle _resolveTextStyle(Set<WidgetState> states) {
    return _style!.textStyle(context, states);
  }

  IconThemeData _resolveIconTheme(Set<WidgetState> states) {
    return _style!.iconTheme(context, states);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    bool enableFeedback = widget.enableFeedback ?? _shouldEnableFeedback;
    return Clickable(
      disableFocusOutline: widget.disableFocusOutline,
      statesController: widget.statesController,
      focusNode: widget.focusNode,
      enabled: widget.enabled ?? widget.onPressed != null,
      marginAlignment: widget.marginAlignment,
      disableTransition: widget.disableTransition,
      onHover: widget.onHover,
      onFocus: widget.onFocus,
      disableHoverEffect: widget.disableHoverEffect,
      enableFeedback: enableFeedback,
      margin: WidgetStateProperty.resolveWith(_resolveMargin),
      decoration: WidgetStateProperty.resolveWith(_resolveDecoration),
      mouseCursor: WidgetStateProperty.resolveWith(_resolveMouseCursor),
      padding: WidgetStateProperty.resolveWith(_resolvePadding),
      textStyle: WidgetStateProperty.resolveWith(_resolveTextStyle),
      iconTheme: WidgetStateProperty.resolveWith(_resolveIconTheme),
      transform: enableFeedback
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                // scale down to 95% with alignment at center
                return Matrix4.identity()..scaleByDouble(0.95, 0.95, 0.95, 1);
              }
              return null;
            })
          : null,
      onPressed: widget.onPressed,
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      onSecondaryTapDown: widget.onSecondaryTapDown,
      onSecondaryTapUp: widget.onSecondaryTapUp,
      onSecondaryTapCancel: widget.onSecondaryTapCancel,
      onTertiaryTapDown: widget.onTertiaryTapDown,
      onTertiaryTapUp: widget.onTertiaryTapUp,
      onTertiaryTapCancel: widget.onTertiaryTapCancel,
      onLongPressStart: widget.onLongPressStart,
      onLongPressUp: widget.onLongPressUp,
      onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
      onLongPressEnd: widget.onLongPressEnd,
      onSecondaryLongPress: widget.onSecondaryLongPress,
      onTertiaryLongPress: widget.onTertiaryLongPress,
      child: widget.leading == null && widget.trailing == null
          ? Align(
              heightFactor: 1,
              widthFactor: 1,
              alignment: widget.alignment ?? Alignment.center,
              child: widget.child,
            )
          : IntrinsicWidth(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.leading != null) widget.leading!,
                    if (widget.leading != null) Gap(8 * scaling),
                    Expanded(
                      child: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        alignment: widget.alignment ??
                            AlignmentDirectional.centerStart,
                        child: widget.child,
                      ),
                    ),
                    if (widget.trailing != null) Gap(8 * scaling),
                    if (widget.trailing != null) widget.trailing!,
                  ],
                ),
              ),
            ),
    );
  }
}

/// Defines the relative size scaling for button components.
///
/// [ButtonSize] controls the overall scale of buttons, affecting text size,
/// icon size, and proportional padding. The scaling factor is applied to
/// all dimensional properties to maintain visual consistency.
///
/// Example:
/// ```dart
/// Button.primary(
///   style: ButtonStyle.primary().copyWith(size: ButtonSize.large),
///   child: Text('Large Button'),
/// );
/// ```
