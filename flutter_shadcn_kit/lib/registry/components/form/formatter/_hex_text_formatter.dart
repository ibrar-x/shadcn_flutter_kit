part of 'formatter.dart';

class _HexTextFormatter extends TextInputFormatter {
  final bool hashPrefix;
  const _HexTextFormatter({this.hashPrefix = false});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if (hashPrefix) {
      if (!newText.startsWith('#')) {
        newText = '#$newText';
      }
    } else {
      if (newText.startsWith('#')) {
        newText = newText.substring(1);
      }
    }
    // make sure all characters are valid hex characters
    final hexRegExp =
        hashPrefix ? RegExp(r'^#?[0-9a-fA-F]*$') : RegExp(r'^[0-9a-fA-F]*$');
    if (!hexRegExp.hasMatch(newText)) {
      return oldValue;
    }
    var selection = contraintToNewText(newValue, newText);
    // make sure selection is after the hash if hashPrefix is true
    if (hashPrefix) {
      if (selection.baseOffset == 0) {
        selection = selection.copyWith(baseOffset: 1);
      }
      if (selection.extentOffset == 0) {
        selection = selection.copyWith(extentOffset: 1);
      }
    }
    return TextEditingValue(
      text: newText,
      selection: selection,
    );
  }
}
