part of '../../text_field.dart';

class _InputPasswordToggleFeatureState
    extends InputFeatureState<InputPasswordToggleFeature> {
  bool? _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      if (_obscureText == null) {
        _obscureText = true;
      } else {
        _obscureText = null;
      }
    });
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield _buildIconButton();
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield _buildIconButton();
    }
  }

  Widget _buildIcon() {
    if (_obscureText == true || input.obscureText) {
      return feature.icon ?? const Icon(LucideIcons.eye);
    }
    return feature.iconShow ?? const Icon(LucideIcons.eyeOff);
  }

  Widget _buildIconButton() {
    if (feature.mode == PasswordPeekMode.hold) {
      return IconButton.text(
        icon: _buildIcon(),
        onTapDown: (_) {
          setState(() {
            _obscureText = null;
          });
        },
        onTapUp: (_) {
          setState(() {
            _obscureText = true;
          });
        },
        enabled: true,
        density: ButtonDensity.compact,
      );
    }
    return IconButton.text(
      icon: _buildIcon(),
      onPressed: _toggleObscureText,
      density: ButtonDensity.compact,
    );
  }

  @override
  TextField interceptInput(TextField input) {
    return input.copyWith(obscureText: () => _obscureText ?? false);
  }
}
