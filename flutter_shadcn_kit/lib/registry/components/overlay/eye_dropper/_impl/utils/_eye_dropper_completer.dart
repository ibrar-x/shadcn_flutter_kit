part of '../../eye_dropper.dart';

class _EyeDropperCompleter {
  final Completer<Color?> completer;
  final Set<ColorHistoryStorage> recentColorsScope;

  _EyeDropperCompleter(this.completer, this.recentColorsScope);
}
