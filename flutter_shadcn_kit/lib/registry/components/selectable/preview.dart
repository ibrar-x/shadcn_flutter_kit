import 'package:flutter/material.dart' hide SelectableText;

import '../selectable/selectable.dart';

class SelectablePreview extends StatelessWidget {
  const SelectablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SelectableText(
          'Select this text to see the custom selection styling.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
