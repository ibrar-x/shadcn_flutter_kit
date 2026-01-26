T tweenValue<T>(T begin, T end, double t) {
  dynamic beginValue = begin;
  dynamic endValue = end;
  return (beginValue + (endValue - beginValue) * t) as T;
}
