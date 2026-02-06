part of '../../overflow_marquee.dart';

class _OverflowMarqueeState extends State<OverflowMarquee>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Duration elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
          this.elapsed = elapsed;
        });
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final compTheme = ComponentTheme.maybeOf<OverflowMarqueeTheme>(context);
    final direction = styleValue(
        widgetValue: widget.direction,
        themeValue: compTheme?.direction,
        defaultValue: Axis.horizontal);
    final fadePortion = styleValue(
        widgetValue: widget.fadePortion,
        themeValue: compTheme?.fadePortion,
        defaultValue: 25.0);
    final duration = styleValue(
        widgetValue: widget.duration,
        themeValue: compTheme?.duration,
        defaultValue: const Duration(seconds: 1));
    final delayDuration = styleValue(
        widgetValue: widget.delayDuration,
        themeValue: compTheme?.delayDuration,
        defaultValue: const Duration(milliseconds: 500));
    final step = styleValue(
        widgetValue: widget.step,
        themeValue: compTheme?.step,
        defaultValue: 100.0);
    final curve = widget.curve ?? compTheme?.curve ?? Curves.linear;
    return ClipRect(
      child: _OverflowMarqueeLayout(
        direction: direction,
        fadePortion: fadePortion,
        duration: duration,
        delayDuration: delayDuration,
        ticker: _ticker,
        elapsed: elapsed,
        step: step,
        textDirection: textDirection,
        curve: curve,
        child: widget.child,
      ),
    );
  }
}
