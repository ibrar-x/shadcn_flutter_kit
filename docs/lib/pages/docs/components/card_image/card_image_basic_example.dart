import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/card_image/card_image.dart'
    as shadcn_card_image;
import '../../../../ui/shadcn/components/overlay/alert_dialog/alert_dialog.dart'
    as shadcn_alert_dialog;
import '../../../../ui/shadcn/components/overlay/dialog/dialog.dart'
    as shadcn_dialog;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample cardImageBasicExample = ComponentExample(
  title: 'Example',
  builder: _buildCardImageBasicExample,
  code: '''SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      CardImage(
        image: Image.network('https://picsum.photos/200/300'),
        title: Text('Card Number 1'),
        subtitle: Text('Lorem ipsum dolor sit amet'),
        onPressed: () {},
      ),
    ],
  ).gap(8),
)''',
);

Widget _buildCardImageBasicExample(BuildContext context) {
  return ScrollConfiguration(
    behavior: ScrollConfiguration.of(context).copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < 10; i++)
              shadcn_card_image.CardImage(
                onPressed: () {
                  shadcn_dialog.showDialog(
                    context: context,
                    builder: (context) {
                      return shadcn_alert_dialog.AlertDialog(
                        title: const Text('Card Image'),
                        content: const Text('You clicked on a card image.'),
                        actions: [
                          shadcn_buttons.PrimaryButton(
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
        ).gap(8),
      ),
    ),
  );
}
