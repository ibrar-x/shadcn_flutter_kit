part of '../../slider.dart';

extension SliderValueRangeChecks on SliderValue {
  bool get isSingle => !isRanged;
  bool get isRange => isRanged;
}
