part of '../../gooey_toast.dart';

class GooeyToast extends StatefulWidget {
  const GooeyToast({
    super.key,

    /// Compact title text shown in the header pill.
    required this.title,

    /// Optional discriminator for in-place compact morph updates.
    ///
    /// Change this when reusing the same toast id so compact text/icon morphs
    /// instead of appearing static.
    this.stateTag,

    /// Expanded body description text.
    ///
    /// Ignored when `expandedChild` is provided.
    this.description,

    /// Semantic state used for default icon/tone.
    this.state = GooeyToastState.success,

    /// Compact header alignment preset.
    ///
    /// `centerLeft` maps to left alignment and `centerRight` maps to right
    /// alignment inside the toast canvas.
    this.position = GooeyToastPosition.left,

    /// Direction that expanded body grows from compact header.
    this.expandDirection = GooeyToastExpandDirection.bottom,

    /// Auto-dismiss duration passed to outer stack/controller.
    this.duration = _kDefaultDuration,

    /// Optional leading icon for default compact row.
    this.icon,

    /// Optional custom compact row replacing icon/title defaults.
    this.compactChild,

    /// Optional custom expanded content replacing description/action block.
    this.expandedChild,

    /// Total toast width in logical px.
    ///
    /// Values `<= 0` are replaced by themed/default width.
    this.width = _kToastWidth,

    /// Surface fill color override for both compact and expanded layers.
    this.fill,

    /// Base corner radius in logical px before shape-style transform.
    this.roundness = _kDefaultRoundness,

    /// Optional auto expand/collapse scheduling policy.
    ///
    /// `null` disables autopilot.
    this.autopilot,

    /// Expansion animation profile for body morph.
    this.animationStyle = GooeyToastAnimationStyle.sileo,

    /// Shape profile applied to roundness.
    this.shapeStyle = GooeyToastShapeStyle.defaultShape,

    /// Surface render mode for gooey effect.
    ///
    /// [GooeyRenderStyle.blurThreshold] uses blur+threshold metaball compositing.
    /// [GooeyRenderStyle.pathMorph] uses a single-pass merged path painter.
    this.renderStyle = GooeyRenderStyle.blurThreshold,

    /// Optional action rendered in expanded default body.
    this.action,

    /// Emits phase transitions whenever expansion status changes.
    this.onExpansionPhaseChanged,

    /// Emits normalized expansion progress (`0..1`) on animation ticks.
    this.onExpansionProgressChanged,

    /// Compact label/icon morph config for in-place updates.
    this.compactMorph = const GooeyCompactMorph(),
  });

  /// Compact title shown in header.
  final String title;

  /// Optional state discriminator for compact morphs.
  final Object? stateTag;

  /// Optional expanded description text.
  final String? description;

  /// Semantic state selecting default tone/icon.
  final GooeyToastState state;

  /// Horizontal compact pill alignment.
  final GooeyToastPosition position;

  /// Vertical body growth direction.
  final GooeyToastExpandDirection expandDirection;

  /// Desired toast lifetime before dismiss.
  final Duration duration;

  /// Optional custom compact icon.
  final Widget? icon;

  /// Optional custom compact content.
  final Widget? compactChild;

  /// Optional custom expanded content.
  final Widget? expandedChild;

  /// Requested toast width in logical px.
  final double width;

  /// Optional surface fill override.
  final Color? fill;

  /// Base roundness in logical px.
  final double roundness;

  /// Optional autopilot scheduler.
  final GooeyAutopilot? autopilot;

  /// Expansion animation style.
  final GooeyToastAnimationStyle animationStyle;

  /// Shape style for corner behavior.
  final GooeyToastShapeStyle shapeStyle;

  /// Surface render mode used by the painter/compositor.
  final GooeyRenderStyle renderStyle;

  /// Optional expanded action.
  final GooeyToastAction? action;

  /// Expansion phase callback.
  final ValueChanged<GooeyToastExpansionPhase>? onExpansionPhaseChanged;

  /// Expansion progress callback.
  final ValueChanged<double>? onExpansionProgressChanged;

  /// Compact morph config.
  final GooeyCompactMorph compactMorph;

  @override
  /// Creates the mutable animation/timing state for this toast widget.
  State<GooeyToast> createState() => _GooeyToastState();
}

class _GooeyToastState extends State<GooeyToast> with TickerProviderStateMixin {
  bool _ready = false;
  bool _expanded = false;
  bool _stackControlled = false;
  bool _stackItemExpanded = false;
  Timer? _expandTimer;
  Timer? _collapseTimer;
  double _measuredExpandedChildHeight = 0;
  late final AnimationController _openController;
  late Animation<double> _openCurve;
  late final AnimationController _compactMorphController;
  late Animation<double> _compactMorphCurve;
  double _frozenExpandedHeight = _kToastHeight * _kMinExpandRatio;
  GooeyToastExpansionPhase _lastPhase = GooeyToastExpansionPhase.closed;
  String? _previousTitle;
  GooeyToastState? _previousState;
  Widget? _previousIcon;
  bool _showPreviousCompact = false;

  bool get _isLoading => widget.state == GooeyToastState.loading;
  bool get _hasContent =>
      widget.description != null ||
      widget.action != null ||
      widget.expandedChild != null;
  bool get _targetOpen {
    final expanded = _stackControlled ? _stackItemExpanded : _expanded;
    return _hasContent && expanded && !_isLoading;
  }

  @override
  void initState() {
    super.initState();
    _openController = AnimationController(
      vsync: this,
      duration: _durationForAnimationStyle(widget.animationStyle),
      reverseDuration: _durationForAnimationStyle(widget.animationStyle),
    );
    _openCurve = CurvedAnimation(
      parent: _openController,
      curve: _curveForAnimationStyle(widget.animationStyle),
    );
    _openController.addStatusListener(_handleOpenStatus);
    _openController.addListener(_handleOpenProgress);
    _compactMorphController = AnimationController(
      vsync: this,
      duration: widget.compactMorph.duration,
    );
    _compactMorphCurve = CurvedAnimation(
      parent: _compactMorphController,
      curve: widget.compactMorph.curve,
    );
    _compactMorphController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _showPreviousCompact = false);
      }
    });
    _emitPhase(
      _targetOpen
          ? GooeyToastExpansionPhase.opening
          : GooeyToastExpansionPhase.closed,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _ready = true);
    });
    _scheduleAutopilot();
  }

  @override
  void didUpdateWidget(covariant GooeyToast oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autopilot != widget.autopilot ||
        oldWidget.duration != widget.duration ||
        oldWidget.description != widget.description ||
        oldWidget.action != widget.action ||
        oldWidget.state != widget.state) {
      _syncOpenAnimation();
      _scheduleAutopilot();
    }
    if (oldWidget.animationStyle != widget.animationStyle) {
      final duration = _durationForAnimationStyle(widget.animationStyle);
      _openController
        ..duration = duration
        ..reverseDuration = duration;
      _openCurve = CurvedAnimation(
        parent: _openController,
        curve: _curveForAnimationStyle(widget.animationStyle),
      );
    }
    if (oldWidget.compactMorph.duration != widget.compactMorph.duration) {
      _compactMorphController.duration = widget.compactMorph.duration;
    }
    if (oldWidget.compactMorph.curve != widget.compactMorph.curve) {
      _compactMorphCurve = CurvedAnimation(
        parent: _compactMorphController,
        curve: widget.compactMorph.curve,
      );
    }
    final defaultCompactTransition =
        oldWidget.compactChild == null &&
        widget.compactChild == null &&
        (oldWidget.title != widget.title ||
            oldWidget.state != widget.state ||
            oldWidget.icon != widget.icon);
    if (defaultCompactTransition) {
      _previousTitle = oldWidget.title;
      _previousState = oldWidget.state;
      _previousIcon = oldWidget.icon;
      _showPreviousCompact = true;
      _compactMorphController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _expandTimer?.cancel();
    _collapseTimer?.cancel();
    _openController.removeStatusListener(_handleOpenStatus);
    _openController.removeListener(_handleOpenProgress);
    _openController.dispose();
    _compactMorphController.dispose();
    super.dispose();
  }

  void _setExpanded(bool value) {
    if (_expanded == value) return;
    setState(() => _expanded = value);
    _syncOpenAnimation();
  }

  void _syncOpenAnimation() {
    if (_targetOpen) {
      _emitPhase(GooeyToastExpansionPhase.opening);
      _openController.forward();
    } else {
      _emitPhase(GooeyToastExpansionPhase.closing);
      _openController.reverse();
    }
  }

  void _handleOpenStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        _emitPhase(GooeyToastExpansionPhase.closed);
        break;
      case AnimationStatus.forward:
        _emitPhase(GooeyToastExpansionPhase.opening);
        break;
      case AnimationStatus.reverse:
        _emitPhase(GooeyToastExpansionPhase.closing);
        break;
      case AnimationStatus.completed:
        _emitPhase(GooeyToastExpansionPhase.open);
        break;
    }
  }

  void _emitPhase(GooeyToastExpansionPhase phase) {
    if (_lastPhase == phase) return;
    _lastPhase = phase;
    widget.onExpansionPhaseChanged?.call(phase);
  }

  void _handleOpenProgress() {
    widget.onExpansionProgressChanged?.call(
      _openController.value.clamp(0.0, 1.0).toDouble(),
    );
  }

  void _scheduleAutopilot() {
    _expandTimer?.cancel();
    _collapseTimer?.cancel();
    if (_stackControlled) return;

    final autopilot = widget.autopilot;
    if (autopilot == null || !_hasContent || _isLoading) {
      if (_isLoading) _setExpanded(false);
      return;
    }

    final expandDelay = autopilot.expandDelay ?? _kDefaultExpandDelay;
    final collapseDelay = autopilot.collapseDelay ?? _kDefaultCollapseDelay;

    if (expandDelay > Duration.zero) {
      _expandTimer = Timer(expandDelay, () {
        if (!mounted) return;
        _setExpanded(true);
      });
    } else {
      _setExpanded(true);
    }

    if (collapseDelay > Duration.zero) {
      _collapseTimer = Timer(collapseDelay, () {
        if (!mounted) return;
        _setExpanded(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _syncFromStackScope(context);
    final stack = ToastStackScope.maybeOf(context);
    final theme = Theme.of(context);
    final gooeyTheme = shad.ComponentTheme.maybeOf<GooeyToastTheme>(context);
    final resolvedShapeStyle =
        widget.shapeStyle == GooeyToastShapeStyle.defaultShape
        ? (gooeyTheme?.shapeStyle ?? widget.shapeStyle)
        : widget.shapeStyle;
    final toastWidth = widget.width > 0
        ? widget.width
        : (gooeyTheme?.width ?? _kToastWidth);
    final resolvedRoundness = _roundnessForShape(
      widget.roundness,
      resolvedShapeStyle,
    );
    final fillColor =
        widget.fill ?? gooeyTheme?.fill ?? const Color(0xFF0D1117);
    final tone = _toneForState(widget.state, gooeyTheme);
    final titleStyle =
        gooeyTheme?.titleStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          fontSize: 13.2,
          height: 1.0,
          fontWeight: FontWeight.w500,
          color: tone,
        );
    final descriptionStyle =
        gooeyTheme?.descriptionStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          height: 1.43,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFC0C5CB),
        );
    final showStackControls =
        stack != null && stack.hasMultiple && stack.isPrimary;
    final showExpandedControls = showStackControls && stack.expanded;
    final basePillWidth =
        _measurePillWidth(theme.textTheme, toastWidth, titleStyle) +
        (showExpandedControls ? 112.0 : 0.0);
    final pillWidth = basePillWidth.clamp(_kToastHeight, toastWidth).toDouble();
    final contentHeight = _measureContentHeight(
      theme.textTheme,
      toastWidth,
      descriptionStyle,
      measuredExpandedChildHeight: _measuredExpandedChildHeight,
    );
    final minExpanded = _kToastHeight * _kMinExpandRatio;
    final rawExpanded = _hasContent
        ? (contentHeight + _kToastHeight).clamp(minExpanded, 1000.0)
        : minExpanded;

    final targetOpen = _targetOpen;
    if (targetOpen) {
      _frozenExpandedHeight = rawExpanded;
    }

    final blur = widget.renderStyle == GooeyRenderStyle.blurThreshold
        ? resolvedRoundness * _kBlurRatio
        : 0.0;
    final pillHeight = _kToastHeight + blur * 3;

    final pillX = switch (widget.position) {
      GooeyToastPosition.right => toastWidth - pillWidth,
      GooeyToastPosition.center => (toastWidth - pillWidth) / 2.0,
      GooeyToastPosition.left => 0.0,
      GooeyToastPosition.centerLeft => 0.0,
      GooeyToastPosition.centerRight => toastWidth - pillWidth,
    };
    final targetExpandedHeight = targetOpen
        ? rawExpanded
        : _frozenExpandedHeight;
    final passThroughToStack = _stackControlled && (stack?.isPrimary == false);
    final compactToggle = _stackControlled
        ? null
        : () {
            if (!_hasContent || _isLoading) return;
            _collapseTimer?.cancel();
            _setExpanded(!_expanded);
          };

    final onVisibleExpandedSizeChanged = widget.expandedChild == null
        ? null
        : (Size size) {
            final next = size.height.clamp(0, 4000).toDouble();
            if ((next - _measuredExpandedChildHeight).abs() < 0.5 || !mounted) {
              return;
            }
            setState(() => _measuredExpandedChildHeight = next);
          };

    final Widget body = IgnorePointer(
      ignoring: passThroughToStack,
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        onEnter: (_) {
          if (_stackControlled) return;
          if (_hasContent && !_isLoading) {
            _collapseTimer?.cancel();
            _setExpanded(true);
          }
        },
        onExit: (_) {
          if (_stackControlled) return;
          if (_hasContent && !_isLoading) {
            _setExpanded(false);
          }
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          opacity: _ready ? 1 : 0,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            scale: _ready ? 1 : 0.95,
            child: AnimatedBuilder(
              animation: _openCurve,
              builder: (context, _) {
                final rawOpenProgress = _openCurve.value;
                final openProgress = _stackControlled && !_stackItemExpanded
                    ? 0.0
                    : rawOpenProgress;
                final normalizedOpen = openProgress.clamp(0.0, 1.0).toDouble();
                final visualHeight =
                    lerpDouble(
                      _kToastHeight,
                      targetExpandedHeight,
                      openProgress,
                    ) ??
                    _kToastHeight;
                final canvasHeight = _hasContent ? visualHeight : _kToastHeight;
                final expandedContentHeight =
                    (targetExpandedHeight - _kToastHeight)
                        .clamp(0.0, 1000.0)
                        .toDouble();
                final pillScaleY =
                    lerpDouble(_kToastHeight / pillHeight, 1.0, openProgress) ??
                    1.0;
                final bodyScaleY = Curves.easeInOut.transform(normalizedOpen);
                final translateY =
                    (widget.expandDirection == GooeyToastExpandDirection.bottom
                        ? 3.0
                        : -3.0) *
                    openProgress;
                final headerScale = lerpDouble(1.0, 0.9, openProgress) ?? 1.0;
                final contentProgress = ((openProgress - 0.35) / 0.65).clamp(
                  0.0,
                  1.0,
                );
                final contentOpacity = Curves.easeOutCubic.transform(
                  contentProgress,
                );
                final contentHeightFactor = contentProgress;
                final contentAlignment =
                    widget.expandDirection == GooeyToastExpandDirection.bottom
                    ? Alignment.topCenter
                    : Alignment.bottomCenter;
                final contentSlide =
                    (1 - contentOpacity) *
                    (widget.expandDirection == GooeyToastExpandDirection.bottom
                        ? -6.0
                        : 6.0);

                final headerTransform = Matrix4.identity()
                  ..translate(0.0, translateY)
                  ..scale(headerScale, headerScale);

                return AnimatedSize(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeInOutCubic,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: toastWidth,
                    height: visualHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top:
                              widget.expandDirection ==
                                  GooeyToastExpandDirection.bottom
                              ? 0
                              : null,
                          bottom:
                              widget.expandDirection ==
                                  GooeyToastExpandDirection.top
                              ? 0
                              : null,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.diagonal3Values(
                              1,
                              widget.expandDirection ==
                                      GooeyToastExpandDirection.top
                                  ? -1
                                  : 1,
                              1,
                            ),
                            child: _GooeyLayer(
                              width: toastWidth,
                              height: canvasHeight,
                              color: fillColor,
                              blur: blur,
                              roundness: resolvedRoundness,
                              pillX: pillX,
                              pillWidth: pillWidth,
                              pillHeight: pillHeight,
                              pillScaleY: pillScaleY,
                              bodyHeight: expandedContentHeight,
                              bodyScaleY: bodyScaleY,
                              renderStyle: widget.renderStyle,
                            ),
                          ),
                        ),
                        Positioned(
                          left: pillX,
                          top:
                              widget.expandDirection ==
                                  GooeyToastExpandDirection.bottom
                              ? 0
                              : null,
                          bottom:
                              widget.expandDirection ==
                                  GooeyToastExpandDirection.top
                              ? 0
                              : null,
                          child: MouseRegion(
                            cursor: compactToggle == null
                                ? SystemMouseCursors.basic
                                : SystemMouseCursors.click,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: compactToggle,
                              child: Container(
                                transform: headerTransform,
                                transformAlignment: Alignment.center,
                                width: pillWidth,
                                height: _kToastHeight,
                                padding: const EdgeInsets.all(8),
                                child:
                                    widget.compactChild ??
                                    Row(
                                      children: [
                                        _buildCompactIcon(
                                          tone: tone,
                                          icon: widget.icon,
                                          state: widget.state,
                                          gooeyTheme: gooeyTheme,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: _buildCompactTitle(
                                            titleStyle: titleStyle,
                                            currentTone: tone,
                                            gooeyTheme: gooeyTheme,
                                          ),
                                        ),
                                        if (showExpandedControls) ...[
                                          const SizedBox(width: 6),
                                          _buildHeaderControlChip(
                                            label: 'Collapse',
                                            tone: tone,
                                            onTap: () =>
                                                stack.setExpanded(false),
                                          ),
                                          const SizedBox(width: 6),
                                          _buildHeaderControlChip(
                                            label: 'Clear all',
                                            tone: tone,
                                            onTap: stack.dismissAll,
                                          ),
                                        ],
                                      ],
                                    ),
                              ),
                            ),
                          ),
                        ),
                        if (_hasContent)
                          Positioned(
                            left: 0,
                            top:
                                widget.expandDirection ==
                                    GooeyToastExpandDirection.bottom
                                ? _kToastHeight
                                : 0,
                            child: IgnorePointer(
                              ignoring: contentOpacity < 0.99,
                              child: ClipRect(
                                child: Align(
                                  alignment: contentAlignment,
                                  heightFactor: contentHeightFactor,
                                  child: Opacity(
                                    opacity: contentOpacity,
                                    child: Transform.translate(
                                      offset: Offset(0, contentSlide),
                                      child: SizedBox(
                                        width: toastWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: _MeasureSize(
                                            onSizeChanged:
                                                onVisibleExpandedSizeChanged ??
                                                (_) {},
                                            child: _buildExpandedContent(
                                              descriptionStyle:
                                                  descriptionStyle,
                                              tone: tone,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
    return body;
  }

  Widget _buildExpandedContent({
    required TextStyle? descriptionStyle,
    required Color tone,
  }) {
    final baseContent =
        widget.expandedChild ??
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.description != null)
              Text(widget.description!, style: descriptionStyle),
            if (widget.action != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                  onPressed: widget.action!.onPressed,
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 28),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: const StadiumBorder(),
                    foregroundColor: tone,
                    backgroundColor: tone.withValues(alpha: 0.15),
                  ),
                  child: Text(
                    widget.action!.label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        );

    return baseContent;
  }

  Widget _buildCompactIcon({
    required Color tone,
    required Widget? icon,
    required GooeyToastState state,
    required GooeyToastTheme? gooeyTheme,
  }) {
    return AnimatedBuilder(
      animation: _compactMorphCurve,
      builder: (context, _) {
        final t = _showPreviousCompact
            ? _compactMorphCurve.value.clamp(0.0, 1.0).toDouble()
            : 1.0;
        final morph = widget.compactMorph;
        final previousTone = _toneForState(_previousState ?? state, gooeyTheme);
        final previousOpacity = _showPreviousCompact
            ? (1 - t).clamp(0.0, 1.0).toDouble()
            : 0.0;
        final currentOpacity = _showPreviousCompact
            ? t.clamp(0.0, 1.0).toDouble()
            : 1.0;
        return SizedBox(
          height: 24,
          width: 24,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_showPreviousCompact)
                Opacity(
                  opacity: previousOpacity,
                  child: _compactIconSurface(
                    tone: previousTone,
                    icon: _previousIcon,
                    state: _previousState ?? state,
                    scale:
                        morph.scaleFrom +
                        (1 - morph.scaleFrom) * previousOpacity,
                  ),
                ),
              Opacity(
                opacity: currentOpacity,
                child: _compactIconSurface(
                  tone: tone,
                  icon: icon,
                  state: state,
                  scale:
                      morph.scaleFrom + (1 - morph.scaleFrom) * currentOpacity,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _compactIconSurface({
    required Color tone,
    required Widget? icon,
    required GooeyToastState state,
    required double scale,
  }) {
    return Transform.scale(
      scale: scale.clamp(0.65, 1.15).toDouble(),
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: IconTheme(
          data: IconThemeData(color: tone, size: 16),
          child: icon ?? _defaultIcon(state, tone),
        ),
      ),
    );
  }

  Widget _buildCompactTitle({
    required TextStyle? titleStyle,
    required Color currentTone,
    required GooeyToastTheme? gooeyTheme,
  }) {
    return AnimatedBuilder(
      animation: _compactMorphCurve,
      builder: (context, _) {
        final morph = widget.compactMorph;
        final t = _showPreviousCompact
            ? _compactMorphCurve.value.clamp(0.0, 1.0).toDouble()
            : 1.0;
        final previousOpacity = _showPreviousCompact
            ? (1 - t).clamp(0.0, 1.0).toDouble()
            : 0.0;
        final currentOpacity = _showPreviousCompact
            ? t.clamp(0.0, 1.0).toDouble()
            : 1.0;
        final previousOffset = _showPreviousCompact
            ? Offset(
                -morph.slideOffset.dx * t,
                -morph.slideOffset.dy * t * _kToastHeight,
              )
            : Offset.zero;
        final currentOffset = _showPreviousCompact
            ? Offset(
                morph.slideOffset.dx * (1 - t),
                morph.slideOffset.dy * (1 - t) * _kToastHeight,
              )
            : Offset.zero;
        final previousTone = _toneForState(
          _previousState ?? widget.state,
          gooeyTheme,
        );
        final previousStyle = (titleStyle ?? const TextStyle()).copyWith(
          color: previousTone,
        );
        final nextStyle = (titleStyle ?? const TextStyle()).copyWith(
          color: currentTone,
        );
        return Stack(
          children: [
            if (_showPreviousCompact && _previousTitle != null)
              Opacity(
                opacity: previousOpacity,
                child: Transform.translate(
                  offset: previousOffset,
                  child: Text(
                    _previousTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: previousStyle,
                  ),
                ),
              ),
            Opacity(
              opacity: currentOpacity,
              child: Transform.translate(
                offset: currentOffset,
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: nextStyle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeaderControlChip({
    required String label,
    required Color tone,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: 22,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: tone.withValues(alpha: 0.26)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: tone,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  void _syncFromStackScope(BuildContext context) {
    final stack = ToastStackScope.maybeOf(context);
    final nextControlled =
        (stack?.hasMultiple ?? false) && (stack?.expanded ?? false);
    final nextItemExpanded = stack?.itemExpanded ?? false;
    if (_stackControlled == nextControlled &&
        _stackItemExpanded == nextItemExpanded) {
      return;
    }
    _stackControlled = nextControlled;
    _stackItemExpanded = nextItemExpanded;
    if (_stackControlled) {
      _expandTimer?.cancel();
      _collapseTimer?.cancel();
    }
    _syncOpenAnimation();
  }

  double _measurePillWidth(
    TextTheme textTheme,
    double toastWidth,
    TextStyle? titleStyle,
  ) {
    final style =
        titleStyle ??
        textTheme.bodyMedium?.copyWith(
          fontSize: 13.2,
          fontWeight: FontWeight.w500,
          height: 1.0,
        );
    final painter = TextPainter(
      text: TextSpan(text: widget.title, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();

    final innerWidth = 24 + 8 + painter.width;
    final withPadding = innerWidth + 16 + _kPillPadding;
    return withPadding.clamp(_kToastHeight, toastWidth).toDouble();
  }

  double _measureContentHeight(
    TextTheme textTheme,
    double toastWidth,
    TextStyle? descriptionStyle, {
    double measuredExpandedChildHeight = 0,
  }) {
    if (!_hasContent) return 0;

    if (widget.expandedChild != null && measuredExpandedChildHeight > 0) {
      return measuredExpandedChildHeight + 32;
    }

    final textStyle =
        descriptionStyle ??
        textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          height: 1.43,
          fontWeight: FontWeight.w400,
        );

    double h = 0;

    if (widget.description != null) {
      final painter = TextPainter(
        text: TextSpan(text: widget.description!, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: toastWidth - 32);
      h += painter.height;
    }

    if (widget.action != null) {
      h += 12 + 28;
    }

    // Before first measurement pass, reserve safe minimum for custom content.
    if (widget.expandedChild != null) {
      h = h < 140 ? 140 : h;
    }

    return h + 32;
  }

  Widget _defaultIcon(GooeyToastState state, Color color) {
    switch (state) {
      case GooeyToastState.success:
        return Icon(Icons.check, color: color, size: 16);
      case GooeyToastState.loading:
        return SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        );
      case GooeyToastState.error:
        return Icon(Icons.close, color: color, size: 16);
      case GooeyToastState.warning:
        return Icon(Icons.warning_amber_rounded, color: color, size: 16);
      case GooeyToastState.info:
        return Icon(Icons.info_outline, color: color, size: 16);
      case GooeyToastState.action:
        return Icon(Icons.arrow_forward, color: color, size: 16);
    }
  }
}

class _GooeyLayer extends StatelessWidget {
  const _GooeyLayer({
    required this.width,
    required this.height,
    required this.color,
    required this.blur,
    required this.roundness,
    required this.pillX,
    required this.pillWidth,
    required this.pillHeight,
    required this.pillScaleY,
    required this.bodyHeight,
    required this.bodyScaleY,
    required this.renderStyle,
  });

  final double width;
  final double height;
  final Color color;
  final double blur;
  final double roundness;
  final double pillX;
  final double pillWidth;
  final double pillHeight;
  final double pillScaleY;
  final double bodyHeight;
  final double bodyScaleY;
  final GooeyRenderStyle renderStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(width, height),
          painter: _GooeyPainter(
            color: color,
            roundness: roundness,
            pillX: pillX,
            pillWidth: pillWidth,
            pillHeight: pillHeight,
            pillScaleY: pillScaleY,
            bodyHeight: bodyHeight,
            bodyScaleY: bodyScaleY,
            renderStyle: renderStyle,
            blur: blur,
          ),
        ),
      ),
    );
  }
}

class _GooeyPainter extends CustomPainter {
  _GooeyPainter({
    required this.color,
    required this.roundness,
    required this.pillX,
    required this.pillWidth,
    required this.pillHeight,
    required this.pillScaleY,
    required this.bodyHeight,
    required this.bodyScaleY,
    required this.renderStyle,
    required this.blur,
  });

  final Color color;
  final double roundness;
  final double pillX;
  final double pillWidth;
  final double pillHeight;
  final double pillScaleY;
  final double bodyHeight;
  final double bodyScaleY;
  final GooeyRenderStyle renderStyle;
  final double blur;

  @override
  void paint(Canvas canvas, Size size) {
    if (renderStyle == GooeyRenderStyle.pathMorph) {
      final paint = Paint()
        ..color = color
        ..isAntiAlias = true;
      final scaledPillHeight = pillHeight * pillScaleY;
      final pillRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(pillX, 0, pillWidth, scaledPillHeight),
        Radius.circular(roundness),
      );
      _paintPathMorph(canvas, size, paint, pillRect);
      return;
    }

    _paintGooeyBlurThreshold(canvas, size);
  }

  void _paintLegacyBody(Canvas canvas, Size size, Paint paint) {
    if (bodyHeight <= 0 || bodyScaleY <= 0) return;
    const seamOverlap = 2.0;
    canvas.save();
    canvas.translate(0, _kToastHeight - seamOverlap);
    canvas.scale(1, bodyScaleY);
    final bodyPaint = Paint()
      ..color = color
      ..isAntiAlias = true;
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, bodyHeight + seamOverlap),
      Radius.circular(roundness),
    );
    canvas.drawRRect(bodyRect, bodyPaint);
    canvas.restore();
  }

  void _paintGooeyBlurThreshold(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final sigma = blur;
    final layerBounds = bounds.inflate(sigma * 3.0);

    final thresholdPaint = Paint()
      ..colorFilter = const ColorFilter.matrix(<double>[
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        20,
        -2550,
      ]);

    // Build mask -> blur -> threshold in one stable painter pipeline.
    canvas.saveLayer(layerBounds, thresholdPaint);
    canvas.saveLayer(
      layerBounds,
      Paint()..imageFilter = ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
    );
    _drawMaskShapes(
      canvas,
      size,
      Paint()
        ..color = const Color(0xFFFFFFFF)
        ..isAntiAlias = true,
    );
    canvas.restore();
    canvas.restore();

    // Colorize final alpha mask.
    canvas.drawRect(
      bounds,
      Paint()
        ..color = color
        ..blendMode = BlendMode.srcIn,
    );

    // Keep a crisp pass on top to preserve edge sharpness.
    _drawCrispShapes(
      canvas,
      size,
      Paint()
        ..color = color
        ..isAntiAlias = true,
    );
  }

  void _drawMaskShapes(Canvas canvas, Size size, Paint paint) {
    final scaledPillHeight = pillHeight * pillScaleY;
    final pillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(pillX, 0, pillWidth, scaledPillHeight),
      Radius.circular(roundness),
    );
    canvas.drawRRect(pillRect, paint);
    _paintLegacyBody(canvas, size, paint);
  }

  void _drawCrispShapes(Canvas canvas, Size size, Paint paint) {
    final scaledPillHeight = pillHeight * pillScaleY;
    final pillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(pillX, 0, pillWidth, scaledPillHeight),
      Radius.circular(roundness),
    );
    canvas.drawRRect(pillRect, paint);
    _paintLegacyBody(canvas, size, paint);
  }

  void _paintPathMorph(Canvas canvas, Size size, Paint paint, RRect pillRect) {
    final merged = Path()..addRRect(pillRect);
    if (bodyHeight <= 0 || bodyScaleY <= 0) {
      canvas.drawPath(merged, paint);
      return;
    }

    const seamOverlap = 2.0;
    final progress = Curves.easeInOutCubic.transform(
      bodyScaleY.clamp(0.0, 1.0),
    );
    final bodyTop = _kToastHeight - seamOverlap;
    final currentBodyHeight = (bodyHeight + seamOverlap) * progress;
    if (currentBodyHeight <= 0.5) {
      canvas.drawPath(merged, paint);
      return;
    }

    final bodyPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, bodyTop, size.width, currentBodyHeight),
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.circular(roundness),
          bottomRight: Radius.circular(roundness),
        ),
      );

    final leftBridgeStart = pillX.clamp(0.0, size.width).toDouble();
    final rightBridgeStart = (pillX + pillWidth)
        .clamp(0.0, size.width)
        .toDouble();
    final bridgeTop = bodyTop;
    final bridgeBottom = pillRect.bottom;
    final bridgeOutset = lerpDouble(0.0, roundness * 0.92, progress) ?? 0.0;
    final leftBridgeBottom = (leftBridgeStart - bridgeOutset).clamp(
      0.0,
      rightBridgeStart,
    );
    final rightBridgeBottom = (rightBridgeStart + bridgeOutset).clamp(
      leftBridgeStart,
      size.width,
    );

    final bridgePath = Path();
    if (bridgeBottom > bridgeTop) {
      final bridgeControlY =
          lerpDouble(bridgeTop, bridgeBottom, 0.58) ?? bridgeBottom;
      bridgePath
        ..moveTo(leftBridgeStart, bridgeTop)
        ..quadraticBezierTo(
          leftBridgeBottom,
          bridgeControlY,
          leftBridgeBottom,
          bridgeBottom,
        )
        ..lineTo(rightBridgeBottom, bridgeBottom)
        ..quadraticBezierTo(
          rightBridgeBottom,
          bridgeControlY,
          rightBridgeStart,
          bridgeTop,
        )
        ..close();
    }

    final withBody = Path.combine(PathOperation.union, merged, bodyPath);
    final finalPath = bridgePath.getBounds().isEmpty
        ? withBody
        : Path.combine(PathOperation.union, withBody, bridgePath);
    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(covariant _GooeyPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.roundness != roundness ||
        oldDelegate.pillX != pillX ||
        oldDelegate.pillWidth != pillWidth ||
        oldDelegate.pillHeight != pillHeight ||
        oldDelegate.pillScaleY != pillScaleY ||
        oldDelegate.bodyHeight != bodyHeight ||
        oldDelegate.bodyScaleY != bodyScaleY ||
        oldDelegate.renderStyle != renderStyle ||
        oldDelegate.blur != blur;
  }
}

class _MeasureSize extends SingleChildRenderObjectWidget {
  const _MeasureSize({required this.onSizeChanged, required super.child});

  final ValueChanged<Size> onSizeChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMeasureSize(onSizeChanged);
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _RenderMeasureSize).onSizeChanged = onSizeChanged;
  }
}

class _RenderMeasureSize extends RenderProxyBox {
  _RenderMeasureSize(this.onSizeChanged);

  ValueChanged<Size> onSizeChanged;
  Size? _lastSize;

  @override
  void performLayout() {
    super.performLayout();
    final sizeNow = child?.size ?? size;
    if (_lastSize == sizeNow) return;
    _lastSize = sizeNow;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSizeChanged(sizeNow);
    });
  }
}
