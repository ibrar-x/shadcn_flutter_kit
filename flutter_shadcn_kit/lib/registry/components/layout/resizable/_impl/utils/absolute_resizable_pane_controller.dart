part of '../../resizable.dart';

class AbsoluteResizablePaneController extends ChangeNotifier
    with ResizablePaneController {
  double _size;
  bool _collapsed = false;

  _ResizablePaneState? _state;

  @override
  _ResizablePaneState? get _paneState => _state;

  @override
  set _paneState(_ResizablePaneState? value) {
    _state = value;
  }

  /// Creates an [AbsoluteResizablePaneController].
  ///
  /// Parameters:
  /// - [_size] (`double`, required): Initial absolute size in pixels.
  /// - [collapsed] (`bool`, default: `false`): Initial collapsed state.
  AbsoluteResizablePaneController(this._size, {bool collapsed = false})
    : _collapsed = collapsed;

  @override
  double get value => _size;

  @override
  bool get collapsed => _collapsed;

  set size(double value) {
    _size = value;
    notifyListeners();
  }

  @override
  void collapse() {
    if (_collapsed) return;
    _collapsed = true;
    notifyListeners();
  }

  @override
  void expand() {
    if (!_collapsed) return;
    _collapsed = false;
    notifyListeners();
  }

  @override
  void resize(
    double newSize,
    double paneSize, {
    double? minSize,
    double? maxSize,
  }) {
    _size = newSize.clamp(minSize ?? 0, maxSize ?? double.infinity);
    notifyListeners();
  }

  @override
  double computeSize(double paneSize, {double? minSize, double? maxSize}) {
    return _size.clamp(minSize ?? 0, maxSize ?? double.infinity);
  }
}
