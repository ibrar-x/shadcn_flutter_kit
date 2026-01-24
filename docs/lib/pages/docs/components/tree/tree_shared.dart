import '../../../../ui/shadcn/components/display/tree/tree.dart';

List<TreeNode<String>> buildSampleTree() {
  return [
    TreeItem(
      data: 'Apple',
      expanded: true,
      children: [
        TreeItem(data: 'Red Apple', children: [
          TreeItem(data: 'Red Apple 1'),
          TreeItem(data: 'Red Apple 2'),
        ]),
        TreeItem(data: 'Green Apple'),
      ],
    ),
    TreeItem(
      data: 'Banana',
      children: [
        TreeItem(data: 'Yellow Banana'),
        TreeItem(data: 'Green Banana', children: [
          TreeItem(data: 'Green Banana 1'),
          TreeItem(data: 'Green Banana 2'),
          TreeItem(data: 'Green Banana 3'),
        ]),
      ],
    ),
    TreeItem(
      data: 'Cherry',
      children: [
        TreeItem(data: 'Red Cherry'),
        TreeItem(data: 'Green Cherry'),
      ],
    ),
    TreeItem(data: 'Date'),
    TreeRoot(
      children: [
        TreeItem(
          data: 'Elderberry',
          children: [
            TreeItem(data: 'Black Elderberry'),
            TreeItem(data: 'Red Elderberry'),
          ],
        ),
        TreeItem(
          data: 'Fig',
          children: [
            TreeItem(data: 'Green Fig'),
            TreeItem(data: 'Purple Fig'),
          ],
        ),
      ],
    ),
  ];
}
