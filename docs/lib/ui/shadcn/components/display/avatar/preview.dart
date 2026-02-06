import 'package:flutter/material.dart';
import '../avatar/avatar.dart';

class AvatarPreview extends StatelessWidget {
  const AvatarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 24,
              children: [
                // Avatar with image and initials fallback
                Avatar(
                  backgroundColor: Colors.red,
                  initials: Avatar.getInitials('M Ibrar'),
                  provider: const NetworkImage(
                    'https://avatars.githubusercontent.com/u/64018564?v=4',
                  ),
                ),
                // Avatar with initials only
                Avatar(
                  backgroundColor: Colors.blue,
                  initials: Avatar.getInitials('John Doe'),
                ),
                // Avatar group
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Avatar(
                      backgroundColor: Colors.purple,
                      initials: Avatar.getInitials('Alice'),
                    ),
                    Avatar(
                      backgroundColor: Colors.green,
                      initials: Avatar.getInitials('Bob'),
                    ),
                    Avatar(
                      backgroundColor: Colors.orange,
                      initials: Avatar.getInitials('Charlie'),
                    ),
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
