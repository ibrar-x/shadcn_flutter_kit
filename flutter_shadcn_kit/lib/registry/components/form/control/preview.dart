import 'package:flutter/material.dart';
import '../control/control.dart';

/// ControlPreview represents a form-related type in the registry.
class ControlPreview extends StatelessWidget {
  const ControlPreview({super.key});

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ControlledComponentAdapter<int>(
          initialValue: 0,
          builder: (context, data) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: data.enabled
                      ? () => data.onChanged(data.value - 1)
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                Text('${data.value}'),
                IconButton(
                  onPressed: data.enabled
                      ? () => data.onChanged(data.value + 1)
                      : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
