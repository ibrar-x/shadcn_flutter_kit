part of 'preview.dart';

class _HsvPreviewState extends State<HsvPreview> {
  HSVColor _color = HSVColor.fromColor(Colors.deepPurple);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HSVColorSlider(
              value: _color,
              sliderType: HSVColorSliderType.hue,
              onChanged: (color) => setState(() => _color = color),
            ),
            const SizedBox(height: 12),
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: _color.toColor(),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
