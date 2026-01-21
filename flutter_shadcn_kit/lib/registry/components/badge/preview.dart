import 'package:flutter/material.dart';
import '../badge/badge.dart';
import 'badge.dart';

class BadgePreview extends StatelessWidget {
  const BadgePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16,
              children: [
                // Primary badges
                const Wrap(
                  spacing: 8,
                  children: [
                    PrimaryBadge(child: Text('Primary')),
                    PrimaryBadge(child: Text('Badge')),
                  ],
                ),
                // Secondary badges
                const Wrap(
                  spacing: 8,
                  children: [
                    SecondaryBadge(child: Text('Secondary')),
                    SecondaryBadge(child: Text('Badge')),
                  ],
                ),
                // Destructive badges
                const Wrap(
                  spacing: 8,
                  children: [
                    DestructiveBadge(child: Text('Destructive')),
                    DestructiveBadge(child: Text('Error')),
                  ],
                ),
                // Outline badges
                const Wrap(
                  spacing: 8,
                  children: [
                    OutlineBadge(child: Text('Outline')),
                    OutlineBadge(child: Text('Badge')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
