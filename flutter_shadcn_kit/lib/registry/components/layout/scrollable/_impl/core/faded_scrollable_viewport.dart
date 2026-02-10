part of '../../scrollable.dart';

/// A viewport wrapper that fades content near the leading/trailing edges.
class FadedScrollableViewport extends StatefulWidget {
  final Widget child;
  final double fadeExtent;
  final double fadeSize;

  const FadedScrollableViewport({
    super.key,
    this.fadeExtent = 20.0,
    this.fadeSize = 50.0,
    required this.child,
  });

  @override
  State<FadedScrollableViewport> createState() =>
      _FadedScrollableViewportState();
}

class _FadedScrollableViewportState extends State<FadedScrollableViewport> {
  double _scrollOffset = 0.0;
  double _scrollExtent = 0.0;
  Axis _scrollAxis = Axis.vertical;

  double get _startFadeFraction {
    if (_scrollExtent <= 0) {
      return 0.0;
    }
    return (_scrollOffset / widget.fadeExtent).clamp(0.0, 1.0);
  }

  double get _endFadeFraction {
    if (_scrollExtent <= 0) {
      return 0.0;
    }
    return ((_scrollExtent - _scrollOffset) / widget.fadeExtent).clamp(
      0.0,
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        setState(() {
          _scrollOffset = notification.metrics.pixels;
          _scrollExtent = notification.metrics.maxScrollExtent;
          _scrollAxis = notification.metrics.axis;
        });
        return false;
      },
      child: ShaderMask(
        shaderCallback: (bounds) {
          final transparent = const Color(0x00000000);
          final black = const Color(0xFF000000);
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [transparent, black, black, transparent],
            stops: [
              0.0,
              _startFadeFraction *
                  (_scrollAxis == Axis.vertical
                      ? widget.fadeSize / bounds.height
                      : widget.fadeSize / bounds.width),
              1.0 -
                  _endFadeFraction *
                      (_scrollAxis == Axis.vertical
                          ? widget.fadeSize / bounds.height
                          : widget.fadeSize / bounds.width),
              1.0,
            ],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: widget.child,
      ),
    );
  }
}
