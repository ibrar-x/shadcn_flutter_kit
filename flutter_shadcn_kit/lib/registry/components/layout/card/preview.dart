import 'package:flutter/material.dart' hide Card, TextField;

import '../../control/button/button.dart';
import '../card/card.dart';
import '../../display/text/text.dart';
import '../../form/text_field/text_field.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Card(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Create project').semiBold(),
                const SizedBox(height: 6),
                const Text(
                  'Deploy your new project in one-click.',
                ).muted().small(),
                const SizedBox(height: 20),
                const Text('Name').semiBold().small(),
                const SizedBox(height: 6),
                const TextField(placeholder: Text('Project name')),
                const SizedBox(height: 16),
                const Text('Description').semiBold().small(),
                const SizedBox(height: 6),
                const TextField(placeholder: Text('What is this for?')),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Spacer(),
                    OutlineButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    PrimaryButton(
                      onPressed: () {},
                      child: const Text('Deploy'),
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
