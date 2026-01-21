import 'package:flutter/material.dart';
import '../history/history.dart';
import '../history/history.dart';

class HistoryPreview extends StatelessWidget {
  const HistoryPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RecentColorsScope(
          initialRecentColors: const [Color(0xFF2196F3), Color(0xFF9C27B0)],
          child: Builder(
            builder: (context) {
              return ColorHistoryGrid(
                storage: ColorHistoryStorage.of(context),
                onColorPicked: (color) {},
              );
            },
          ),
        ),
      ),
    );
  }
}
