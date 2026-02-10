part of '../../preview.dart';

class _TabPanePreviewState extends State<TabPanePreview> {
  int _focused = 0;
  late final List<TabPaneData<String>> _items = [
    const TabPaneData('Overview'),
    const TabPaneData('Analytics'),
    const TabPaneData('Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 420,
          child: TabPane<String>(
            items: _items,
            focused: _focused,
            onFocused: (index) => setState(() => _focused = index),
            itemBuilder: (context, item, index) {
              return TabChildWidget(indexed: true, child: Text(item.data));
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Content: ${_items[_focused].data}'),
            ),
          ),
        ),
      ),
    );
  }
}
