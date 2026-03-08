import 'package:flutter/material.dart';

import '../collapsible/collapsible.dart';
import '../outlined_container/outlined_container.dart';

/// CollapsiblePreview defines a reusable type for this registry module.
class CollapsiblePreview extends StatelessWidget {
  const CollapsiblePreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Collapsible(
            children: [
/// Creates a `CollapsibleTrigger` instance.
              CollapsibleTrigger(child: Text('Recent activity')),
/// Creates a `SizedBox` instance.
              SizedBox(height: 8),
/// Creates a `OutlinedContainer` instance.
              OutlinedContainer(
                padding: EdgeInsets.all(12),
                child: Text('@ibrar-x/shadcn_flutter_kit'),
              ),
/// Creates a `CollapsibleContent` instance.
              CollapsibleContent(
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: OutlinedContainer(
                    padding: EdgeInsets.all(12),
                    child: Text('@flutter/flutter'),
                  ),
                ),
              ),
/// Creates a `CollapsibleContent` instance.
              CollapsibleContent(
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: OutlinedContainer(
                    padding: EdgeInsets.all(12),
                    child: Text('@dart-lang/sdk'),
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
