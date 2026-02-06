part of '../../util.dart';

/// Function type for converting from type [F] to type [T].
typedef Convert<F, T> = T Function(F value);

class BiDirectionalConvert<A, B> {
  /// Converts from A to B.
  final Convert<A, B> aToB;

  /// Converts from B to A.
  final Convert<B, A> bToA;

  /// Creates a [BiDirectionalConvert].
  BiDirectionalConvert(this.aToB, this.bToA);

  /// Converts A to B.
  B convertA(A value) => aToB(value);

  /// Converts B to A.
  A convertB(B value) => bToA(value);

  @override
  String toString() {
    return 'BiDirectionalConvert($aToB, $bToA)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BiDirectionalConvert<A, B> &&
        other.aToB == aToB &&
        other.bToA == bToA;
  }

  @override
  int get hashCode => Object.hash(aToB, bToA);
}

/// A controller that converts between types [F] and [T].
