import 'package:flutter/material.dart';
import '../refresh_trigger/refresh_trigger.dart';

/// RefreshTriggerPreview defines a reusable type for this registry module.
class RefreshTriggerPreview extends StatelessWidget {
  const RefreshTriggerPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 260,
        child: RefreshTrigger(
          onRefresh: () async {
            await Future<void>.delayed(const Duration(milliseconds: 800));
          },
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return ListTile(title: Text('Row ${index + 1}'));
            },
          ),
        ),
      ),
    );
  }
}
