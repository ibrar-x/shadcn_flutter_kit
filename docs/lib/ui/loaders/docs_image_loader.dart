import 'package:flutter/material.dart';

enum DocsImageLoaderAnimation {
  frame,
  layered,
  combo,
}

class DocsImageLoader extends StatefulWidget {
  const DocsImageLoader({
    super.key,
    this.animation = DocsImageLoaderAnimation.combo,
    this.frameDuration = const Duration(milliseconds: 70),
    this.layeredDuration = const Duration(milliseconds: 2600),
    this.size = 220,
    this.borderRadius = 16,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.frameAssets = defaultFrameAssets,
    this.layeredAssets = defaultLayeredAssets,
  });

  final DocsImageLoaderAnimation animation;
  final Duration frameDuration;
  final Duration layeredDuration;
  final double size;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxFit fit;
  final List<String> frameAssets;
  final List<String> layeredAssets;

  static const List<String> defaultFrameAssets = [
    'assets/docs_images/accordion.png',
    'assets/docs_images/alert.png',
    'assets/docs_images/alert_dialog.png',
    'assets/docs_images/animatedvaluebuilder.png',
    'assets/docs_images/avatar.png',
    'assets/docs_images/avatar_group.png',
    'assets/docs_images/badge.png',
    'assets/docs_images/breadcrumb.png',
    'assets/docs_images/button.png',
    'assets/docs_images/calendar.png',
    'assets/docs_images/card.png',
    'assets/docs_images/carousel.png',
    'assets/docs_images/checkbox.png',
    'assets/docs_images/chip_input.png',
    'assets/docs_images/circular_progress.png',
    'assets/docs_images/codesnippet.png',
    'assets/docs_images/collapsible.png',
    'assets/docs_images/colorpicker.png',
    'assets/docs_images/command.png',
    'assets/docs_images/context_menu.png',
    'assets/docs_images/datepicker.png',
    'assets/docs_images/dialog.png',
    'assets/docs_images/divider.png',
    'assets/docs_images/drawer.png',
    'assets/docs_images/dropdown_menu.png',
    'assets/docs_images/form.png',
    'assets/docs_images/hover_card.png',
    'assets/docs_images/input.png',
    'assets/docs_images/inputotp.png',
    'assets/docs_images/menubar.png',
    'assets/docs_images/navigation_menu.png',
    'assets/docs_images/number_ticker.png',
    'assets/docs_images/pagination.png',
    'assets/docs_images/phone_input.png',
    'assets/docs_images/popover.png',
    'assets/docs_images/progress.png',
    'assets/docs_images/radiogroup.png',
    'assets/docs_images/repeatedanimationbuilder.png',
    'assets/docs_images/resizable.png',
    'assets/docs_images/select.png',
    'assets/docs_images/sheet.png',
    'assets/docs_images/skeleton.png',
    'assets/docs_images/slider.png',
    'assets/docs_images/star_rating.png',
    'assets/docs_images/stepper.png',
    'assets/docs_images/steps.png',
    'assets/docs_images/switch.png',
    'assets/docs_images/tablist.png',
    'assets/docs_images/tabs.png',
    'assets/docs_images/textarea.png',
    'assets/docs_images/time_picker.png',
    'assets/docs_images/timeline.png',
    'assets/docs_images/toast.png',
    'assets/docs_images/toggle.png',
    'assets/docs_images/tooltip.png',
    'assets/docs_images/tracker.png',
    'assets/docs_images/tree.png',
  ];

  static const List<String> defaultLayeredAssets = [
    'assets/docs_images/command.png',
    'assets/docs_images/hover_card.png',
    'assets/docs_images/popover.png',
  ];

  @override
  State<DocsImageLoader> createState() => _DocsImageLoaderState();
}

class _DocsImageLoaderState extends State<DocsImageLoader>
    with TickerProviderStateMixin {
  AnimationController? _frameController;
  AnimationController? _layeredController;

  bool get _showFrame =>
      widget.animation == DocsImageLoaderAnimation.frame ||
      widget.animation == DocsImageLoaderAnimation.combo;

  bool get _showLayered =>
      widget.animation == DocsImageLoaderAnimation.layered ||
      widget.animation == DocsImageLoaderAnimation.combo;

  @override
  void initState() {
    super.initState();
    _setupControllers();
  }

  @override
  void didUpdateWidget(DocsImageLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animation != widget.animation ||
        oldWidget.frameDuration != widget.frameDuration ||
        oldWidget.layeredDuration != widget.layeredDuration ||
        oldWidget.frameAssets != widget.frameAssets ||
        oldWidget.layeredAssets != widget.layeredAssets) {
      _disposeControllers();
      _setupControllers();
    }
  }

  void _setupControllers() {
    if (_showFrame && widget.frameAssets.isNotEmpty) {
      _frameController = AnimationController(
        vsync: this,
        duration: widget.frameDuration * widget.frameAssets.length,
      )..repeat();
    }
    if (_showLayered && widget.layeredAssets.isNotEmpty) {
      _layeredController = AnimationController(
        vsync: this,
        duration: widget.layeredDuration,
      )..repeat();
    }
  }

  void _disposeControllers() {
    _frameController?.dispose();
    _frameController = null;
    _layeredController?.dispose();
    _layeredController = null;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = SizedBox(
      width: widget.size,
      height: widget.size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_showFrame) _buildFrameSequence(),
              if (_showLayered) _buildLayeredStack(),
            ],
          ),
        ),
      ),
    );

    return RepaintBoundary(child: base);
  }

  Widget _buildFrameSequence() {
    final controller = _frameController;
    if (controller == null || widget.frameAssets.isEmpty) {
      return const SizedBox.shrink();
    }
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final index = (controller.value * widget.frameAssets.length)
            .floor()
            .clamp(0, widget.frameAssets.length - 1);
        return Image.asset(
          widget.frameAssets[index],
          fit: widget.fit,
          gaplessPlayback: true,
        );
      },
    );
  }

  Widget _buildLayeredStack() {
    final controller = _layeredController;
    if (controller == null || widget.layeredAssets.isEmpty) {
      return const SizedBox.shrink();
    }

    final layers = <Widget>[];
    final count = widget.layeredAssets.length.clamp(1, 4);
    for (var i = 0; i < count; i += 1) {
      final start = i * (1 / count);
      final end = (i + 1) * (1 / count);
      layers.add(_buildLayer(controller, widget.layeredAssets[i], start, end));
    }

    return Stack(children: layers);
  }

  Widget _buildLayer(
    AnimationController controller,
    String asset,
    double start,
    double end,
  ) {
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeInOut),
    );
    final opacity = Tween<double>(begin: 0, end: 0.9).animate(curve);
    final scale = Tween<double>(begin: 0.96, end: 1.02).animate(curve);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.scale(
            scale: scale.value,
            child: child,
          ),
        );
      },
      child: Image.asset(
        asset,
        fit: widget.fit,
        gaplessPlayback: true,
      ),
    );
  }
}
