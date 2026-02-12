part of '../../formatter.dart';

/// _ToUpperCaseTextFormatter represents a form-related type in the registry.
class _ToUpperCaseTextFormatter extends TextInputFormatter {
  const _ToUpperCaseTextFormatter();
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
