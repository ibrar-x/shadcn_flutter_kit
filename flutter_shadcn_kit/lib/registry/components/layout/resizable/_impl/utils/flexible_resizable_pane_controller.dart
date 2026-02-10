part of '../../resizable.dart';

class FlexibleResizablePaneController extends ChangeNotifier
    with ResizablePaneController {
  double _flex;
  bool _collapsed = false;

  /// Creates a [FlexibleResizablePaneController].
  ///
  /// Parameters:
  /// - [_flex] (`double`, required): Initial flex factor.
  /// - [collapsed] (`bool`, default: `false`): Initial collapsed state.
  FlexibleResizablePaneController(this._flex, {bool collapsed = false})
    : _collapsed = collapsed;

  @override
  double get value => _flex;

  @override
  bool get collapsed => _collapsed;

  set flex(double value) {
    _flex = value;
    notifyListeners();
  }

  @override
  void collapse() {
    _collapsed = true;
    notifyListeners();
  }

  @override
  void expand() {
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
    _flex = newSize.clamp(minSize ?? 0, maxSize ?? double.infinity) / paneSize;
    notifyListeners();
  }

  @override
  double computeSize(double paneSize, {double? minSize, double? maxSize}) {
    return (_flex * paneSize).clamp(minSize ?? 0, maxSize ?? double.infinity);
  }
}
