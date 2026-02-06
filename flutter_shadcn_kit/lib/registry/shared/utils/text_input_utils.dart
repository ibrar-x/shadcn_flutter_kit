import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'util.dart';

/// Intent for clearing a text field.
class TextFieldClearIntent extends Intent {
  /// Creates a [TextFieldClearIntent].
  const TextFieldClearIntent();
}

typedef ReplacementInfo = (int start, String newText);
typedef WordInfo = (int start, String word);

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

/// Gets the word at the caret position in a text string.
WordInfo getWordAtCaret(String text, int caret, [String separator = ' ']) {
  if (caret < 0 || caret > text.length) {
    throw RangeError('Caret position is out of bounds.');
  }

  // Find the start of the word
  int start = caret;
  while (start > 0 && !separator.contains(text[start - 1])) {
    start--;
  }

  // Find the end of the word
  int end = caret;
  while (end < text.length && !separator.contains(text[end])) {
    end++;
  }

  // Return the start index and the word at the caret position
  String word = text.substring(start, end);
  return (start, word);
}

/// Extension on TextEditingController.
extension TextEditingControllerExtension on TextEditingController {
  /// Gets the word at the current cursor position.
  String? get currentWord {
    final value = this.value;
    final text = value.text;
    final selection = value.selection;
    if (text.isEmpty) {
      return null;
    }
    if (selection.isCollapsed) {
      return getWordAtCaret(text, selection.baseOffset).$2;
    }
    return null;
  }
}

/// Extension on TextEditingValue.
extension TextEditingValueExtension on TextEditingValue {
  /// Replaces the text while preserving selection within bounds.
  TextEditingValue replaceText(String newText) {
    var selection = this.selection;
    selection = selection.copyWith(
      baseOffset: selection.baseOffset.clamp(0, newText.length),
      extentOffset: selection.extentOffset.clamp(0, newText.length),
    );
    return TextEditingValue(
      text: newText,
      selection: selection,
    );
  }
}

/// Clears the currently active text input field.
void clearActiveTextInput() {
  TextFieldClearIntent intent = const TextFieldClearIntent();
  invokeActionOnFocusedWidget(intent);
}
