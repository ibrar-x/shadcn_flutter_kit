import 'package:flutter/material.dart';

import 'multiselect.dart';

/// Preview for `MultiSelectField` composite usage.
class MultiSelectCompositePreview extends StatefulWidget {
  const MultiSelectCompositePreview({super.key});

  @override
  State<MultiSelectCompositePreview> createState() =>
      _MultiSelectCompositePreviewState();
}

class _MultiSelectCompositePreviewState
    extends State<MultiSelectCompositePreview> {
  Iterable<String>? _selected = const ['Flutter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: MultiSelectField<String>(
              value: _selected,
              onChanged: (value) {
                setState(() {
                  _selected = value;
                });
              },
              options: const [
                MultiSelectOption(value: 'Flutter', label: Text('Flutter')),
                MultiSelectOption(value: 'Dart', label: Text('Dart')),
                MultiSelectOption(value: 'Firebase', label: Text('Firebase')),
                MultiSelectOption(value: 'Supabase', label: Text('Supabase')),
                MultiSelectOption(value: 'FastAPI', label: Text('FastAPI')),
              ],
              placeholder: const Text('Select skills'),
            ),
          ),
        ),
      ),
    );
  }
}
