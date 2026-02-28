part of '../../autocomplete.dart';

/// AutoCompleteIntent represents a form-related type in the registry.
class AutoCompleteIntent extends Intent {
  /// Field storing `suggestion` for this form implementation.
  final String suggestion;

  /// Field storing `mode` for this form implementation.
  final AutoCompleteMode mode;

  const AutoCompleteIntent(this.suggestion, this.mode);
}
