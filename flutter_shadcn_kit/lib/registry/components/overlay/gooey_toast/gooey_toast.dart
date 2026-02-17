import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../shared/theme/theme.dart' as shad;
import '../toast/toast.dart';

const double _kToastHeight = 40;
const double _kToastWidth = 350;
const double _kDefaultRoundness = 18;
const double _kBlurRatio = 0.5;
const double _kPillPadding = 10;
const double _kMinExpandRatio = 2.25;
const Duration _kMorphDuration = Duration(milliseconds: 600);

const Duration _kDefaultDuration = Duration(milliseconds: 6000);
const Duration _kDefaultExpandDelay = Duration(milliseconds: 150);
const Duration _kDefaultCollapseDelay = Duration(milliseconds: 4000);

class GooeyAutopilot {
  const GooeyAutopilot({this.expandDelay, this.collapseDelay});

  final Duration? expandDelay;
  final Duration? collapseDelay;
}

enum GooeyToastState { success, loading, error, warning, info, action }

enum GooeyToastPosition { left, center, right }

enum GooeyToastExpandDirection { top, bottom }

enum GooeyToastAnimationStyle { sileo, smooth, snappy, bouncy }

enum GooeyToastShapeStyle { defaultShape, soft, sharp, capsule }

class GooeyToastAction {
  const GooeyToastAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}

/// Theme data for GooeyToast.
class GooeyToastTheme extends shad.ComponentThemeData {
  const GooeyToastTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.width,
    this.fill,
    this.roundness,
    this.titleStyle,
    this.descriptionStyle,
    this.pauseOnHover,
    this.swipeToDismiss,
    this.dismissDirections,
    this.dismissDragThreshold,
    this.spacing,
    this.overlapStackWhenMultiple,
    this.overlapStackOffset,
    this.pauseAutoDismissWhenMultiple,
    this.stackAnimationDuration,
    this.stackAnimationCurve,
    this.maxVisibleCount,
    this.dismissWholeStackWhenMultiple,
    this.animationStyle,
    this.shapeStyle,
    this.successTone,
    this.loadingTone,
    this.errorTone,
    this.warningTone,
    this.infoTone,
    this.actionTone,
  });

  final double? width;
  final Color? fill;
  final double? roundness;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final bool? pauseOnHover;
  final bool? swipeToDismiss;
  final Set<ToastSwipeDirection>? dismissDirections;
  final double? dismissDragThreshold;
  final double? spacing;
  final bool? overlapStackWhenMultiple;
  final double? overlapStackOffset;
  final bool? pauseAutoDismissWhenMultiple;
  final Duration? stackAnimationDuration;
  final Curve? stackAnimationCurve;
  final int? maxVisibleCount;
  final bool? dismissWholeStackWhenMultiple;
  final GooeyToastAnimationStyle? animationStyle;
  final GooeyToastShapeStyle? shapeStyle;
  final Color? successTone;
  final Color? loadingTone;
  final Color? errorTone;
  final Color? warningTone;
  final Color? infoTone;
  final Color? actionTone;

  GooeyToastTheme copyWith({
    ValueGetter<double?>? width,
    ValueGetter<Color?>? fill,
    ValueGetter<double?>? roundness,
    ValueGetter<TextStyle?>? titleStyle,
    ValueGetter<TextStyle?>? descriptionStyle,
    ValueGetter<bool?>? pauseOnHover,
    ValueGetter<bool?>? swipeToDismiss,
    ValueGetter<Set<ToastSwipeDirection>?>? dismissDirections,
    ValueGetter<double?>? dismissDragThreshold,
    ValueGetter<double?>? spacing,
    ValueGetter<bool?>? overlapStackWhenMultiple,
    ValueGetter<double?>? overlapStackOffset,
    ValueGetter<bool?>? pauseAutoDismissWhenMultiple,
    ValueGetter<Duration?>? stackAnimationDuration,
    ValueGetter<Curve?>? stackAnimationCurve,
    ValueGetter<int?>? maxVisibleCount,
    ValueGetter<bool?>? dismissWholeStackWhenMultiple,
    ValueGetter<GooeyToastAnimationStyle?>? animationStyle,
    ValueGetter<GooeyToastShapeStyle?>? shapeStyle,
    ValueGetter<Color?>? successTone,
    ValueGetter<Color?>? loadingTone,
    ValueGetter<Color?>? errorTone,
    ValueGetter<Color?>? warningTone,
    ValueGetter<Color?>? infoTone,
    ValueGetter<Color?>? actionTone,
  }) {
    return GooeyToastTheme(
      width: width == null ? this.width : width(),
      fill: fill == null ? this.fill : fill(),
      roundness: roundness == null ? this.roundness : roundness(),
      titleStyle: titleStyle == null ? this.titleStyle : titleStyle(),
      descriptionStyle: descriptionStyle == null
          ? this.descriptionStyle
          : descriptionStyle(),
      pauseOnHover: pauseOnHover == null ? this.pauseOnHover : pauseOnHover(),
      swipeToDismiss: swipeToDismiss == null
          ? this.swipeToDismiss
          : swipeToDismiss(),
      dismissDirections: dismissDirections == null
          ? this.dismissDirections
          : dismissDirections(),
      dismissDragThreshold: dismissDragThreshold == null
          ? this.dismissDragThreshold
          : dismissDragThreshold(),
      spacing: spacing == null ? this.spacing : spacing(),
      overlapStackWhenMultiple: overlapStackWhenMultiple == null
          ? this.overlapStackWhenMultiple
          : overlapStackWhenMultiple(),
      overlapStackOffset: overlapStackOffset == null
          ? this.overlapStackOffset
          : overlapStackOffset(),
      pauseAutoDismissWhenMultiple: pauseAutoDismissWhenMultiple == null
          ? this.pauseAutoDismissWhenMultiple
          : pauseAutoDismissWhenMultiple(),
      stackAnimationDuration: stackAnimationDuration == null
          ? this.stackAnimationDuration
          : stackAnimationDuration(),
      stackAnimationCurve: stackAnimationCurve == null
          ? this.stackAnimationCurve
          : stackAnimationCurve(),
      maxVisibleCount: maxVisibleCount == null
          ? this.maxVisibleCount
          : maxVisibleCount(),
      dismissWholeStackWhenMultiple: dismissWholeStackWhenMultiple == null
          ? this.dismissWholeStackWhenMultiple
          : dismissWholeStackWhenMultiple(),
      animationStyle: animationStyle == null
          ? this.animationStyle
          : animationStyle(),
      shapeStyle: shapeStyle == null ? this.shapeStyle : shapeStyle(),
      successTone: successTone == null ? this.successTone : successTone(),
      loadingTone: loadingTone == null ? this.loadingTone : loadingTone(),
      errorTone: errorTone == null ? this.errorTone : errorTone(),
      warningTone: warningTone == null ? this.warningTone : warningTone(),
      infoTone: infoTone == null ? this.infoTone : infoTone(),
      actionTone: actionTone == null ? this.actionTone : actionTone(),
    );
  }
}

class GooeyToastController {
  GooeyToastController({ToastController? toastController})
    : _toastController =
          toastController ??
          ToastController(
            defaultDuration: _kDefaultDuration,
            animationDuration: const Duration(milliseconds: 250),
          );

  final ToastController _toastController;

  void show({
    required BuildContext context,
    String? id,
    required String title,
    String? description,
    GooeyToastState state = GooeyToastState.success,
    GooeyToastPosition position = GooeyToastPosition.left,
    GooeyToastExpandDirection expandDirection =
        GooeyToastExpandDirection.bottom,
    Duration? duration,
    Widget? icon,
    Widget? compactChild,
    Widget? expandedChild,
    double? width,
    Color? fill,
    double? roundness,
    GooeyAutopilot? autopilot = const GooeyAutopilot(),
    GooeyToastAnimationStyle? animationStyle,
    GooeyToastShapeStyle? shapeStyle,
    bool? pauseOnHover,
    bool? swipeToDismiss,
    Set<ToastSwipeDirection>? dismissDirections,
    double? dismissDragThreshold,
    double? spacing,
    bool? overlapStackWhenMultiple,
    double? overlapStackOffset,
    bool? pauseAutoDismissWhenMultiple,
    Duration? stackAnimationDuration,
    Curve? stackAnimationCurve,
    int? maxVisibleCount,
    bool? dismissWholeStackWhenMultiple,
    GooeyToastAction? action,
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
    final leftCenter = ((screenWidth - resolvedWidth) / 2).clamp(
      edgeInset,
      screenWidth - resolvedWidth - edgeInset,
    );
    final resolvedLeft = switch (position) {
      GooeyToastPosition.left => edgeInset,
      GooeyToastPosition.center => leftCenter.toDouble(),
      GooeyToastPosition.right => null,
    };
    final resolvedRight = switch (position) {
      GooeyToastPosition.left => null,
      GooeyToastPosition.center => null,
      GooeyToastPosition.right => edgeInset,
    };
    final showTop = expandDirection == GooeyToastExpandDirection.bottom;
    final resolvedTop = showTop ? edgeInset : null;
    final resolvedBottom = showTop ? null : edgeInset;

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
      dismissDirections: resolvedDismissDirections,
      dismissDragThreshold: resolvedDismissDragThreshold,
      top: resolvedTop,
      bottom: resolvedBottom,
      left: resolvedLeft,
      right: resolvedRight,
      builder: (_) => GooeyToast(
        title: title,
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
        action: action,
      ),
    );
  }

  void success({
    required BuildContext context,
    required String title,
    String? description,
    Color? fill,
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

  void error({
    required BuildContext context,
    required String title,
    String? description,
    Color? fill,
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

class GooeyToast extends StatefulWidget {
  const GooeyToast({
    super.key,
    required this.title,
    this.description,
    this.state = GooeyToastState.success,
    this.position = GooeyToastPosition.left,
    this.expandDirection = GooeyToastExpandDirection.bottom,
    this.duration = _kDefaultDuration,
    this.icon,
    this.compactChild,
    this.expandedChild,
    this.width = _kToastWidth,
    this.fill,
    this.roundness = _kDefaultRoundness,
    this.autopilot,
    this.animationStyle = GooeyToastAnimationStyle.sileo,
    this.shapeStyle = GooeyToastShapeStyle.defaultShape,
    this.action,
  });

  final String title;
  final String? description;
  final GooeyToastState state;
  final GooeyToastPosition position;
  final GooeyToastExpandDirection expandDirection;
  final Duration duration;
  final Widget? icon;
  final Widget? compactChild;
  final Widget? expandedChild;
  final double width;
  final Color? fill;
  final double roundness;
  final GooeyAutopilot? autopilot;
  final GooeyToastAnimationStyle animationStyle;
  final GooeyToastShapeStyle shapeStyle;
  final GooeyToastAction? action;

  @override
  State<GooeyToast> createState() => _GooeyToastState();
}

class _GooeyToastState extends State<GooeyToast>
    with SingleTickerProviderStateMixin {
  bool _ready = false;
  bool _expanded = false;
  bool _stackControlled = false;
  bool _stackExpanded = false;
  bool _stackItemExpanded = false;
  Timer? _expandTimer;
  Timer? _collapseTimer;
  double _measuredExpandedChildHeight = 0;
  late final AnimationController _openController;
  late Animation<double> _openCurve;
  double _frozenExpandedHeight = _kToastHeight * _kMinExpandRatio;

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
  }

  @override
  void dispose() {
    _expandTimer?.cancel();
    _collapseTimer?.cancel();
    _openController.dispose();
    super.dispose();
  }

  void _setExpanded(bool value) {
    if (_expanded == value) return;
    setState(() => _expanded = value);
    _syncOpenAnimation();
  }

  void _syncOpenAnimation() {
    if (_targetOpen) {
      _openController.forward();
    } else {
      _openController.reverse();
    }
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
    final customCompactMinWidth = widget.compactChild == null
        ? _kToastHeight
        : (toastWidth * 0.56).clamp(_kToastHeight, toastWidth).toDouble();
    final pillWidth = math
        .max(basePillWidth, customCompactMinWidth)
        .clamp(_kToastHeight, toastWidth)
        .toDouble();
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

    final blur = resolvedRoundness * _kBlurRatio;
    final pillHeight = _kToastHeight + blur * 3;

    final pillX = switch (widget.position) {
      GooeyToastPosition.right => toastWidth - pillWidth,
      GooeyToastPosition.center => (toastWidth - pillWidth) / 2.0,
      GooeyToastPosition.left => 0.0,
    };
    final targetExpandedHeight = targetOpen
        ? rawExpanded
        : _frozenExpandedHeight;
    final passThroughToStack = _stackControlled && (stack?.isPrimary == false);

    Widget body = IgnorePointer(
      ignoring: passThroughToStack,
      child: MouseRegion(
        cursor: _isLoading
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
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
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _stackControlled
              ? null
              : () {
                  if (!_hasContent || _isLoading) return;
                  _collapseTimer?.cancel();
                  _setExpanded(!_expanded);
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
                  final normalizedOpen = openProgress
                      .clamp(0.0, 1.0)
                      .toDouble();
                  final visualHeight =
                      lerpDouble(
                        _kToastHeight,
                        targetExpandedHeight,
                        openProgress,
                      ) ??
                      _kToastHeight;
                  final canvasHeight = _hasContent
                      ? visualHeight
                      : _kToastHeight;
                  final expandedContentHeight =
                      (targetExpandedHeight - _kToastHeight)
                          .clamp(0.0, 1000.0)
                          .toDouble();
                  final pillScaleY =
                      lerpDouble(
                        _kToastHeight / pillHeight,
                        1.0,
                        openProgress,
                      ) ??
                      1.0;
                  final bodyScaleY = Curves.easeInOut.transform(normalizedOpen);
                  final translateY =
                      (widget.expandDirection ==
                              GooeyToastExpandDirection.bottom
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
                      (widget.expandDirection ==
                              GooeyToastExpandDirection.bottom
                          ? -6.0
                          : 6.0);

                  final headerTransform = Matrix4.identity()
                    ..translate(0.0, translateY)
                    ..scale(headerScale, headerScale);

                  return SizedBox(
                    width: toastWidth,
                    height: visualHeight,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
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
                                    Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                        color: tone.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: IconTheme(
                                        data: IconThemeData(
                                          color: tone,
                                          size: 16,
                                        ),
                                        child:
                                            widget.icon ??
                                            _defaultIcon(widget.state, tone),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        widget.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: titleStyle,
                                      ),
                                    ),
                                    if (showExpandedControls) ...[
                                      const SizedBox(width: 6),
                                      _buildHeaderControlChip(
                                        label: 'Collapse',
                                        tone: tone,
                                        onTap: () => stack.setExpanded(false),
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
                                          child: _buildExpandedContent(
                                            descriptionStyle: descriptionStyle,
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.expandedChild == null) {
      return body;
    }

    return Stack(
      children: [
        Offstage(
          child: SizedBox(
            width: toastWidth,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _MeasureSize(
                onSizeChanged: (size) {
                  final next = size.height.clamp(0, 4000).toDouble();
                  if ((next - _measuredExpandedChildHeight).abs() < 0.5 ||
                      !mounted) {
                    return;
                  }
                  setState(() => _measuredExpandedChildHeight = next);
                },
                child: _buildExpandedContent(
                  descriptionStyle: descriptionStyle,
                  tone: tone,
                ),
              ),
            ),
          ),
        ),
        body,
      ],
    );
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
    final nextExpanded = stack?.expanded ?? false;
    final nextItemExpanded = stack?.itemExpanded ?? false;
    if (_stackControlled == nextControlled &&
        _stackExpanded == nextExpanded &&
        _stackItemExpanded == nextItemExpanded) {
      return;
    }
    _stackControlled = nextControlled;
    _stackExpanded = nextExpanded;
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

  @override
  Widget build(BuildContext context) {
    Widget shapeLayer() {
      return RepaintBoundary(
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
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.matrix(<double>[
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
            ]),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: shapeLayer(),
            ),
          ),
          shapeLayer(),
        ],
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
  });

  final Color color;
  final double roundness;
  final double pillX;
  final double pillWidth;
  final double pillHeight;
  final double pillScaleY;
  final double bodyHeight;
  final double bodyScaleY;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    final scaledPillHeight = pillHeight * pillScaleY;
    final pillRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(pillX, 0, pillWidth, scaledPillHeight),
      Radius.circular(roundness),
    );
    canvas.drawRRect(pillRect, paint);

    if (bodyHeight > 0 && bodyScaleY > 0) {
      const seamOverlap = 2.0;
      final bodyAlpha = Curves.easeOut.transform(
        (bodyScaleY * 1.35).clamp(0.0, 1.0),
      );
      canvas.save();
      // Slight overlap keeps the stretched body visually fused to the compact pill.
      canvas.translate(0, _kToastHeight - seamOverlap);
      canvas.scale(1, bodyScaleY);
      final bodyPaint = Paint()
        ..color = color.withValues(alpha: bodyAlpha)
        ..isAntiAlias = true;
      final bodyRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, bodyHeight + seamOverlap),
        Radius.circular(roundness),
      );
      canvas.drawRRect(bodyRect, bodyPaint);
      canvas.restore();
    }
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
        oldDelegate.bodyScaleY != bodyScaleY;
  }
}

double _roundnessForShape(double roundness, GooeyToastShapeStyle style) {
  return switch (style) {
    GooeyToastShapeStyle.defaultShape => roundness,
    GooeyToastShapeStyle.soft => roundness * 1.25,
    GooeyToastShapeStyle.sharp => roundness * 0.75,
    GooeyToastShapeStyle.capsule => _kToastHeight / 2,
  };
}

Duration _durationForAnimationStyle(GooeyToastAnimationStyle style) {
  return switch (style) {
    GooeyToastAnimationStyle.sileo => _kMorphDuration,
    GooeyToastAnimationStyle.smooth => const Duration(milliseconds: 760),
    GooeyToastAnimationStyle.snappy => const Duration(milliseconds: 420),
    GooeyToastAnimationStyle.bouncy => const Duration(milliseconds: 680),
  };
}

Curve _curveForAnimationStyle(GooeyToastAnimationStyle style) {
  return switch (style) {
    GooeyToastAnimationStyle.sileo => Curves.easeInOutCubic,
    GooeyToastAnimationStyle.smooth => Curves.easeInOutQuart,
    GooeyToastAnimationStyle.snappy => Curves.easeOutCubic,
    GooeyToastAnimationStyle.bouncy => Curves.elasticOut,
  };
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

Color _toneForState(GooeyToastState state, [GooeyToastTheme? theme]) {
  return switch (state) {
    GooeyToastState.success => theme?.successTone ?? const Color(0xFF63C65E),
    GooeyToastState.loading => theme?.loadingTone ?? const Color(0xFF8A8F98),
    GooeyToastState.error => theme?.errorTone ?? const Color(0xFFEF5E5E),
    GooeyToastState.warning => theme?.warningTone ?? const Color(0xFFEABB4B),
    GooeyToastState.info => theme?.infoTone ?? const Color(0xFF6EA8FF),
    GooeyToastState.action => theme?.actionTone ?? const Color(0xFF7A8DFF),
  };
}

Set<ToastSwipeDirection> _defaultDismissDirections({
  required GooeyToastPosition position,
  required GooeyToastExpandDirection expandDirection,
}) {
  final directions = <ToastSwipeDirection>{
    if (expandDirection == GooeyToastExpandDirection.bottom)
      ToastSwipeDirection.up
    else
      ToastSwipeDirection.down,
  };
  switch (position) {
    case GooeyToastPosition.left:
      directions.add(ToastSwipeDirection.left);
      break;
    case GooeyToastPosition.right:
      directions.add(ToastSwipeDirection.right);
      break;
    case GooeyToastPosition.center:
      directions.addAll(const {
        ToastSwipeDirection.left,
        ToastSwipeDirection.right,
      });
      break;
  }
  return directions;
}
