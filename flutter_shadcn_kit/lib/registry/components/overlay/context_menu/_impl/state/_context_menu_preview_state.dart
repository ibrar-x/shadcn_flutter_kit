part of '../../preview.dart';

class _ContextMenuPreviewState extends State<ContextMenuPreview> {
  bool showBookmarks = false;
  bool showFullUrls = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: ContextMenu(
          items: [
            const MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.bracketLeft,
                  control: true,
                ),
              ),
              child: Text('Back'),
            ),
            const MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.bracketRight,
                  control: true,
                ),
              ),
              enabled: false,
              child: Text('Forward'),
            ),
            const MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                ),
              ),
              child: Text('Reload'),
            ),
            MenuButton(
              subMenu: [
                const MenuButton(child: Text('Option 1')),
                const MenuButton(child: Text('Option 2')),
              ],
              trailing: const Icon(Icons.chevron_right),
              child: const Text('More Tools'),
            ),
            const MenuDivider(),
            MenuCheckbox(
              value: showBookmarks,
              autoClose: false,
              onChanged: (context, value) {
                setState(() {
                  showBookmarks = value;
                });
              },
              child: const Text('Show bookmarks bar'),
            ),
            MenuCheckbox(
              value: showFullUrls,
              autoClose: false,
              onChanged: (context, value) {
                setState(() {
                  showFullUrls = value;
                });
              },
              child: const Text('Show full URLs'),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.dividerColor,
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Right-click here',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
