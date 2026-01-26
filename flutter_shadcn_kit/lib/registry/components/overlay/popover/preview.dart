import 'package:flutter/material.dart';

import '../popover/popover.dart';
import '../../control/button/button.dart';

class PopoverPreview extends StatelessWidget {
  const PopoverPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrimaryButton(
          onPressed: () {
            showPopover(
              context: context,
              alignment: Alignment.topCenter,
              offset: const Offset(0, 8),
              builder: (context) {
                return Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Popover title',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        Text('Use popovers for contextual helper content.'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text('Open Popover'),
        ),
      ),
    );
  }
}
