import 'package:flutter/material.dart' as m;

import '../button/button.dart';
import '../card/card.dart';
import '../dialog/dialog.dart' as shadcn;

class DialogPreview extends m.StatelessWidget {
  const DialogPreview({super.key});

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: PrimaryButton(
          onPressed: () {
            shadcn.showDialog<void>(
              context: context,
              builder: (context) {
                return Card(
                  padding: const m.EdgeInsets.all(24),
                  child: m.Column(
                    mainAxisSize: m.MainAxisSize.min,
                    crossAxisAlignment: m.CrossAxisAlignment.start,
                    children: [
                      const m.Text(
                        'Dialog title',
                        style: m.TextStyle(
                          fontSize: 18,
                          fontWeight: m.FontWeight.w600,
                        ),
                      ),
                      const m.SizedBox(height: 12),
                      const m.Text('Use dialogs for important confirmations.'),
                      const m.SizedBox(height: 20),
                      m.Row(
                        children: [
                          const m.Spacer(),
                          OutlineButton(
                            onPressed: () => m.Navigator.of(context).pop(),
                            child: const m.Text('Close'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const m.Text('Open Dialog'),
        ),
      ),
    );
  }
}
