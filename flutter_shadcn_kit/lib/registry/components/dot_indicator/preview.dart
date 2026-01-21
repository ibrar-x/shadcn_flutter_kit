import 'package:flutter/material.dart';
import '../dot_indicator/dot_indicator.dart';
import '../dot_indicator/dot_indicator.dart';

class DotIndicatorPreview extends StatefulWidget {
  const DotIndicatorPreview({super.key});

  @override
  State<DotIndicatorPreview> createState() => _DotIndicatorPreviewState();
}

class _DotIndicatorPreviewState extends State<DotIndicatorPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DotIndicator(
              index: _index,
              length: 5,
              onChanged: (value) {
                setState(() {
                  _index = value;
                });
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _index > 0
                      ? () {
                          setState(() {
                            _index--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text('Index: $_index'),
                IconButton(
                  onPressed: _index < 4
                      ? () {
                          setState(() {
                            _index++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
