part of '../../util.dart';

class BiDirectionalConvert<A, B> {
  /// Converts from A to B.
  final B Function(A) aToB;

  /// Converts from B to A.
  final A Function(B) bToA;

  /// Creates a [BiDirectionalConvert].
  BiDirectionalConvert(this.aToB, this.bToA);

  /// Converts A to B.
  B convertA(A value) => aToB(value);

  /// Converts B to A.
  A convertB(B value) => bToA(value);

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
