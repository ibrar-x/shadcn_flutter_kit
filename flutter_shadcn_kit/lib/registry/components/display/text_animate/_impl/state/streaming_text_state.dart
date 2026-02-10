part of '../../text_animate.dart';

class _StreamingTextState extends State<StreamingText> {
  static const Duration _frameInterval = Duration(milliseconds: 16);

  late final Stopwatch _clock;
  late _StreamingTextSnapshot _snapshot;
  Timer? _ticker;
  int _lastSettledRevision = -1;

  @override
  void initState() {
    super.initState();
    _clock = Stopwatch()..start();
    _snapshot = _StreamingTextSnapshot.initial(widget.text);
  }

  @override
  void didUpdateWidget(covariant StreamingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _snapshot = _snapshot.update(nextText: widget.text, now: _clock.elapsed);
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _clock.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<TextAnimateTheme>(context);
    final resolvedStyle = DefaultTextStyle.of(context).style.merge(
      styleValue(
        widgetValue: widget.style,
        themeValue: compTheme?.style,
        defaultValue: const TextStyle(),
      ),
    );
    final resolvedTypewriter = styleValue(
      widgetValue: widget.typewriter,
      themeValue: compTheme?.typewriter,
      defaultValue: const TypewriterEffect(),
    );
    final resolvedEffect = styleValue<StreamingTextEffectAdapter>(
      widgetValue: widget.effect,
      themeValue: compTheme?.effect,
      defaultValue: const NoEffect(),
    );
    final resolvedCursor = styleValue(
      widgetValue: widget.cursor,
      themeValue: compTheme?.cursor,
      defaultValue: const StreamingCursor.none(),
    );

    final elapsed = _clock.elapsed - _snapshot.changedAt;
    final animatedUnits = widget.animateByWord
        ? _splitToWordUnits(_snapshot.animatedChars.join())
        : _snapshot.animatedChars;
    final totalAnimated = animatedUnits.length;
    final visibleAnimated = _visibleUnitCount(
      total: totalAnimated,
      elapsed: elapsed,
      typewriter: resolvedTypewriter,
    );

    final spans = <InlineSpan>[];
    if (_snapshot.stablePrefixChars.isNotEmpty) {
      spans.add(
        TextSpan(
          text: _snapshot.stablePrefixChars.join(),
          style: resolvedStyle,
        ),
      );
    }

    for (var i = 0; i < visibleAnimated; i++) {
      final char = animatedUnits[i];
      final revealDelay = _revealDelayForUnitIndex(i, resolvedTypewriter);
      final age = elapsed > revealDelay ? elapsed - revealDelay : Duration.zero;
      spans.add(
        resolvedEffect.buildSpan(
          char: char,
          index: i,
          age: age,
          baseStyle: resolvedStyle,
        ),
      );
    }

    final settled = _isSettled(
      elapsed: elapsed,
      totalAnimated: totalAnimated,
      visibleAnimated: visibleAnimated,
      typewriter: resolvedTypewriter,
      effect: resolvedEffect,
    );

    if (_shouldShowCursor(cursor: resolvedCursor, settled: settled)) {
      spans.add(
        _buildCursorSpan(cursor: resolvedCursor, baseStyle: resolvedStyle),
      );
    }

    _syncTicker(
      settled: settled,
      cursor: resolvedCursor,
      totalAnimated: totalAnimated,
      visibleAnimated: visibleAnimated,
      effect: resolvedEffect,
    );
    _notifyOnSettledIfNeeded(settled);

    return RichText(
      text: TextSpan(style: resolvedStyle, children: spans),
      textAlign: widget.textAlign ?? TextAlign.start,
      textDirection: widget.textDirection,
      softWrap: widget.softWrap ?? true,
      overflow: widget.overflow ?? TextOverflow.clip,
      maxLines: widget.maxLines,
      textWidthBasis: widget.textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: widget.textHeightBehavior,
      locale: widget.locale,
    );
  }

  bool _isSettled({
    required Duration elapsed,
    required int totalAnimated,
    required int visibleAnimated,
    required TypewriterEffect typewriter,
    required StreamingTextEffectAdapter effect,
  }) {
    if (totalAnimated == 0) return true;
    if (visibleAnimated < totalAnimated) return false;
    if (effect.settleDuration <= Duration.zero) return true;

    final revealDelay = _revealDelayForUnitIndex(totalAnimated - 1, typewriter);
    final age = elapsed > revealDelay ? elapsed - revealDelay : Duration.zero;
    return age >= effect.settleDuration;
  }

  bool _shouldShowCursor({
    required StreamingCursor cursor,
    required bool settled,
  }) {
    if (!cursor.enabled) return false;
    if (settled && !cursor.showWhenSettled) return false;
    if (!cursor.blink) return true;

    final periodMicros = cursor.blinkPeriod.inMicroseconds;
    if (periodMicros <= 0) return true;
    final phase = _clock.elapsed.inMicroseconds % periodMicros;
    return phase < (periodMicros ~/ 2);
  }

  void _syncTicker({
    required bool settled,
    required StreamingCursor cursor,
    required int totalAnimated,
    required int visibleAnimated,
    required StreamingTextEffectAdapter effect,
  }) {
    final shouldTick =
        visibleAnimated < totalAnimated ||
        (!settled &&
            totalAnimated > 0 &&
            effect.settleDuration > Duration.zero) ||
        (cursor.enabled &&
            cursor.blink &&
            (!settled || cursor.showWhenSettled));

    if (shouldTick) {
      _ticker ??= Timer.periodic(_frameInterval, (_) {
        if (!mounted) {
          _ticker?.cancel();
          _ticker = null;
          return;
        }
        setState(() {});
      });
      return;
    }

    _ticker?.cancel();
    _ticker = null;
  }

  void _notifyOnSettledIfNeeded(bool settled) {
    final callback = widget.onSettled;
    if (!settled || callback == null) return;
    if (_lastSettledRevision == _snapshot.revision) return;

    _lastSettledRevision = _snapshot.revision;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      callback(_snapshot.fullText);
    });
  }
}
