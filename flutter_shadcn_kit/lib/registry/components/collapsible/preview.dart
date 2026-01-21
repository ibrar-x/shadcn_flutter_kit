import 'package:flutter/material.dart';

import '../collapsible/collapsible.dart';
import '../outlined_container/outlined_container.dart';

class CollapsiblePreview extends StatelessWidget {
  const CollapsiblePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Collapsible(
            children: [
              const CollapsibleTrigger(
                child: Text('Recent activity'),
              ),
              const SizedBox(height: 8),
              OutlinedContainer(
                padding: const EdgeInsets.all(12),
                child: const Text('@sunarya-thito/shadcn_flutter'),
              ),
              CollapsibleContent(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: OutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: const Text('@flutter/flutter'),
                  ),
                ),
              ),
              CollapsibleContent(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: OutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: const Text('@dart-lang/sdk'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
