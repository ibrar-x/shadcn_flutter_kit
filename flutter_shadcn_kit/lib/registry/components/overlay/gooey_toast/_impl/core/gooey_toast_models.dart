part of '../../gooey_toast.dart';

class GooeyAutopilot {
  const GooeyAutopilot({
    /// Delay before compact toast auto-expands after mount/update.
    ///
    /// `null` falls back to `150ms`. `Duration.zero` or negative expands
    /// immediately. Positive values delay expansion by that amount.
    this.expandDelay,

    /// Delay before expanded toast auto-collapses back to compact mode.
    ///
    /// `null` falls back to `4000ms`. `Duration.zero` or negative disables
    /// delayed collapse scheduling. Positive values collapse after that delay.
    this.collapseDelay,
  });

  /// Controls when auto-expansion starts after the toast is shown.
  final Duration? expandDelay;

  /// Controls when auto-collapse starts after expansion.
  final Duration? collapseDelay;
}

enum GooeyToastState { success, loading, error, warning, info, action }

enum GooeyToastPosition { left, center, right }

enum GooeyToastExpandDirection { top, bottom }

enum GooeyToastAnimationStyle { sileo, smooth, snappy, bouncy }

enum GooeyToastShapeStyle { defaultShape, soft, sharp, capsule }

enum GooeyToastExpansionPhase { closed, opening, open, closing }

class GooeyCompactMorph {
  const GooeyCompactMorph({
    /// Duration of compact title/icon morph when `stateTag` or compact values
    /// change without replacing the toast.
    ///
    /// Default is `210ms`. `Duration.zero` snaps instantly.
    this.duration = const Duration(milliseconds: 210),

    /// Curve used for compact morph interpolation from previous to next state.
    ///
    /// Default is `Curves.easeOutCubic`.
    this.curve = Curves.easeOutCubic,

    /// Slide delta applied during compact morph in normalized axis units.
    ///
    /// `Offset.dy` is multiplied by toast height. `Offset.zero` disables slide.
    this.slideOffset = const Offset(0, 0.12),

    /// Starting scale factor for compact icon/title during morph.
    ///
    /// Default `0.95` shrinks before settling to `1.0`. Values `<= 0` are
    /// clamped internally when painting.
    this.scaleFrom = 0.95,
  });

  /// Duration for compact title/icon transition.
  final Duration duration;

  /// Easing curve for compact title/icon transition.
  final Curve curve;

  /// Translation applied while compact content transitions.
  final Offset slideOffset;

  /// Initial compact scale used before morph completes.
  final double scaleFrom;
}

class GooeyToastAction {
  const GooeyToastAction({
    /// Label rendered on the inline expanded action chip.
    required this.label,

    /// Invoked when the expanded action chip is tapped/clicked.
    ///
    /// Fires on user interaction only; not called during programmatic updates.
    required this.onPressed,
  });

  /// Text shown in the expanded action chip.
  final String label;

  /// Callback for expanded action chip interaction.
  final VoidCallback onPressed;
}

class GooeyToastDetails {
  const GooeyToastDetails({
    /// Stable toast id used by controller operations (`dismiss`, `contains`).
    required this.id,

    /// Optional state discriminator for in-place transitions of same id.
    ///
    /// Keep this value changing across states to animate compact content
    /// without removing/re-adding the toast entry.
    required this.stateTag,

    /// Current compact title tracked by controller snapshot.
    required this.title,

    /// Current expanded description tracked by controller snapshot.
    required this.description,

    /// Current semantic state mapped to default tone/icon.
    required this.state,

    /// Horizontal toast anchor used when toast was shown.
    required this.position,

    /// Vertical growth direction used when toast was shown.
    required this.expandDirection,

    /// Duration configured when toast was shown.
    required this.duration,

    /// Whether auto-dismiss was disabled for this toast.
    required this.persistUntilDismissed,

    /// Last update timestamp used for LIFO ordering.
    required this.updatedAt,
  });

  /// Unique toast id within the underlying `ToastController`.
  final String id;

  /// Optional state discriminator for in-place transitions.
  final Object? stateTag;

  /// Last known title for this active toast.
  final String title;

  /// Last known description for this active toast.
  final String? description;

  /// Last known semantic state for this active toast.
  final GooeyToastState state;

  /// Last known horizontal position for this active toast.
  final GooeyToastPosition position;

  /// Last known expansion direction for this active toast.
  final GooeyToastExpandDirection expandDirection;

  /// Last known dismiss duration for this active toast.
  final Duration duration;

  /// Whether this active toast remains until manual dismiss.
  final bool persistUntilDismissed;

  /// Timestamp used for sorting `activeToasts` newest-first.
  final DateTime updatedAt;
}
