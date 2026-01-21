import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../color/color.dart';
import '../form_field/form_field.dart';
import '../color_input/color_input.dart';

class ColorInputPreview extends StatefulWidget {
  const ColorInputPreview({super.key});

  @override
  State<ColorInputPreview> createState() => _ColorInputPreviewState();
}

class _ColorInputPreviewState extends State<ColorInputPreview> {
  ColorDerivative color = ColorDerivative.fromColor(Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: ColorInput(
                  value: color,
                  orientation: Axis.horizontal,
                  promptMode: PromptMode.popover,
                  onChanged: (value) {
                    setState(() {
                      color = value;
                    });
                  },
                ),
              ),
              const Gap(16),
              ColorInput(
                value: color,
                promptMode: PromptMode.dialog,
                dialogTitle: const Text('Select Color'),
                onChanged: (value) {
                  setState(() {
                    color = value;
                  });
                },
                showLabel: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
