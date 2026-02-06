import 'package:flutter/material.dart';

import '../collapsible/collapsible.dart';
import '../outlined_container/outlined_container.dart';

class CollapsiblePreview extends StatelessWidget {
  const CollapsiblePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Collapsible(
            children: [
              CollapsibleTrigger(
                child: Text('Recent activity'),
              ),
              SizedBox(height: 8),
              OutlinedContainer(
                padding: EdgeInsets.all(12),
                child: Text('@ibrar-x/shadcn_flutter_kit'),
              ),
              CollapsibleContent(
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: OutlinedContainer(
                    padding: EdgeInsets.all(12),
                    child: Text('@flutter/flutter'),
                  ),
                ),
              ),
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
