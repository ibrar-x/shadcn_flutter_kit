import 'package:flutter/material.dart';
import '../progress/progress.dart';
import '../button/button.dart';
import '../progress/progress.dart';

class ProgressPreview extends StatefulWidget {
  const ProgressPreview({super.key});

  @override
  State<ProgressPreview> createState() => _ProgressPreviewState();
}

class _ProgressPreviewState extends State<ProgressPreview> {
  double _progress = 33.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 400,
              child: Progress(
                progress: _progress.clamp(0, 100),
                min: 0,
                max: 100,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlineButton(
                  onPressed: () {
                    setState(() {
                      _progress = (_progress - 10).clamp(0, 100);
                    });
                  },
                  child: const Text('-10%'),
                ),
                const SizedBox(width: 8),
                OutlineButton(
                  onPressed: () {
                    setState(() {
                      _progress = (_progress + 10).clamp(0, 100);
                    });
                  },
                  child: const Text('+10%'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
