import 'package:flutter/material.dart';
import '../debug/debug.dart';

/// DebugPreview defines a reusable type for this registry module.
class DebugPreview extends StatelessWidget {
  const DebugPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Debug container').debugContainer(Colors.green),
      ),
    );
  }
}
