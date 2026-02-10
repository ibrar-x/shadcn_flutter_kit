part of '../../text_animate.dart';

class _StreamingTextSnapshot {
  const _StreamingTextSnapshot({
    required this.fullText,
    required this.stablePrefixChars,
    required this.animatedChars,
    required this.changedAt,
    required this.revision,
  });

  factory _StreamingTextSnapshot.initial(String text) {
    return _StreamingTextSnapshot(
      fullText: text,
      stablePrefixChars: const <String>[],
      animatedChars: _splitToCharacters(text),
      changedAt: Duration.zero,
      revision: 0,
    );
  }

  final String fullText;
  final List<String> stablePrefixChars;
  final List<String> animatedChars;
  final Duration changedAt;
  final int revision;

  _StreamingTextSnapshot update({
    required String nextText,
    required Duration now,
  }) {
    final previousChars = _splitToCharacters(fullText);
    final nextChars = _splitToCharacters(nextText);

    final minLength = math.min(previousChars.length, nextChars.length);
    var prefixLength = 0;
    while (prefixLength < minLength &&
        previousChars[prefixLength] == nextChars[prefixLength]) {
      prefixLength += 1;
    }

    return _StreamingTextSnapshot(
      fullText: nextText,
      stablePrefixChars: List<String>.unmodifiable(
        nextChars.take(prefixLength),
      ),
      animatedChars: List<String>.unmodifiable(nextChars.skip(prefixLength)),
      changedAt: now,
      revision: revision + 1,
    );
  }
}

List<String> _splitToCharacters(String value) {
  if (value.isEmpty) return const <String>[];
  return List<String>.unmodifiable(
    value.runes.map((rune) => String.fromCharCode(rune)),
  );
}

List<String> _splitToWordUnits(String value) {
  if (value.isEmpty) return const <String>[];
  final matches = RegExp(r'\S+\s*|\s+').allMatches(value);
  return List<String>.unmodifiable([
    for (final match in matches)
      if ((match.group(0) ?? '').isNotEmpty) match.group(0)!,
  ]);
}
