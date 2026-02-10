import 'package:flutter/material.dart';
import '../clickable/clickable.dart';

class ClickablePreview extends StatelessWidget {
  const ClickablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Clickable(
          onPressed: () {},
          decoration: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(8),
              );
            }
            if (states.contains(WidgetState.hovered)) {
              return BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(8),
              );
            }
            return BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            );
          }),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text('Clickable', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
