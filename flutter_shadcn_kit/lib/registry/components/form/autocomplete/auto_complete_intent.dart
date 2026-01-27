part of 'autocomplete.dart';

class AutoCompleteIntent extends Intent {
  final String suggestion;
  final AutoCompleteMode mode;

  const AutoCompleteIntent(this.suggestion, this.mode);
}
