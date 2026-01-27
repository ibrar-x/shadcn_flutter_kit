part of '../../util.dart';

class ConvertedController<F, T> extends ChangeNotifier
    implements ComponentController<T> {
  final ValueNotifier<F> _other;
  final BiDirectionalConvert<F, T> _convert;

  T _value;
  bool _isUpdating = false;

  /// Creates a [ConvertedController].
  ConvertedController(ValueNotifier<F> other, BiDirectionalConvert<F, T> convert)
      : _other = other,
        _convert = convert,
        _value = convert.convertA(other.value) {
    _other.addListener(_onOtherValueChanged);
  }

  void _onOtherValueChanged() {
    if (_isUpdating) {
      return;
    }
    _isUpdating = true;
    try {
      _value = _convert.convertA(_other.value);
      notifyListeners();
    } finally {
      _isUpdating = false;
    }
  }

  void _onValueChanged() {
    if (_isUpdating) {
      return;
    }
    _isUpdating = true;
    try {
      _other.value = _convert.convertB(_value);
    } finally {
      _isUpdating = false;
    }
  }

  @override
  T get value => _value;

  @override
  set value(T newValue) {
    if (newValue == _value) {
      return;
    }
    _value = newValue;
    notifyListeners();
    _onValueChanged();
  }

  @override
  void dispose() {
    _other.removeListener(_onOtherValueChanged);
    super.dispose();
  }
}
