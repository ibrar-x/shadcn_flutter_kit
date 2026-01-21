import 'package:flutter/material.dart';

import '../steps/steps.dart';
import '../text/text.dart';

class StepsPreview extends StatelessWidget {
  const StepsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Steps(
            children: const [
              Text('Create an account'),
              Text('Verify your email'),
              Text('Start using the app'),
            ],
          ),
        ),
      ),
    );
  }
}
