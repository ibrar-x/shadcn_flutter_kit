part of '../button.dart';

class PrimaryButton extends StatelessWidget {
  /// The widget displayed as the button's main content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a primary button with the specified properties.
  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.primary(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a secondary button.
///
/// A simplified wrapper around [Button.secondary] with the same properties
/// as [PrimaryButton] but using secondary button styling for supporting actions.
class SecondaryButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a secondary button with the specified properties.
  const SecondaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.secondary(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating an outline button.
///
/// A simplified wrapper around [Button.outline] with the same properties
/// as [PrimaryButton] but using outline button styling with a visible border.
class OutlineButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates an outline button with the specified properties.
  const OutlineButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.outline(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a ghost button.
///
/// A simplified wrapper around [Button.ghost] with the same properties
/// as [PrimaryButton] but using ghost button styling with minimal visual presence.
class GhostButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a ghost button with the specified properties.
  const GhostButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.ghost(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a link button.
///
/// A simplified wrapper around [Button.link] with the same properties
/// as [PrimaryButton] but using link button styling that resembles a hyperlink.
class LinkButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a link button with the specified properties.
  const LinkButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.link(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a text button.
///
/// A simplified wrapper around [Button.text] with the same properties
/// as [PrimaryButton] but using text button styling with minimal styling.
class TextButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a text button with the specified properties.
  const TextButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.text(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      child: child,
    );
  }
}

/// Convenience widget for creating a destructive button.
///
/// A simplified wrapper around [Button.destructive] with the same properties
/// as [PrimaryButton] but using destructive button styling for dangerous actions.
class DestructiveButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a destructive button with the specified properties.
  const DestructiveButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style:
          ButtonStyle.destructive(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Convenience widget for creating a tab button.
///
/// A simplified wrapper around [Button] with the same properties
/// as [PrimaryButton] but using tab button styling for tabbed navigation.
class TabButton extends StatelessWidget {
  /// The widget to display as the button's content.
  final Widget child;

  /// Called when the button is pressed. If `null`, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Overrides the `onPressed` check if provided.
  final bool? enabled;

  /// Widget displayed before the [child].
  final Widget? leading;

  /// Widget displayed after the [child].
  final Widget? trailing;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Size variant of the button (defaults to [ButtonSize.normal]).
  final ButtonSize size;

  /// Density variant affecting spacing (defaults to [ButtonDensity.normal]).
  final ButtonDensity density;

  /// Shape of the button (defaults to [ButtonShape.rectangle]).
  final ButtonShape shape;

  /// Focus node for keyboard focus management.
  final FocusNode? focusNode;

  /// Whether to disable style transition animations (defaults to `false`).
  final bool disableTransition;

  /// Called when hover state changes.
  final ValueChanged<bool>? onHover;

  /// Called when focus state changes.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a tab button with the specified properties.
  const TabButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.fixed(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// A button styled as a card with elevated appearance and extensive gesture support.
///
/// Provides an alternative button presentation that resembles a card with
/// elevated styling, typically used for prominent actions or content sections
/// that need to stand out from the background. The card styling provides
/// visual depth and emphasis compared to standard button variants.
///
/// Supports the full range of button features including leading/trailing widgets,
/// focus management, gesture handling, and accessibility features. The card
/// appearance is defined by [ButtonStyle.card] with customizable size,
/// density, and shape properties.
///
/// The component handles complex gesture interactions including primary,
/// secondary, and tertiary taps, long presses, hover states, and focus
/// management, making it suitable for rich interactive experiences.
///
/// Example:
/// ```dart
/// CardButton(
///   leading: Icon(Icons.dashboard),
///   trailing: Icon(Icons.arrow_forward),
///   size: ButtonSize.large,
///   onPressed: () => Navigator.pushNamed(context, '/dashboard'),
///   child: Column(
///     children: [
///       Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
///       Text('View analytics and reports'),
///     ],
///   ),
/// )
/// ```
class CardButton extends StatelessWidget {
  /// The primary content displayed within the card button.
  ///
  /// Typically contains text, icons, or complex layouts that represent
  /// the button's purpose. The content is styled with card appearance
  /// and elevated visual treatment.
  final Widget child;

  /// Callback invoked when the button is pressed.
  ///
  /// Called when the user taps or clicks the button. If null,
  /// the button is disabled and does not respond to interactions.
  final VoidCallback? onPressed;

  /// Whether this button is enabled and accepts user input.
  ///
  /// When false, the button is displayed in a disabled state and
  /// ignores user interactions. When null, enabled state is determined
  /// by whether [onPressed] is provided.
  final bool? enabled;

  /// Optional widget displayed before the main content.
  ///
  /// Commonly used for icons that visually represent the button's action.
  /// Positioned to the left of the content in LTR layouts.
  final Widget? leading;

  /// Optional widget displayed after the main content.
  ///
  /// Often used for indicators, chevrons, or secondary actions.
  /// Positioned to the right of the content in LTR layouts.
  final Widget? trailing;

  /// Alignment of content within the button.
  ///
  /// Controls how the button's content is positioned within its bounds.
  /// Defaults to center alignment if not specified.
  final AlignmentGeometry? alignment;

  /// Size variant for the button appearance.
  ///
  /// Controls padding, font size, and overall dimensions. Available
  /// sizes include small, normal, large, and extra large variants.
  final ButtonSize size;

  /// Density setting affecting button compactness.
  ///
  /// Controls spacing and padding to create more or less compact
  /// appearance. Useful for dense interfaces or accessibility needs.
  final ButtonDensity density;

  /// Shape configuration for the button's appearance.
  ///
  /// Defines border radius and corner styling. Options include
  /// rectangle, rounded corners, and circular shapes.
  final ButtonShape shape;

  /// Focus node for keyboard navigation and accessibility.
  ///
  /// Manages focus state for the button. If not provided, a focus
  /// node is created automatically by the underlying button system.
  final FocusNode? focusNode;

  /// Whether to disable visual transition animations.
  ///
  /// When true, the button skips animation effects for state changes.
  /// Useful for performance optimization or accessibility preferences.
  final bool disableTransition;

  /// Callback invoked when hover state changes.
  ///
  /// Called with true when the mouse enters the button area,
  /// and false when it exits. Useful for custom hover effects.
  final ValueChanged<bool>? onHover;

  /// Callback invoked when focus state changes.
  ///
  /// Called with true when the button gains focus, and false
  /// when it loses focus. Supports keyboard navigation patterns.
  final ValueChanged<bool>? onFocus;

  /// Whether to enable haptic/audio feedback.
  final bool? enableFeedback;

  /// Called when primary tap down occurs.
  final GestureTapDownCallback? onTapDown;

  /// Called when primary tap up occurs.
  final GestureTapUpCallback? onTapUp;

  /// Called when primary tap is cancelled.
  final GestureTapCancelCallback? onTapCancel;

  /// Called when secondary tap down occurs.
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Called when secondary tap up occurs.
  final GestureTapUpCallback? onSecondaryTapUp;

  /// Called when secondary tap is cancelled.
  final GestureTapCancelCallback? onSecondaryTapCancel;

  /// Called when tertiary tap down occurs.
  final GestureTapDownCallback? onTertiaryTapDown;

  /// Called when tertiary tap up occurs.
  final GestureTapUpCallback? onTertiaryTapUp;

  /// Called when tertiary tap is cancelled.
  final GestureTapCancelCallback? onTertiaryTapCancel;

  /// Called when long press starts.
  final GestureLongPressStartCallback? onLongPressStart;

  /// Called when long press is released.
  final GestureLongPressUpCallback? onLongPressUp;

  /// Called when long press moves.
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  /// Called when long press ends.
  final GestureLongPressEndCallback? onLongPressEnd;

  /// Called when secondary long press completes.
  final GestureLongPressUpCallback? onSecondaryLongPress;

  /// Called when tertiary long press completes.
  final GestureLongPressUpCallback? onTertiaryLongPress;

  /// Creates a [CardButton] with card-styled appearance and comprehensive interaction support.
  ///
  /// The [child] parameter is required and provides the button's main content.
  /// The button uses card styling with elevated appearance for visual prominence.
  /// Extensive gesture support enables complex interactions beyond simple taps.
  ///
  /// Parameters include standard button properties (onPressed, enabled, leading,
  /// trailing) along with size, density, and shape customization options.
  /// Gesture callbacks support primary, secondary, tertiary taps and long presses.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The main content displayed in the button
  /// - [onPressed] (VoidCallback?, optional): Primary action when button is pressed
  /// - [enabled] (bool?, optional): Whether button accepts input (null uses onPressed)
  /// - [size] (ButtonSize, default: normal): Size variant for button dimensions
  /// - [density] (ButtonDensity, default: normal): Spacing density setting
  /// - [shape] (ButtonShape, default: rectangle): Border radius and corner styling
  ///
  /// Example:
  /// ```dart
  /// CardButton(
  ///   size: ButtonSize.large,
  ///   leading: Icon(Icons.star),
  ///   onPressed: () => _handleFavorite(),
  ///   child: Text('Add to Favorites'),
  /// )
  /// ```
  const CardButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
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
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.card(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

/// Icon-only button widget with support for multiple visual styles.
///
/// [IconButton] is optimized for displaying buttons with icon content,
/// using icon-specific density and sizing by default. Supports various
