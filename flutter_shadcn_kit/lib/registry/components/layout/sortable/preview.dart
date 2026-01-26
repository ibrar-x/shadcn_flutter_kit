import 'package:flutter/material.dart';
import '../sortable/sortable.dart';

class SortablePreview extends StatelessWidget {
  const SortablePreview({super.key});

  @override
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
