# Tree

Hierarchical tree view with expandable nodes.

## Usage
```dart
TreeView<String>(
  nodes: [
    TreeItem(
      data: 'Parent',
      expanded: true,
      children: [
        TreeItem(data: 'Child 1'),
        TreeItem(data: 'Child 2'),
      ],
    ),
  ],
  builder: (context, item) => Text(item.data),
)
```
