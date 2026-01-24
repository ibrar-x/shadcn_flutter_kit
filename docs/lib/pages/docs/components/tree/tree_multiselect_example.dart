import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/tree/tree.dart' as shadcn_tree;
import '../../../../ui/shadcn/components/form/checkbox/checkbox.dart'
    as shadcn_checkbox;
import 'tree_shared.dart';

const ComponentExample treeMultiselectExample = ComponentExample(
  title: 'Multi-select tree',
  builder: _buildTreeMultiselectExample,
  code: '''TreeView(
  allowMultiSelect: true,
  recursiveSelection: true,
  nodes: nodes,
)''',
);

Widget _buildTreeMultiselectExample(BuildContext context) {
  return const _TreeMultiselectExample();
}

class _TreeMultiselectExample extends StatefulWidget {
  const _TreeMultiselectExample();

  @override
  State<_TreeMultiselectExample> createState() =>
      _TreeMultiselectExampleState();
}

class _TreeMultiselectExampleState extends State<_TreeMultiselectExample> {
  bool _recursive = true;
  List<shadcn_tree.TreeNode<String>> _nodes = buildSampleTree();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 240,
          width: 240,
          child: shadcn_tree.TreeView<String>(
            nodes: _nodes,
            shrinkWrap: true,
            allowMultiSelect: true,
            recursiveSelection: _recursive,
            onSelectionChanged: shadcn_tree.TreeView.defaultSelectionHandler(
              _nodes,
              (value) => setState(() => _nodes = value),
            ),
            builder: (context, node) {
              return shadcn_tree.TreeItemView(
                onPressed: () {},
                leading: node.leaf
                    ? const Icon(Icons.circle, size: 10)
                    : Icon(
                        node.expanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
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
        const SizedBox(height: 12),
        shadcn_checkbox.Checkbox(
          state: _recursive
              ? shadcn_checkbox.CheckboxState.checked
              : shadcn_checkbox.CheckboxState.unchecked,
          onChanged: (value) {
            setState(() {
              _recursive = value == shadcn_checkbox.CheckboxState.checked;
              if (_recursive) {
                _nodes = _nodes.updateRecursiveSelection();
              }
            });
          },
          trailing: const Text('Recursive selection'),
        ),
      ],
    );
  }
}
