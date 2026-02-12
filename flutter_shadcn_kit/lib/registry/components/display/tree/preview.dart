import 'package:flutter/material.dart';

import '../tree/tree.dart';

/// Core class used by the tree component.
class TreePreview extends StatelessWidget {
  const TreePreview({super.key});

  /// Builds the widget tree for tree.
  @override
  Widget build(BuildContext context) {
    final nodes = <TreeNode<String>>[
      TreeItem(
        data: 'Design',
        expanded: true,
        children: [
          TreeItem(data: 'Research'),

          TreeItem(data: 'Wireframes'),

          TreeItem(data: 'Prototypes'),
        ],
      ),

      TreeItem(
        data: 'Development',
        expanded: true,
        children: [
          TreeItem(data: 'Frontend'),

          TreeItem(data: 'Backend'),
        ],
      ),

      TreeItem(data: 'Launch'),
    ];
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: TreeView<String>(
            nodes: nodes,
            builder: (context, item) => Text(item.data),
          ),
        ),
      ),
    );
  }
}
