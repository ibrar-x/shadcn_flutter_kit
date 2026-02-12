import 'package:flutter/material.dart' hide TextButton;

import 'sheet.dart';

/// Preview for `openSheet` and `SheetLayout` composite usage.
class SheetCompositePreview extends StatelessWidget {
  const SheetCompositePreview({super.key});

  Future<void> _open(BuildContext context) async {
    await openSheet<void>(
      context: context,
      position: OverlayPosition.bottom,
      builder: (context) {
        return SheetLayout(
          header: Text(
            'Create Workspace',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          child: const Text('This is a sheet content example.'),
          footer: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => closeSheet(context),
              child: const Text('Close'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrimaryButton(
          onPressed: () => _open(context),
          child: const Text('Open Sheet'),
        ),
      ),
    );
  }
}
