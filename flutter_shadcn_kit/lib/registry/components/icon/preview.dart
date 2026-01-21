import 'package:flutter/material.dart';
import '../icon/icon.dart';
import '../icon/icon.dart';

class IconPreview extends StatelessWidget {
  const IconPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star).iconX3Small,
                const SizedBox(height: 8),
                const Text('X3Small', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star).iconSmall,
                const SizedBox(height: 8),
                const Text('Small', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star).iconMedium,
                const SizedBox(height: 8),
                const Text('Medium', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star).iconLarge,
                const SizedBox(height: 8),
                const Text('Large', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle).iconLarge,
                const SizedBox(height: 8),
                const Text('Default', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle)
                    .iconMutedForeground
                    .iconLarge,
                const SizedBox(height: 8),
                const Text('Muted', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle)
                    .iconPrimaryForeground
                    .iconLarge,
                const SizedBox(height: 8),
                const Text('Primary', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
