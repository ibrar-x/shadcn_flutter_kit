part of '../drawer.dart';

class SheetWrapper extends DrawerWrapper {
  /// Creates a [SheetWrapper].
  const SheetWrapper({
    super.key,
    required super.position,
    required super.child,
    required super.size,
    required super.stackIndex,
    super.draggable = false,
    super.expands = false,
    super.extraSize = Size.zero,
    super.padding,
    super.surfaceBlur,
    super.surfaceOpacity,
    super.barrierColor,
    super.gapBeforeDragger,
    super.gapAfterDragger,
    super.constraints,
    super.alignment,
  });

  @override
  State<DrawerWrapper> createState() => _SheetWrapperState();
}

class _SheetWrapperState extends _DrawerWrapperState {
  @override
  Border getBorder(ThemeData theme) {
    switch (resolvedPosition) {
      case OverlayPosition.left:
        return Border(right: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.right:
        return Border(left: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.top:
        return Border(bottom: BorderSide(color: theme.colorScheme.border));
      case OverlayPosition.bottom:
        return Border(top: BorderSide(color: theme.colorScheme.border));
      default:
        throw UnimplementedError('Unknown position');
    }
  }

  @override
  EdgeInsets buildMargin(BuildContext context) {
    var mediaPadding = MediaQuery.paddingOf(context);
    double marginTop = 0;
    double marginBottom = 0;
    double marginLeft = 0;
    double marginRight = 0;
    switch (resolvedPosition) {
      case OverlayPosition.left:
        marginRight = mediaPadding.right;
        break;
      case OverlayPosition.right:
        marginLeft = mediaPadding.left;
        break;
      case OverlayPosition.top:
        marginBottom = mediaPadding.bottom;
        break;
      case OverlayPosition.bottom:
        marginTop = mediaPadding.top;
        break;
      default:
        throw UnimplementedError('Unknown position');
    }
    return super.buildMargin(context) +
        EdgeInsets.only(
          top: marginTop,
          bottom: marginBottom,
          left: marginLeft,
          right: marginRight,
        );
  }

  @override
  Widget buildChild(BuildContext context) {
    var mediaPadding = MediaQuery.paddingOf(context);
    double paddingTop = 0;
    double paddingBottom = 0;
    double paddingLeft = 0;
    double paddingRight = 0;
    switch (resolvedPosition) {
      case OverlayPosition.left:
        paddingTop = mediaPadding.top;
        paddingBottom = mediaPadding.bottom;
        paddingLeft = mediaPadding.left;
        break;
      case OverlayPosition.right:
        paddingTop = mediaPadding.top;
        paddingBottom = mediaPadding.bottom;
        paddingRight = mediaPadding.right;
        break;
      case OverlayPosition.top:
        paddingLeft = mediaPadding.left;
        paddingRight = mediaPadding.right;
        paddingTop = mediaPadding.top;
        break;
      case OverlayPosition.bottom:
        paddingLeft = mediaPadding.left;
        paddingRight = mediaPadding.right;
        paddingBottom = mediaPadding.bottom;
        break;
      default:
        throw UnimplementedError('Unknown position');
    }
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: super.buildChild(context),
    );
  }

  @override
  BorderRadiusGeometry getBorderRadius(double radius) {
    return BorderRadius.zero;
  }

  @override
  BoxDecoration getDecoration(ThemeData theme) {
    var backgroundColor = theme.colorScheme.background;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    if (surfaceOpacity != null && surfaceOpacity < 1) {
      if (widget.stackIndex == 0) {
        // the top sheet should have a higher opacity to prevent
        // visual bleeding from the main content
        surfaceOpacity = surfaceOpacity * 1.25;
      }
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    return BoxDecoration(
      color: backgroundColor,
      border: getBorder(theme),
    );
  }
}

/// Position for overlay components like drawers and sheets.
