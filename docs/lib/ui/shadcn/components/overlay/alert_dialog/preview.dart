import 'package:flutter/material.dart' as m;

import '../alert_dialog/alert_dialog.dart' as shadcn;
import '../../control/button/button.dart' as shadcn;

class AlertDialogPreview extends m.StatelessWidget {
  const AlertDialogPreview({super.key});

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: shadcn.PrimaryButton(
          onPressed: () {
            m.showDialog(
              context: context,
              builder: (context) {
                return shadcn.AlertDialog(
                  title: const m.Text('Alert title'),
                  content: const m.Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  actions: [
                    shadcn.OutlineButton(
                      onPressed: () {
                        m.Navigator.pop(context);
                      },
                      child: const m.Text('Cancel'),
                    ),
                    shadcn.PrimaryButton(
                      onPressed: () {
                        m.Navigator.pop(context);
                      },
                      child: const m.Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: const m.Text('Show Alert Dialog'),
        ),
      ),
    );
  }
}
