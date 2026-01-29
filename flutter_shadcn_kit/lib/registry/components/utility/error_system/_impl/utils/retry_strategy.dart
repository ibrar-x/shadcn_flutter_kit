import 'dart:math';

class RetryStrategy {
  RetryStrategy({
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 300),
    this.maxDelay = const Duration(seconds: 5),
    this.jitter = 0.2,
  });

  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;
  final double jitter;

  Duration delayForAttempt(int attempt) {
    final exp = pow(2, attempt).toDouble();
    final raw = baseDelay.inMilliseconds * exp;
    final capped = raw.clamp(
      baseDelay.inMilliseconds,
      maxDelay.inMilliseconds,
    );
    final jitterFactor = 1 + ((Random().nextDouble() * 2 - 1) * jitter);
    return Duration(milliseconds: (capped * jitterFactor).round());
  }
}
