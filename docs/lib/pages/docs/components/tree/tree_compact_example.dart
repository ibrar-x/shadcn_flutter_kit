import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/tree/tree.dart' as shadcn_tree;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;
import 'tree_shared.dart';

const ComponentExample treeCompactExample = ComponentExample(
  title: 'Compact list',
  builder: _buildTreeCompactExample,
  code: '''ComponentTheme<TreeTheme>(
  data: TreeTheme(branchLine: BranchLine.none, padding: EdgeInsets.all(4)),
  child: TreeView(...),
)''',
);

Widget _buildTreeCompactExample(BuildContext context) {
  return const _TreeCompactExample();
}

class _TreeCompactExample extends StatefulWidget {
  const _TreeCompactExample();

  @override
  State<_TreeCompactExample> createState() => _TreeCompactExampleState();
}

class _TreeCompactExampleState extends State<_TreeCompactExample> {
  List<shadcn_tree.TreeNode<String>> _nodes = buildSampleTree();

  @override
  Widget build(BuildContext context) {
    return shadcn_theme.ComponentTheme<shadcn_tree.TreeTheme>(
      data: const shadcn_tree.TreeTheme(
        branchLine: shadcn_tree.BranchLine.none,
        padding: EdgeInsets.all(4),
        expandIcon: false,
      ),
      child: SizedBox(
        height: 220,
        width: 220,
        child: shadcn_tree.TreeView<String>(
          nodes: _nodes,
          shrinkWrap: true,
          onSelectionChanged: shadcn_tree.TreeView.defaultSelectionHandler(
            _nodes,
            (value) => setState(() => _nodes = value),
          ),
          builder: (context, node) {
            return shadcn_tree.TreeItemView(
              onPressed: () {},
              leading: node.leaf
                  ? const Icon(Icons.description_outlined, size: 16)
                  : Icon(
                      node.expanded ? Icons.folder_open : Icons.folder_outlined,
                      size: 16,
                    ),
              onExpand: shadcn_tree.TreeView.defaultItemExpandHandler(
                _nodes,
                node,
                (value) => setState(() => _nodes = value),
              ),
              child: Text(node.data),
            );
          },
        ),
      ),
    );
  }
}
