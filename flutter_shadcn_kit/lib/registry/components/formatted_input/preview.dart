import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../formatted_input/formatted_input.dart';
import '../formatted_input/formatted_input.dart';

class FormattedInputPreview extends StatelessWidget {
  const FormattedInputPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FormattedInput(
          onChanged: (value) {
            final parts = <String>[];
            for (FormattedValuePart part in value.values) {
              parts.add(part.value ?? '');
            }
            if (kDebugMode) {
              print(parts.join('/'));
            }
          },
          initialValue: FormattedValue([
            const InputPart.editable(
              length: 2,
              width: 40,
              placeholder: Text('MM'),
            ).withValue('01'),
            const InputPart.static('/'),
            const InputPart.editable(
              length: 2,
              width: 40,
              placeholder: Text('DD'),
            ).withValue('02'),
            const InputPart.static('/'),
            const InputPart.editable(
              length: 4,
              width: 60,
              placeholder: Text('YYYY'),
            ).withValue('2021'),
          ]),
        ),
      ),
    );
  }
}
