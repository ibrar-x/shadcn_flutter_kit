part of '../../preview.dart';

class _SliderPreviewState extends State<SliderPreview> {
  SliderValue _value = const SliderValue.single(0.4);

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
