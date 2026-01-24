import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/circular_progress_indicator/circular_progress_indicator.dart'
    as shadcn_circular;
import '../../../../ui/shadcn/components/display/tree/tree.dart' as shadcn_tree;
import '../../../../ui/shadcn/components/form/checkbox/checkbox.dart'
    as shadcn_checkbox;
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import 'tree_shared.dart';

const ComponentExample treeBasicExample = ComponentExample(
  title: 'Basic tree',
  builder: _buildTreeBasicExample,
  code: '''TreeView(nodes: nodes, builder: ...)''',
);

Widget _buildTreeBasicExample(BuildContext context) {
  return const _TreeBasicExample();
}

class _TreeBasicExample extends StatefulWidget {
  const _TreeBasicExample();

  @override
  State<_TreeBasicExample> createState() => _TreeBasicExampleState();
}

class _TreeBasicExampleState extends State<_TreeBasicExample> {
  bool _expandIcon = false;
  bool _usePath = true;
  bool _recursiveSelection = false;
  List<shadcn_tree.TreeNode<String>> _nodes = buildSampleTree();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedContainer(
          child: SizedBox(
            height: 300,
            width: 250,
            child: shadcn_tree.TreeView<String>(
              nodes: _nodes,
              shrinkWrap: true,
              expandIcon: _expandIcon,
              recursiveSelection: _recursiveSelection,
              branchLine: _usePath
                  ? shadcn_tree.BranchLine.path
                  : shadcn_tree.BranchLine.line,
              onSelectionChanged: shadcn_tree.TreeView.defaultSelectionHandler(
                _nodes,
                (value) => setState(() => _nodes = value),
              ),
              builder: (context, node) {
                return shadcn_tree.TreeItemView(
                  onPressed: () {},
                  trailing: node.leaf
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: shadcn_circular.CircularProgressIndicator(),
                        )
                      : null,
                  leading: node.leaf
                      ? const Icon(Icons.insert_drive_file_outlined)
                      : Icon(
                          node.expanded
                              ? Icons.folder_open
                              : Icons.folder_outlined,
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
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            shadcn_buttons.PrimaryButton(
              onPressed: () => setState(() => _nodes = _nodes.expandAll()),
              child: const Text('Expand all'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () => setState(() => _nodes = _nodes.collapseAll()),
              child: const Text('Collapse all'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        shadcn_checkbox.Checkbox(
          state: _expandIcon
              ? shadcn_checkbox.CheckboxState.checked
              : shadcn_checkbox.CheckboxState.unchecked,
          onChanged: (value) {
            setState(() {
              _expandIcon = value == shadcn_checkbox.CheckboxState.checked;
            });
          },
          trailing: const Text('Expand icon'),
        ),
        const SizedBox(height: 8),
        shadcn_checkbox.Checkbox(
          state: _usePath
              ? shadcn_checkbox.CheckboxState.checked
              : shadcn_checkbox.CheckboxState.unchecked,
          onChanged: (value) {
            setState(() {
              _usePath = value == shadcn_checkbox.CheckboxState.checked;
            });
          },
          trailing: const Text('Use path branch line'),
        ),
        const SizedBox(height: 8),
        shadcn_checkbox.Checkbox(
          state: _recursiveSelection
              ? shadcn_checkbox.CheckboxState.checked
              : shadcn_checkbox.CheckboxState.unchecked,
          onChanged: (value) {
            setState(() {
              _recursiveSelection =
                  value == shadcn_checkbox.CheckboxState.checked;
              if (_recursiveSelection) {
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
