import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_impl/state/feature_carousel_controller.dart';
import '_impl/utils/feature_carousel_models.dart';
import '_impl/themes/feature_carousel_theme.dart';

export '_impl/state/feature_carousel_controller.dart';
export '_impl/utils/feature_carousel_models.dart';
export '_impl/themes/feature_carousel_theme.dart';

enum _CarouselDirection { left, right }

class FeatureCardCarousel extends StatefulWidget {
  const FeatureCardCarousel({
    super.key,
    required this.items,
    this.height,
    this.width,
    this.controller,
    this.theme,
    this.cardBuilder,
    this.titleBuilder,
    this.descriptionBuilder,
    this.ctaBuilder,
    this.backgroundBuilder,
  });

  final List<FeatureCarouselItem> items;
  final double? height;
  final double? width;
  final FeatureCarouselController? controller;
  final FeatureCarouselThemeData? theme;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
    FeatureCarouselThemeData theme,
  )? cardBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
  )? titleBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
  )? descriptionBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselItem item,
    int index,
    VoidCallback onAction,
  )? ctaBuilder;
  final Widget Function(
    BuildContext context,
    FeatureCarouselThemeData theme,
  )? backgroundBuilder;

  @override
  State<FeatureCardCarousel> createState() => _FeatureCardCarouselState();
}

class _FeatureCardCarouselState extends State<FeatureCardCarousel>
    with SingleTickerProviderStateMixin {
  late int _index;
  late AnimationController _controller;
  _CarouselDirection _direction = _CarouselDirection.right;
  bool _leftPressed = false;
  bool _rightPressed = false;
  bool _ctaPressed = false;
  bool _leftHover = false;
  bool _rightHover = false;
  int _animationIndex = 0;
  Timer? _autoTimer;
  FeatureCarouselController? _ownedController;
  late FeatureCarouselController _config;
  double _dragDistance = 0;

  FeatureCarouselThemeData get _theme =>
      widget.theme ?? FeatureCarouselThemeData.defaults();

  @override
  void initState() {
    super.initState();
    _config = widget.controller ?? _createOwnedController();
    _config.addListener(_handleControllerChange);
    _index = _config.index.clamp(0, widget.items.length - 1);
    _controller = AnimationController(
      vsync: this,
      duration: _theme.transitionDuration,
    );
    _controller.value = 1;
    _startAutoPlay();
  }

  @override
  void didUpdateWidget(FeatureCardCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChange);
      if (widget.controller != null) {
        _ownedController?.dispose();
        _ownedController = null;
        _config = widget.controller!;
        _config.addListener(_handleControllerChange);
      } else {
        _config = _createOwnedController();
        _config.addListener(_handleControllerChange);
      }
    }
    if (oldWidget.items.length != widget.items.length) {
      _index = _index.clamp(0, widget.items.length - 1);
    }
    _startAutoPlay();
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoTimer?.cancel();
    _config.removeListener(_handleControllerChange);
    _ownedController?.dispose();
    super.dispose();
  }

  FeatureCarouselController _createOwnedController() {
    _ownedController?.dispose();
    _ownedController = FeatureCarouselController();
    return _ownedController!;
  }

  void _handleControllerChange() {
    if (!mounted) return;
    setState(() {
      _index = _config.index.clamp(0, widget.items.length - 1);
    });
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoTimer?.cancel();
    if (!_config.autoPlay || widget.items.length <= 1) {
      return;
    }
    _autoTimer = Timer.periodic(_config.autoPlayInterval, (_) {
      if (!mounted) return;
      _goRight(auto: true);
    });
  }

  void _changeIndex(int next, _CarouselDirection direction) {
    if (widget.items.isEmpty) {
      return;
    }
    setState(() {
      _direction = direction;
      _index = (next + widget.items.length) % widget.items.length;
      _config.index = _index;
      if (_config.cycleAnimationStyles) {
        _animationIndex =
            (_animationIndex + 1) % FeatureCarouselAnimationStyle.values.length;
      }
    });
    _controller.forward(from: 0);
  }

  void _goLeft({bool auto = false}) {
    _changeIndex(_index - 1, _CarouselDirection.left);
    if (!auto) {
      _startAutoPlay();
    }
  }

  void _goRight({bool auto = false}) {
    _changeIndex(_index + 1, _CarouselDirection.right);
    if (!auto) {
      _startAutoPlay();
    }
  }

  void _handleCta() {
    if (widget.items.isEmpty) {
      return;
    }
    _config.onPrimaryAction?.call(widget.items[_index], _index);
    if (!kIsWeb) {
      HapticFeedback.lightImpact();
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_config.enableSwipe) {
      return;
    }
    final dragDistance = _dragDistance;
    _dragDistance = 0;
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() > 550) {
      velocity < 0 ? _goRight() : _goLeft();
      return;
    }
    if (dragDistance.abs() > 40) {
      dragDistance < 0 ? _goRight() : _goLeft();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_config.enableSwipe) {
      return;
    }
    _dragDistance += details.delta.dx;
  }

  FeatureCarouselAnimationStyle get _resolvedAnimationStyle {
    if (!_config.cycleAnimationStyles) {
      return _config.animationStyle;
    }
    return FeatureCarouselAnimationStyle
        .values[_animationIndex % FeatureCarouselAnimationStyle.values.length];
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    final direction = _direction == _CarouselDirection.right ? 1 : -1;
    final curve = CurvedAnimation(parent: animation, curve: _theme.transitionCurve);
    switch (_resolvedAnimationStyle) {
      case FeatureCarouselAnimationStyle.crossfadeScale:
        return FadeTransition(
          opacity: curve,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.985, end: 1).animate(curve),
            child: child,
          ),
        );
      case FeatureCarouselAnimationStyle.blurFade:
        return FadeTransition(
          opacity: curve,
          child: AnimatedBuilder(
            animation: curve,
            builder: (context, _) {
              final sigma = (1 - curve.value) * 4;
              return ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: child,
              );
            },
          ),
        );
      case FeatureCarouselAnimationStyle.rotateParallax:
        return FadeTransition(
          opacity: curve,
          child: Transform.translate(
            offset: Offset(12 * direction * (1 - curve.value), 6 * (1 - curve.value)),
            child: Transform.rotate(
              angle: (1 - curve.value) * (direction * 0.03),
              child: Transform.scale(
                scale: Tween<double>(begin: 0.985, end: 1).animate(curve).value,
                child: child,
              ),
            ),
          ),
        );
      case FeatureCarouselAnimationStyle.liftFade:
        return FadeTransition(
          opacity: curve,
          child: Transform.translate(
            offset: Offset(0, 12 * (1 - curve.value)),
            child: Transform.scale(
              scale: Tween<double>(begin: 0.99, end: 1).animate(curve).value,
              child: child,
            ),
          ),
        );
      case FeatureCarouselAnimationStyle.slideFade:
        final slide = Tween<Offset>(
          begin: Offset(0.05 * direction, 0),
          end: Offset.zero,
        ).animate(curve);
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: slide,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.985, end: 1).animate(curve),
              child: child,
            ),
          ),
        );
      case FeatureCarouselAnimationStyle.slideUpFade:
        return FadeTransition(
          opacity: curve,
          child: Transform.translate(
            offset: Offset(0, 14 * (1 - curve.value)),
            child: child,
          ),
        );
      case FeatureCarouselAnimationStyle.slideDownFade:
        return FadeTransition(
          opacity: curve,
          child: Transform.translate(
            offset: Offset(0, -14 * (1 - curve.value)),
            child: child,
          ),
        );
      case FeatureCarouselAnimationStyle.rotateFade:
        return FadeTransition(
          opacity: curve,
          child: Transform.rotate(
            angle: (1 - curve.value) * 0.04 * direction,
            child: child,
          ),
        );
      case FeatureCarouselAnimationStyle.zoomFade:
        return FadeTransition(
          opacity: curve,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1).animate(curve),
            child: child,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final width = widget.width ?? _theme.carouselWidth;
    final height = widget.height ?? _theme.carouselHeight;
    final cardWidth = _theme.cardWidth;
    final cardHeight = _theme.cardHeight;

    final titleStyle = TextStyle(
      fontSize: _theme.titleFontSize,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: _theme.titleColor,
    );

    final descriptionStyle = TextStyle(
      fontSize: _theme.descriptionFontSize,
      height: _theme.descriptionLineHeight,
      color: _theme.descriptionColor,
      fontWeight: FontWeight.w400,
    );

    final background = widget.backgroundBuilder?.call(context, _theme) ??
        Container(
          decoration: BoxDecoration(
            color: _theme.backgroundColor,
            gradient: RadialGradient(
              colors: [_theme.vignetteInnerColor, _theme.vignetteOuterColor],
              radius: 0.9,
            ),
          ),
        );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.titleBuilder?.call(context, widget.items[_index], _index) ??
            (widget.items[_index].title != null
                ? Text(
                    widget.items[_index].title!,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink()),
        const SizedBox(height: 18),
        RepaintBoundary(
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _GhostCard(
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                  theme: _theme,
                  animation: _controller,
                  indexFromFront: 3,
                ),
                _GhostCard(
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                  theme: _theme,
                  animation: _controller,
                  indexFromFront: 2,
                ),
                _GhostCard(
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                  theme: _theme,
                  animation: _controller,
                  indexFromFront: 1,
                ),
                GestureDetector(
                  onHorizontalDragUpdate: _handleDragUpdate,
                  onHorizontalDragEnd: _handleDragEnd,
                  child: AnimatedSwitcher(
                    duration: _theme.transitionDuration,
                    switchInCurve: _theme.transitionCurve,
                    switchOutCurve: _theme.transitionCurve,
                    transitionBuilder: (child, animation) =>
                        _buildTransition(child, animation),
                    child: widget.cardBuilder?.call(
                          context,
                          widget.items[_index],
                          _index,
                          _theme,
                        ) ??
                        _CenterCard(
                      key: ValueKey(
                        '${_index}_${widget.items[_index].title ?? 'item'}',
                      ),
                          item: widget.items[_index],
                          width: cardWidth,
                          height: cardHeight,
                          theme: _theme,
                        ),
                  ),
                ),
                if (_config.showNavArrows)
                  Positioned(
                    left: 0,
                    child: _NavArrow(
                      direction: _CarouselDirection.left,
                      size: _theme.arrowSize,
                      radius: _theme.arrowRadius,
                      background: _theme.arrowBackground,
                      iconColor: _theme.arrowIconColor,
                      pressed: _leftPressed,
                      hovered: _leftHover,
                      onPressed: _goLeft,
                      onPressedChanged: (pressed) {
                        setState(() => _leftPressed = pressed);
                      },
                      onHoverChanged: (hovered) {
                        setState(() => _leftHover = hovered);
                      },
                    ),
                  ),
                if (_config.showNavArrows)
                  Positioned(
                    right: 0,
                    child: _NavArrow(
                      direction: _CarouselDirection.right,
                      size: _theme.arrowSize,
                      radius: _theme.arrowRadius,
                      background: _theme.arrowBackground,
                      iconColor: _theme.arrowIconColor,
                      pressed: _rightPressed,
                      hovered: _rightHover,
                      onPressed: _goRight,
                      onPressedChanged: (pressed) {
                        setState(() => _rightPressed = pressed);
                      },
                      onHoverChanged: (hovered) {
                        setState(() => _rightHover = hovered);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget.descriptionBuilder
                    ?.call(context, widget.items[_index], _index) ??
                (widget.items[_index].description != null
                    ? Text(
                        widget.items[_index].description!,
                        style: descriptionStyle,
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink()),
          ),
        ),
        if (_config.showCta) ...[
          const SizedBox(height: 18),
          widget.ctaBuilder?.call(
                context,
                widget.items[_index],
                _index,
                _handleCta,
              ) ??
              _CtaButton(
                label: _config.primaryActionLabel,
                theme: _theme,
                pressed: _ctaPressed,
                onPressed: _handleCta,
                onPressedChanged: (pressed) {
                  setState(() => _ctaPressed = pressed);
                },
              ),
        ],
      ],
    );

    final wrapped = Stack(
      alignment: Alignment.center,
      children: [background, content],
    );

    if (!_config.enableKeyboardNavigation) {
      return Semantics(
        label: 'Feature carousel',
        child: wrapped,
      );
    }

    return FocusableActionDetector(
      autofocus: false,
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowLeft):
            _CarouselIntent.left,
        LogicalKeySet(LogicalKeyboardKey.arrowRight):
            _CarouselIntent.right,
        LogicalKeySet(LogicalKeyboardKey.enter): _CarouselIntent.action,
        LogicalKeySet(LogicalKeyboardKey.space): _CarouselIntent.action,
      },
      actions: {
        _CarouselIntent: CallbackAction<_CarouselIntent>(
          onInvoke: (intent) {
            switch (intent.direction) {
              case _CarouselDirection.left:
                _goLeft();
              case _CarouselDirection.right:
                _goRight();
              case null:
                _handleCta();
            }
            return null;
          },
        ),
      },
      child: Semantics(
        label: 'Feature carousel',
        child: wrapped,
      ),
    );
  }
}

class _CarouselIntent extends Intent {
  const _CarouselIntent._(this.direction);
  final _CarouselDirection? direction;
  static const left = _CarouselIntent._(_CarouselDirection.left);
  static const right = _CarouselIntent._(_CarouselDirection.right);
  static const action = _CarouselIntent._(null);
}

class _GhostCard extends StatelessWidget {
  const _GhostCard({
    required this.cardWidth,
    required this.cardHeight,
    required this.theme,
    required this.animation,
    required this.indexFromFront,
  });

  final double cardWidth;
  final double cardHeight;
  final FeatureCarouselThemeData theme;
  final Animation<double> animation;
  final int indexFromFront;

  @override
  Widget build(BuildContext context) {
    final transform = _ghostTransform(indexFromFront);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = theme.transitionCurve.transform(animation.value);
        final opacityShift = (indexFromFront * 0.04) * (0.5 - t);
        return Opacity(
          opacity: (transform.opacity + opacityShift).clamp(0, 1),
          child: Transform.translate(
            offset: Offset(transform.dx, transform.dy),
            child: Transform.rotate(
              angle: transform.rotation,
              child: Transform.scale(
                scale: transform.scale,
                child: child,
              ),
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: theme.ghostFillColor,
          borderRadius: BorderRadius.circular(theme.ghostRadius),
          border: Border.all(
            color: theme.ghostBorderColor,
            width: 1,
          ),
        ),
      ),
    );
  }

  _GhostTransform _ghostTransform(int index) {
    switch (index) {
      case 1:
        return const _GhostTransform(
          dx: -28,
          dy: 6,
          rotation: -6 * math.pi / 180,
          scale: 0.98,
          opacity: 0.55,
        );
      case 2:
        return const _GhostTransform(
          dx: 22,
          dy: 10,
          rotation: 6 * math.pi / 180,
          scale: 0.96,
          opacity: 0.40,
        );
      default:
        return const _GhostTransform(
          dx: 0,
          dy: 14,
          rotation: 0,
          scale: 0.94,
          opacity: 0.28,
        );
    }
  }
}

class _GhostTransform {
  final double dx;
  final double dy;
  final double rotation;
  final double scale;
  final double opacity;

  const _GhostTransform({
    required this.dx,
    required this.dy,
    required this.rotation,
    required this.scale,
    required this.opacity,
  });
}

class _CenterCard extends StatelessWidget {
  const _CenterCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.theme,
  });

  final FeatureCarouselItem item;
  final double width;
  final double height;
  final FeatureCarouselThemeData theme;

  @override
  Widget build(BuildContext context) {
    final accent = item.accentColor ?? theme.accentColor;
    final iconSize = width * 0.28;
    final iconWidget = item.iconBuilder != null
        ? item.iconBuilder!(context, accent, iconSize)
        : (item.icon != null
            ? Icon(item.icon, size: iconSize, color: accent)
            : const SizedBox.shrink());

    return Semantics(
      label: 'Feature preview: ${item.title ?? 'item'}',
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.cardFillColor,
          borderRadius: BorderRadius.circular(theme.cardRadius),
          border: Border.all(color: theme.cardBorderColor, width: 1.2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x8C000000),
              blurRadius: 28,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: iconSize + 12,
                height: iconSize + 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.35),
                      blurRadius: 18,
                    ),
                  ],
                ),
              ),
              iconWidget,
            ],
          ),
        ),
      ),
    );
  }
}

class _NavArrow extends StatelessWidget {
  const _NavArrow({
    required this.direction,
    required this.size,
    required this.radius,
    required this.background,
    required this.iconColor,
    required this.pressed,
    required this.hovered,
    required this.onPressed,
    required this.onPressedChanged,
    required this.onHoverChanged,
  });

  final _CarouselDirection direction;
  final double size;
  final double radius;
  final Color background;
  final Color iconColor;
  final bool pressed;
  final bool hovered;
  final VoidCallback onPressed;
  final ValueChanged<bool> onPressedChanged;
  final ValueChanged<bool> onHoverChanged;

  @override
  Widget build(BuildContext context) {
    final icon = direction == _CarouselDirection.left
        ? Icons.chevron_left
        : Icons.chevron_right;

    return Semantics(
      button: true,
      label: direction == _CarouselDirection.left ? 'Previous' : 'Next',
      child: MouseRegion(
        onEnter: (_) => onHoverChanged(true),
        onExit: (_) => onHoverChanged(false),
        child: GestureDetector(
          onTap: onPressed,
          onTapDown: (_) => onPressedChanged(true),
          onTapUp: (_) => onPressedChanged(false),
          onTapCancel: () => onPressedChanged(false),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 90),
            scale: pressed ? 0.96 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: hovered
                    ? background.withValues(alpha: 0.16)
                    : background,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Icon(
                icon,
                color:
                    hovered ? iconColor.withValues(alpha: 0.75) : iconColor,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton({
    required this.label,
    required this.theme,
    required this.pressed,
    required this.onPressed,
    required this.onPressedChanged,
  });

  final String label;
  final FeatureCarouselThemeData theme;
  final bool pressed;
  final VoidCallback onPressed;
  final ValueChanged<bool> onPressedChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onPressed,
        onTapDown: (_) => onPressedChanged(true),
        onTapUp: (_) => onPressedChanged(false),
        onTapCancel: () => onPressedChanged(false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 90),
          scale: pressed ? 0.98 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            height: theme.ctaHeight,
            constraints: BoxConstraints(minWidth: theme.ctaMinWidth),
            padding: EdgeInsets.symmetric(horizontal: theme.ctaHorizontalPadding),
            decoration: BoxDecoration(
              color: theme.ctaBackground,
              borderRadius: BorderRadius.circular(theme.ctaHeight / 2),
              border: Border.all(color: theme.ctaBorderColor, width: 1),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.ctaTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
