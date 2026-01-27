import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/style_value.dart';
import '../themes/scrollbar_theme.dart';
import '../core/shadcn_scrollbar.dart';

const double _kScrollbarMinLength = 48.0;

class ShadcnScrollbarState extends RawScrollbarState<ShadcnScrollbar> {
  late AnimationController _hoverAnimationController;
  bool _hoverIsActive = false;
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  @override
  bool get enableGestures => widget.interactive ?? true;

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hoverAnimationController.addListener(() {
      updateScrollbarPainter();
    });
  }

  @override
  void updateScrollbarPainter() {
    final compTheme = ComponentTheme.maybeOf<ScrollbarTheme>(context);
    scrollbarPainter
      ..color = styleValue(
          widgetValue: widget.color,
          themeValue: compTheme?.color,
          defaultValue: _theme.colorScheme.border)
      ..textDirection = Directionality.of(context)
      ..thickness = styleValue(
          widgetValue: widget.thickness,
          themeValue: compTheme?.thickness,
          defaultValue: 7.0 * _theme.scaling)
      ..radius = styleValue(
          widgetValue: widget.radius,
          themeValue: compTheme?.radius,
          defaultValue: Radius.circular(_theme.radiusSm))
      ..minLength = _kScrollbarMinLength
      ..padding = MediaQuery.paddingOf(context) + EdgeInsets.all(_theme.scaling)
      ..scrollbarOrientation = widget.scrollbarOrientation
      ..ignorePointer = !enableGestures;
  }

  @override
  void handleHover(PointerHoverEvent event) {
    if (isPointerOverScrollbar(event.position, event.kind, forHover: true)) {
      setState(() {
        _hoverIsActive = true;
      });
      _hoverAnimationController.forward();
    } else if (_hoverIsActive) {
      setState(() {
        _hoverIsActive = false;
      });
      _hoverAnimationController.reverse();
    }
    super.handleHover(event);
  }

  @override
  void handleHoverExit(PointerExitEvent event) {
    super.handleHoverExit(event);
    setState(() {
      _hoverIsActive = false;
    });
    _hoverAnimationController.reverse();
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    super.dispose();
  }
}
