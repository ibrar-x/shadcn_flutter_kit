import 'package:flutter/material.dart';
import '../sortable/sortable.dart';

/// SortablePreview defines a reusable type for this registry module.
class SortablePreview extends StatelessWidget {
  const SortablePreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SortableLayer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Sortable<String>(
                data: const SortableData('Item A'),
                onAcceptTop: (data) {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Drag me'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
