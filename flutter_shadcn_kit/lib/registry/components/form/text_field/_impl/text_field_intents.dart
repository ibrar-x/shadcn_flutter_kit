part of '../text_field.dart';

/// Intent to append text to the current text field content.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// append text to a text field.
class TextFieldAppendTextIntent extends Intent {
  /// Creates a [TextFieldAppendTextIntent] with the text to append.
  const TextFieldAppendTextIntent({required this.text});

  /// The text to append to the current content.
  final String text;
}

/// Intent to clear all text from the text field.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// clear text field content.
class TextFieldClearIntent extends Intent {
  /// Creates a [TextFieldClearIntent].
  const TextFieldClearIntent();
}

/// Intent to replace the current word in the text field.
///
/// Replaces the word at the current cursor position with new text.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldReplaceCurrentWordIntent extends Intent {
  /// Creates a [TextFieldReplaceCurrentWordIntent] with replacement text.
  const TextFieldReplaceCurrentWordIntent({required this.text});

  /// The text to replace the current word with.
  final String text;
}

/// Intent to set the entire text field content to a specific value.
///
/// Replaces all existing text with the provided text.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldSetTextIntent extends Intent {
  /// Creates a [TextFieldSetTextIntent] with the new text.
  const TextFieldSetTextIntent({required this.text});

  /// The text to set as the field's content.
  final String text;
}

/// Intent to set the text selection in the text field.
///
/// Used with Flutter's Actions/Shortcuts system to programmatically
/// control cursor position and text selection.
class TextFieldSetSelectionIntent extends Intent {
  /// The text selection to apply.
  final TextSelection selection;

  /// Creates a [TextFieldSetSelectionIntent] with the selection.
  const TextFieldSetSelectionIntent({required this.selection});
}

/// Intent to select all text in the field and copy it to clipboard.
///
/// Combines selection and copy operations in a single intent.
/// Used with Flutter's Actions/Shortcuts system.
class TextFieldSelectAllAndCopyIntent extends Intent {
  /// Creates a [TextFieldSelectAllAndCopyIntent].
  const TextFieldSelectAllAndCopyIntent();
}
