part of '../../formatted_input.dart';

/// A part that displays static, non-editable text.
class StaticPart extends InputPart {
  /// The static text to display.
  final String text;

  /// Creates a [StaticPart] with the specified static text.
  ///
  /// Parameters:
  /// - [text] (`String`, required): The immutable text content to display.
  ///
  /// Example:
  /// ```dart
  /// const StaticPart('/')
  /// ```
  const StaticPart(this.text);

  @override
  Widget build(BuildContext context, FormattedInputData data) {
    return _StaticPartWidget(text: text);
  }

  @override
  String get partKey => text;

  @override
  String toString() {
    return 'StaticPart{text: $text}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StaticPart && other.text == text;
  }

  @override
  int get hashCode => text.hashCode;
}
