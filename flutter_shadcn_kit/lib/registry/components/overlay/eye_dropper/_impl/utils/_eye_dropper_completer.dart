part of '../../eye_dropper.dart';

/// _EyeDropperCompleter defines a reusable type for this registry module.
class _EyeDropperCompleter {
/// Stores `completer` state/configuration for this implementation.
  final Completer<Color?> completer;
/// Stores `recentColorsScope` state/configuration for this implementation.
  final Set<ColorHistoryStorage> recentColorsScope;

  _EyeDropperCompleter(this.completer, this.recentColorsScope);
}
