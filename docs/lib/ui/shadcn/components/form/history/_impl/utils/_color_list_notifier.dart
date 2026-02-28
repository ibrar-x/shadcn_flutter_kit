part of '../../history.dart';

/// _ColorListNotifier represents a form-related type in the registry.
class _ColorListNotifier extends ChangeNotifier {
  /// Field storing `_recentColors` for this form implementation.
  List<Color> _recentColors;

  _ColorListNotifier(this._recentColors);

  /// Performs `_notify` logic for this form component.
  void _notify() {
    notifyListeners();
  }
}
