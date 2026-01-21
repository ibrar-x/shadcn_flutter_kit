typedef ReplacementInfo = (int start, String newText);

/// Replaces the word at the caret position with a new string.
ReplacementInfo replaceWordAtCaret(
  String text,
  int caret,
  String replacement,
  bool Function(String char) isSeparator,
) {
  if (caret < 0 || caret > text.length) {
    throw RangeError('Caret position is out of bounds.');
  }

  int start = caret;
  while (start > 0 && !isSeparator(text[start - 1])) {
    start--;
  }

  int end = caret;
  while (end < text.length && !isSeparator(text[end])) {
    end++;
  }

  String newText = text.replaceRange(start, end, replacement);
  return (start, newText);
}
