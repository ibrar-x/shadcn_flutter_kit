import 'package:flutter/material.dart';
import '../debug/debug.dart';
import '../debug/debug.dart';

class DebugPreview extends StatelessWidget {
  const DebugPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Debug container').debugContainer(Colors.green),
      ),
    );
  }
}
