import 'dart:ui';

import 'package:flutter/material.dart' hide AlertDialog;
import '../../overlay/alert_dialog/alert_dialog.dart';
import '../../control/button/button.dart';
import '../card_image/card_image.dart';

class CardImagePreview extends StatelessWidget {
  const CardImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 10; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  CardImage(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Card Image'),
                            content: const Text('You clicked on a card image.'),
                            actions: [
                              PrimaryButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    image: Image.network('https://picsum.photos/200/300'),
                    title: Text('Card Number ${i + 1}'),
                    subtitle: const Text('Lorem ipsum dolor sit amet'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
