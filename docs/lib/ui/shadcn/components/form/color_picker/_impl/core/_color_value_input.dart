part of '../../color_picker.dart';

class _ColorValueInput extends StatefulWidget {
  final String value;
  final Widget? placeholder;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const _ColorValueInput({
    required this.value,
    this.placeholder,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  State<_ColorValueInput> createState() => _ColorValueInputState();
}
