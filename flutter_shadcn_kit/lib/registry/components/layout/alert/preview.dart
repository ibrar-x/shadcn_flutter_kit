import 'package:flutter/material.dart';
import '../alert/alert.dart';

class AlertPreview extends StatelessWidget {
  const AlertPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  // Basic alert
                  const Alert(
                    title: Text('Alert title'),
                    content: Text('This is alert content.'),
                    leading: Icon(Icons.info_outline),
                  ),
                  // Destructive alert
                  const Alert.destructive(
                    title: Text('Error'),
                    content: Text(
                      'Your session has expired. Please log in again.',
                    ),
                    leading: Icon(Icons.error_outline),
                  ),
                  // Alert with trailing action
                  Alert(
                    title: const Text('Notification'),
                    content: const Text('You have a new message.'),
                    leading: const Icon(Icons.notifications_outlined),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
