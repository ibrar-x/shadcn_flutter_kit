part of 'autocomplete.dart';

/// Intent for navigating autocomplete suggestions via keyboard.
class NavigateSuggestionIntent extends Intent {
  /// Direction of navigation through suggestions.
  final int direction;

  const NavigateSuggestionIntent(this.direction);
}
