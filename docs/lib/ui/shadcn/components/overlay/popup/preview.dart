import 'package:flutter/material.dart';
import '../popup/popup.dart';

class PopupPreview extends StatelessWidget {
  const PopupPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MenuPopup(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Profile'),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Settings'),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
