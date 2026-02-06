import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../keyboard_shortcut/keyboard_shortcut.dart';

class KeyboardShortcutPreview extends StatelessWidget {
  const KeyboardShortcutPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: KeyboardDisplay.fromActivator(
          activator:
              SingleActivator(LogicalKeyboardKey.keyS, control: true),
        ),
      ),
    );
  }
}
