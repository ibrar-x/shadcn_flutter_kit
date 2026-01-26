import 'package:flutter/material.dart';

import '../button/button.dart';

class ButtonPreview extends StatelessWidget {
  const ButtonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            PrimaryButton(
              onPressed: () {},
              child: const Text('Primary'),
            ),
            SecondaryButton(
              onPressed: () {},
              child: const Text('Secondary'),
            ),
            OutlineButton(
              onPressed: () {},
              child: const Text('Outline'),
            ),
            GhostButton(
              onPressed: () {},
              child: const Text('Ghost'),
            ),
            DestructiveButton(
              onPressed: () {},
              child: const Text('Delete'),
            ),
            LinkButton(
              onPressed: () {},
              child: const Text('Link'),
            ),
          ],
        ),
      ),
    );
  }
}
