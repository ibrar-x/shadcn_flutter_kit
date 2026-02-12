part of '../../preview.dart';

/// _SliderPreviewState stores and manages mutable widget state.
class _SliderPreviewState extends State<SliderPreview> {
  SliderValue _value = SliderValue.single(0.4);

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Slider(
            value: _value,
            onChanged: (value) => setState(() => _value = value),
            min: 0,
            max: 1,
          ),
        ),
      ),
    );
  }
}
