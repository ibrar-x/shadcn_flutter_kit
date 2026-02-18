part of '../../gooey_toast.dart';

class GooeyToastController extends ChangeNotifier {
  /// Uses the provided `toastController` or creates a local one.
  ///
  /// The internal default uses `6000ms` toast duration and `250ms` stack
  /// animation. Controller notifies listeners whenever tracked active ids
  /// change in this wrapper map.
  GooeyToastController({ToastController? toastController})
    : _toastController =
          toastController ??
          ToastController(
            defaultDuration: _kDefaultDuration,
            animationDuration: const Duration(milliseconds: 250),
          );

  final ToastController _toastController;
  final Map<String, GooeyToastDetails> _activeById = {};

  /// Snapshot of tracked active toasts sorted newest-first.
  ///
  /// Returns an unmodifiable list. Updates are emitted when `show`, `dismiss`,
  /// or `onDismissed` mutates the internal id map.
  List<GooeyToastDetails> get activeToasts {
    final items = _activeById.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return List<GooeyToastDetails>.unmodifiable(items);
  }

  /// Returns `true` when a toast with `id` currently exists in stack state.
  ///
  /// This queries the underlying `ToastController`. Empty or unknown ids return
  /// `false`.
  bool containsToast(String id) => _toastController.containsToast(id);

  /// Dismisses the toast with `id` and removes controller metadata.
  ///
  /// No-op when `id` is missing. Notifies listeners only if a tracked item was
  /// removed from `_activeById`.
  void dismiss(String id) {
    _toastController.dismissById(id);
    final removed = _activeById.remove(id);
    if (removed != null) {
      notifyListeners();
    }
  }

  /// Runs a sequenced in-place transition for a stable toast `id`.
  ///
  /// Sequence: close current state -> wait for `closed` phase (or fallback) ->
  /// show next compact -> optionally show next expanded content.
  /// This avoids remove/add flicker when state changes rapidly.
  Future<void> transitionAfterClosed({
    /// Build context used to show updated toast states.
    required BuildContext context,

    /// Stable toast id that is updated across all transition steps.
    required String id,

    /// Current compact title used while forcing close.
    required String currentTitle,

    /// Current semantic state used while forcing close.
    required GooeyToastState currentState,

    /// Optional current leading icon while forcing close.
    Widget? currentIcon,

    /// Optional current compact widget while forcing close.
    Widget? currentCompactChild,

    /// Optional duration for the intermediate closing state.
    Duration? currentDuration,

    /// Title used for next state after close completes.
    required String nextTitle,

    /// Semantic state used for next state after close completes.
    required GooeyToastState nextState,

    /// Optional state discriminator for next compact/expanded updates.
    Object? nextStateTag,

    /// Optional next expanded description text.
    String? nextDescription,

    /// Optional next leading icon.
    Widget? nextIcon,

    /// Optional next compact widget.
    Widget? nextCompactChild,

    /// Optional next expanded widget.
    Widget? nextExpandedChild,

    /// Optional next toast duration.
    Duration? nextDuration,

    /// Safety timeout when `closed` callback is not emitted.
    ///
    /// Defaults to `420ms`. `Duration.zero` advances immediately.
    Duration closeFallback = const Duration(milliseconds: 420),

    /// Delay between compact next-state render and expanded next-state render.
    ///
    /// Defaults to `120ms`. `Duration.zero` expands immediately.
    Duration nextCompactGap = const Duration(milliseconds: 120),

    /// Autopilot used for the final expanded next state.
    GooeyAutopilot nextExpandedAutopilot = const GooeyAutopilot(
      expandDelay: Duration.zero,
      collapseDelay: Duration(milliseconds: 2200),
    ),

    /// Placement preset for all steps in the sequence.
    ///
    /// `left/right/center` anchor on top or bottom edge depending on
    /// [expandDirection]. `centerLeft/centerRight` anchor on vertical center.
    GooeyToastPosition position = GooeyToastPosition.left,

    /// Vertical grow direction for all steps in the sequence.
    GooeyToastExpandDirection expandDirection =
        GooeyToastExpandDirection.bottom,

    /// Width override in logical px for all steps.
    double? width,

    /// Fill override for all steps.
    Color? fill,

    /// Roundness override in logical px for all steps.
    double? roundness,

    /// Animation style override for all steps.
    GooeyToastAnimationStyle? animationStyle,

    /// Shape style override for all steps.
    GooeyToastShapeStyle? shapeStyle,

    /// Gooey blur pass override for all steps.
    bool? enableGooeyBlur,

    /// Hover-pause override for all steps.
    bool? pauseOnHover,

    /// Swipe-to-dismiss override for all steps.
    bool? swipeToDismiss,

    /// Dismiss direction override for all steps.
    Set<ToastSwipeDirection>? dismissDirections,

    /// Swipe threshold override in logical px for all steps.
    double? dismissDragThreshold,

    /// Stack spacing override in logical px for all steps.
    double? spacing,

    /// Overlap-stack override for all steps.
    bool? overlapStackWhenMultiple,

    /// Overlap offset override in logical px for all steps.
    double? overlapStackOffset,

    /// Multi-toast pause override for all steps.
    bool? pauseAutoDismissWhenMultiple,

    /// Stack animation duration override for all steps.
    Duration? stackAnimationDuration,

    /// Stack animation curve override for all steps.
    Curve? stackAnimationCurve,

    /// Max visible stack override for all steps.
    int? maxVisibleCount,

    /// Whole-stack dismiss override for all steps.
    bool? dismissWholeStackWhenMultiple,

    /// Keeps next state alive until manual dismiss when `true`.
    bool persistUntilDismissed = false,

    /// Receives normalized `0..1` expansion progress for the next state.
    ValueChanged<double>? onNextExpansionProgressChanged,

    /// Compact morph config reused by each transition step.
    GooeyCompactMorph compactMorph = const GooeyCompactMorph(),
  }) async {
    final closeCompleter = Completer<void>();
    var resolved = false;
    void resolveClosed() {
      if (resolved) return;
      resolved = true;
      closeCompleter.complete();
    }

    show(
      context: context,
      id: id,
      stateTag: '${nextStateTag ?? nextTitle}:close-current',
      title: currentTitle,
      state: currentState,
      icon: currentIcon,
      compactChild: currentCompactChild,
      expandedChild: null,
      duration: currentDuration ?? nextDuration,
      autopilot: null,
      position: position,
      expandDirection: expandDirection,
      width: width,
      fill: fill,
      roundness: roundness,
      animationStyle: animationStyle,
      shapeStyle: shapeStyle,
      enableGooeyBlur: enableGooeyBlur,
      pauseOnHover: pauseOnHover,
      swipeToDismiss: swipeToDismiss,
      dismissDirections: dismissDirections,
      dismissDragThreshold: dismissDragThreshold,
      spacing: spacing,
      overlapStackWhenMultiple: overlapStackWhenMultiple,
      overlapStackOffset: overlapStackOffset,
      pauseAutoDismissWhenMultiple: pauseAutoDismissWhenMultiple,
      stackAnimationDuration: stackAnimationDuration,
      stackAnimationCurve: stackAnimationCurve,
      maxVisibleCount: maxVisibleCount,
      dismissWholeStackWhenMultiple: dismissWholeStackWhenMultiple,
      persistUntilDismissed: persistUntilDismissed,
      onExpansionPhaseChanged: (phase) {
        if (phase == GooeyToastExpansionPhase.closed) {
          resolveClosed();
        }
      },
      compactMorph: compactMorph,
    );

    Timer(closeFallback, resolveClosed);
    await closeCompleter.future;
    if (!context.mounted) return;

    show(
      context: context,
      id: id,
      stateTag: '${nextStateTag ?? nextTitle}:compact',
      title: nextTitle,
      state: nextState,
      icon: nextIcon,
      compactChild: nextCompactChild,
      expandedChild: null,
      duration: nextDuration,
      autopilot: null,
      position: position,
      expandDirection: expandDirection,
      width: width,
      fill: fill,
      roundness: roundness,
      animationStyle: animationStyle,
      shapeStyle: shapeStyle,
      enableGooeyBlur: enableGooeyBlur,
      pauseOnHover: pauseOnHover,
      swipeToDismiss: swipeToDismiss,
      dismissDirections: dismissDirections,
      dismissDragThreshold: dismissDragThreshold,
      spacing: spacing,
      overlapStackWhenMultiple: overlapStackWhenMultiple,
      overlapStackOffset: overlapStackOffset,
      pauseAutoDismissWhenMultiple: pauseAutoDismissWhenMultiple,
      stackAnimationDuration: stackAnimationDuration,
      stackAnimationCurve: stackAnimationCurve,
      maxVisibleCount: maxVisibleCount,
      dismissWholeStackWhenMultiple: dismissWholeStackWhenMultiple,
      persistUntilDismissed: persistUntilDismissed,
      onExpansionProgressChanged: onNextExpansionProgressChanged,
      compactMorph: compactMorph,
    );

    if (nextDescription == null && nextExpandedChild == null) return;
    await Future<void>.delayed(nextCompactGap);
    if (!context.mounted) return;

    show(
      context: context,
      id: id,
      stateTag: '${nextStateTag ?? nextTitle}:expanded',
      title: nextTitle,
      state: nextState,
      description: nextDescription,
      icon: nextIcon,
      compactChild: nextCompactChild,
      expandedChild: nextExpandedChild,
      duration: nextDuration,
      autopilot: nextExpandedAutopilot,
      position: position,
      expandDirection: expandDirection,
      width: width,
      fill: fill,
      roundness: roundness,
      animationStyle: animationStyle,
      shapeStyle: shapeStyle,
      enableGooeyBlur: enableGooeyBlur,
      pauseOnHover: pauseOnHover,
      swipeToDismiss: swipeToDismiss,
      dismissDirections: dismissDirections,
      dismissDragThreshold: dismissDragThreshold,
      spacing: spacing,
      overlapStackWhenMultiple: overlapStackWhenMultiple,
      overlapStackOffset: overlapStackOffset,
      pauseAutoDismissWhenMultiple: pauseAutoDismissWhenMultiple,
      stackAnimationDuration: stackAnimationDuration,
      stackAnimationCurve: stackAnimationCurve,
      maxVisibleCount: maxVisibleCount,
      dismissWholeStackWhenMultiple: dismissWholeStackWhenMultiple,
      persistUntilDismissed: persistUntilDismissed,
      onExpansionProgressChanged: onNextExpansionProgressChanged,
      compactMorph: compactMorph,
    );
  }

  /// Shows or updates a gooey toast in-place.
  ///
  /// If `id` matches an existing toast in the underlying controller, the same
  /// entry is updated instead of remove/add replacement. Fallback order for
  /// nullable visual overrides is: call override -> `GooeyToastTheme` -> hard defaults.
  void show({
    /// Build context used to resolve theme/media and insert overlay entry.
    required BuildContext context,

    /// Stable id for dedupe/in-place updates; `null` creates an unmanaged toast.
    String? id,

    /// Optional state discriminator for compact morph transitions.
    Object? stateTag,

    /// Compact title text.
    required String title,

    /// Expanded description text; ignored when `expandedChild` is supplied.
    String? description,

    /// Semantic state controlling default tone/icon.
    GooeyToastState state = GooeyToastState.success,

    /// Placement preset.
    ///
    /// `left/right/center` anchor on top or bottom edge depending on
    /// [expandDirection]. `centerLeft/centerRight` anchor on vertical center.
    GooeyToastPosition position = GooeyToastPosition.left,

    /// Vertical grow direction when expanded.
    GooeyToastExpandDirection expandDirection =
        GooeyToastExpandDirection.bottom,

    /// Toast lifetime before auto-dismiss when `persistUntilDismissed` is false.
    Duration? duration,

    /// Optional leading icon for default compact row.
    Widget? icon,

    /// Optional custom compact content replacing default icon+title row.
    Widget? compactChild,

    /// Optional custom expanded content replacing description/action block.
    Widget? expandedChild,

    /// Width override in logical px.
    double? width,

    /// Surface fill override.
    Color? fill,

    /// Roundness override in logical px.
    double? roundness,

    /// Autopilot expansion/collapse scheduling override.
    GooeyAutopilot? autopilot = const GooeyAutopilot(),

    /// Morph animation profile for body expansion/contraction.
    GooeyToastAnimationStyle? animationStyle,

    /// Shape variant for roundness transformation.
    GooeyToastShapeStyle? shapeStyle,

    /// Enables/disables gooey blur compositing behind the crisp shape.
    ///
    /// `null` falls back to [GooeyToastTheme.enableGooeyBlur] then `true`.
    bool? enableGooeyBlur,

    /// Pauses toast timers while pointer hovers toast.
    bool? pauseOnHover,

    /// Enables swipe gestures when `true`.
    bool? swipeToDismiss,

    /// Allowed swipe directions; defaults derived from position/direction.
    Set<ToastSwipeDirection>? dismissDirections,

    /// Swipe dismiss drag threshold in logical px.
    double? dismissDragThreshold,

    /// Vertical stack spacing in logical px.
    double? spacing,

    /// Overlap-stacking toggle in underlying stack.
    bool? overlapStackWhenMultiple,

    /// Overlap offset in logical px per stacked toast.
    double? overlapStackOffset,

    /// Pauses auto-dismiss when multiple toasts are visible.
    bool? pauseAutoDismissWhenMultiple,

    /// Duration for stack reflow animation.
    Duration? stackAnimationDuration,

    /// Curve for stack reflow animation.
    Curve? stackAnimationCurve,

    /// Max number of stack entries rendered by underlying stack.
    int? maxVisibleCount,

    /// Dismisses whole stack when swipe dismiss occurs in multi mode.
    bool? dismissWholeStackWhenMultiple,

    /// Optional default expanded action chip config.
    GooeyToastAction? action,

    /// Keeps toast visible until manual dismiss when `true`.
    bool persistUntilDismissed = false,

    /// Emits expansion phase changes (`closed/opening/open/closing`).
    ValueChanged<GooeyToastExpansionPhase>? onExpansionPhaseChanged,

    /// Emits normalized expansion progress (`0..1`) on animation ticks.
    ValueChanged<double>? onExpansionProgressChanged,

    /// Compact title/icon morph config for in-place state transitions.
    GooeyCompactMorph compactMorph = const GooeyCompactMorph(),
  }) {
    final gooeyTheme = shad.ComponentTheme.maybeOf<GooeyToastTheme>(context);
    final resolvedDuration = duration ?? _kDefaultDuration;
    final resolvedAutopilot = autopilot;
    final resolvedWidth = width ?? gooeyTheme?.width ?? _kToastWidth;
    final resolvedFill = fill ?? gooeyTheme?.fill ?? const Color(0xFF0D1117);
    final resolvedRoundness =
        roundness ?? gooeyTheme?.roundness ?? _kDefaultRoundness;
    final resolvedAnimationStyle =
        animationStyle ??
        gooeyTheme?.animationStyle ??
        GooeyToastAnimationStyle.sileo;
    final resolvedShapeStyle =
        shapeStyle ??
        gooeyTheme?.shapeStyle ??
        GooeyToastShapeStyle.defaultShape;
    final resolvedEnableGooeyBlur =
        enableGooeyBlur ?? gooeyTheme?.enableGooeyBlur ?? true;
    final resolvedPauseOnHover =
        pauseOnHover ?? gooeyTheme?.pauseOnHover ?? true;
    final resolvedSwipeToDismiss =
        swipeToDismiss ?? gooeyTheme?.swipeToDismiss ?? true;
    final resolvedDismissDirections =
        dismissDirections ??
        gooeyTheme?.dismissDirections ??
        (resolvedSwipeToDismiss
            ? _defaultDismissDirections(
                position: position,
                expandDirection: expandDirection,
              )
            : const <ToastSwipeDirection>{});
    final resolvedDismissDragThreshold =
        dismissDragThreshold ?? gooeyTheme?.dismissDragThreshold ?? 72.0;
    final resolvedSpacing = spacing ?? gooeyTheme?.spacing ?? 0.0;
    final resolvedOverlapStackWhenMultiple =
        overlapStackWhenMultiple ??
        gooeyTheme?.overlapStackWhenMultiple ??
        true;
    final resolvedOverlapStackOffset =
        overlapStackOffset ?? gooeyTheme?.overlapStackOffset ?? 8.0;
    final resolvedPauseAutoDismissWhenMultiple =
        pauseAutoDismissWhenMultiple ??
        gooeyTheme?.pauseAutoDismissWhenMultiple ??
        false;
    final resolvedStackAnimationDuration =
        stackAnimationDuration ??
        gooeyTheme?.stackAnimationDuration ??
        const Duration(milliseconds: 340);
    final resolvedStackAnimationCurve =
        stackAnimationCurve ??
        gooeyTheme?.stackAnimationCurve ??
        Curves.easeInOutCubic;
    final resolvedMaxVisibleCount =
        maxVisibleCount ?? gooeyTheme?.maxVisibleCount ?? 4;
    final resolvedDismissWholeStackWhenMultiple =
        dismissWholeStackWhenMultiple ??
        gooeyTheme?.dismissWholeStackWhenMultiple ??
        true;
    const edgeInset = 16.0;
    final media = MediaQuery.maybeOf(context);
    final screenWidth = media?.size.width ?? resolvedWidth;
    final screenHeight =
        media?.size.height ?? (_kToastHeight * _kMinExpandRatio);
    final leftCenter = ((screenWidth - resolvedWidth) / 2).clamp(
      edgeInset,
      screenWidth - resolvedWidth - edgeInset,
    );
    final centerTop = ((screenHeight - _kToastHeight) / 2).clamp(
      edgeInset,
      screenHeight - (_kToastHeight * _kMinExpandRatio) - edgeInset,
    );
    final isCenterBandPosition =
        position == GooeyToastPosition.centerLeft ||
        position == GooeyToastPosition.centerRight;
    final resolvedLeft = switch (position) {
      GooeyToastPosition.left => edgeInset,
      GooeyToastPosition.center => leftCenter.toDouble(),
      GooeyToastPosition.right => null,
      GooeyToastPosition.centerLeft => edgeInset,
      GooeyToastPosition.centerRight => null,
    };
    final resolvedRight = switch (position) {
      GooeyToastPosition.left => null,
      GooeyToastPosition.center => null,
      GooeyToastPosition.right => edgeInset,
      GooeyToastPosition.centerLeft => null,
      GooeyToastPosition.centerRight => edgeInset,
    };
    final showTop = expandDirection == GooeyToastExpandDirection.bottom;
    final resolvedTop = isCenterBandPosition
        ? centerTop.toDouble()
        : (showTop ? edgeInset : null);
    final resolvedBottom = isCenterBandPosition
        ? null
        : (showTop ? null : edgeInset);

    _toastController.show(
      context: context,
      duration: resolvedDuration,
      spacing: resolvedSpacing,
      overlapStackWhenMultiple: resolvedOverlapStackWhenMultiple,
      overlapStackOffset: resolvedOverlapStackOffset,
      pauseAutoDismissWhenMultiple: resolvedPauseAutoDismissWhenMultiple,
      stackAnimationDuration: resolvedStackAnimationDuration,
      stackAnimationCurve: resolvedStackAnimationCurve,
      maxVisibleCount: resolvedMaxVisibleCount,
      dismissWholeStackWhenMultiple: resolvedDismissWholeStackWhenMultiple,
      enableStackExpandedMode: false,
      singleToastPerGroup: true,
      toastId: id,
      pauseOnHover: resolvedPauseOnHover,
      autoDismiss: !persistUntilDismissed,
      dismissDirections: resolvedDismissDirections,
      dismissDragThreshold: resolvedDismissDragThreshold,
      onDismissed: id == null
          ? null
          : () {
              final removed = _activeById.remove(id);
              if (removed != null) {
                notifyListeners();
              }
            },
      top: resolvedTop,
      bottom: resolvedBottom,
      left: resolvedLeft,
      right: resolvedRight,
      builder: (_) => GooeyToast(
        title: title,
        stateTag: stateTag,
        description: description,
        state: state,
        position: position,
        expandDirection: expandDirection,
        duration: resolvedDuration,
        icon: icon,
        compactChild: compactChild,
        expandedChild: expandedChild,
        width: resolvedWidth,
        fill: resolvedFill,
        roundness: resolvedRoundness,
        autopilot: resolvedAutopilot,
        animationStyle: resolvedAnimationStyle,
        shapeStyle: resolvedShapeStyle,
        enableGooeyBlur: resolvedEnableGooeyBlur,
        action: action,
        onExpansionPhaseChanged: onExpansionPhaseChanged,
        onExpansionProgressChanged: onExpansionProgressChanged,
        compactMorph: compactMorph,
      ),
    );

    if (id != null) {
      _activeById[id] = GooeyToastDetails(
        id: id,
        stateTag: stateTag,
        title: title,
        description: description,
        state: state,
        position: position,
        expandDirection: expandDirection,
        duration: resolvedDuration,
        persistUntilDismissed: persistUntilDismissed,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  /// Convenience wrapper for `show(... state: success ...)`.
  ///
  /// Other values follow the same fallback rules as `show`.
  void success({
    /// Build context used to show toast.
    required BuildContext context,

    /// Compact title text.
    required String title,

    /// Optional expanded description.
    String? description,

    /// Optional fill override.
    Color? fill,

    /// Optional autopilot override.
    GooeyAutopilot? autopilot,
  }) {
    show(
      context: context,
      title: title,
      description: description,
      state: GooeyToastState.success,
      fill: fill,
      autopilot: autopilot,
    );
  }

  /// Convenience wrapper for `show(... state: error ...)`.
  ///
  /// Other values follow the same fallback rules as `show`.
  void error({
    /// Build context used to show toast.
    required BuildContext context,

    /// Compact title text.
    required String title,

    /// Optional expanded description.
    String? description,

    /// Optional fill override.
    Color? fill,

    /// Optional autopilot override.
    GooeyAutopilot? autopilot,
  }) {
    show(
      context: context,
      title: title,
      description: description,
      state: GooeyToastState.error,
      fill: fill,
      autopilot: autopilot,
    );
  }
}
