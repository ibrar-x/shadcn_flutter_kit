part of '../../preview.dart';

class _ColorPickerPreviewState extends State<ColorPickerPreview> {
  final ValueNotifier<ColorDerivative> selectedColorNotifier = ValueNotifier(
    ColorDerivative.fromColor(Colors.blue),
  );

  @override
  void dispose() {
    selectedColorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              onPressed: () {
                showPopover(
                  context: context,
                  alignment: Alignment.topCenter,
                  anchorAlignment: Alignment.bottomCenter,
                  widthConstraint: PopoverConstraint.intrinsic,
                  heightConstraint: PopoverConstraint.intrinsic,
                  offset: const Offset(0, 8),
                  builder: (context) {
                    return ListenableBuilder(
                      listenable: selectedColorNotifier,
                      builder: (context, _) {
                        return SurfaceCard(
                          child: ColorPicker(
                            value: selectedColorNotifier.value,
                            orientation: Axis.horizontal,
                            showAlpha: true,
                            onChanged: (value) {
                              setState(() {
                                selectedColorNotifier.value = value;
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: const Text('Open Color Picker Popover'),
            ),
            const DensityGap(gapLg),
            PrimaryButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Color'),
                      content: ListenableBuilder(
                        listenable: selectedColorNotifier,
                        builder: (context, _) {
                          return ColorPicker(
                            value: selectedColorNotifier.value,
                            orientation: Axis.horizontal,
                            showAlpha: true,
                            onChanged: (value) {
                              setState(() {
                                selectedColorNotifier.value = value;
                              });
                            },
                          );
                        },
                      ),
                      actions: [
                        PrimaryButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Open Color Picker Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
