import 'package:flutter/material.dart';

import '../steps/steps.dart';

/// StepsPreview defines a reusable type for this registry module.
class StepsPreview extends StatelessWidget {
  const StepsPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Steps(
            children: const [
/// Creates a `Text` instance.
              Text('Create an account'),
/// Creates a `Text` instance.
              Text('Verify your email'),
/// Creates a `Text` instance.
              Text('Start using the app'),
            ],
          ),
        ),
      ),
    );
  }
}
