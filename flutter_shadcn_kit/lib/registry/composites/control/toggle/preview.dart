import 'package:flutter/material.dart';

import 'toggle.dart';

/// Preview for `Toggle` and `ToggleTile` composite usage.
class TogglePreview extends StatefulWidget {
  const TogglePreview({super.key});

  @override
  State<TogglePreview> createState() => _TogglePreviewState();
}

class _TogglePreviewState extends State<TogglePreview> {
  bool _notifications = true;
  bool _autoSave = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ToggleTile(
                  value: _notifications,
                  title: const Text('Notifications'),
                  subtitle: const Text('Enable push notifications'),
                  leading: const Icon(Icons.notifications_outlined),
                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                Toggle(
                  value: _autoSave,
                  onChanged: (value) {
                    setState(() {
                      _autoSave = value;
                    });
                  },
                  child: const Text('Auto save drafts'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
