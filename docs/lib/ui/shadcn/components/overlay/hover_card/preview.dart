import 'package:flutter/material.dart';

import '../../layout/basic/basic.dart';
import '../../control/button/button.dart';
import '../../layout/card/card.dart';
import '../hover_card/hover_card.dart';

/// HoverCardPreview defines a reusable type for this registry module.
class HoverCardPreview extends StatelessWidget {
  const HoverCardPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HoverCard(
          hoverBuilder: (context) {
            return SizedBox(
              width: 300,
              child: const SurfaceCard(
                child: Basic(
                  leading: FlutterLogo(),
                  title: Text('@flutter'),
                  content: Text(
                    'The Flutter SDK provides the tools to build beautiful apps for mobile, web, and desktop from a single codebase.',
                  ),
                ),
              ),
            );
          },
          child: LinkButton(onPressed: () {}, child: const Text('@flutter')),
        ),
      ),
    );
  }
}
