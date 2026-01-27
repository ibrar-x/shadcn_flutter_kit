part of 'history.dart';

class _ColorListNotifier extends ChangeNotifier {
  List<Color> _recentColors;

  _ColorListNotifier(this._recentColors);

  void _notify() {
    notifyListeners();
  }
}
