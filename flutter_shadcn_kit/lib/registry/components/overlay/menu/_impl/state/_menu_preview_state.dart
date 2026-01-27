part of '../../preview.dart';

class _MenuPreviewState extends State<MenuPreview> {
  bool showHiddenFiles = false;
  String sortBy = 'name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MenuPopup(
          children: [
            const MenuLabel(child: Text('File')),
            MenuButton(
              trailing: const MenuShortcut(
                activator: SingleActivator(LogicalKeyboardKey.keyN, control: true),
              ),
              child: const Text('New Window'),
            ),
            MenuButton(
              trailing: const MenuShortcut(
                activator: SingleActivator(LogicalKeyboardKey.keyO, control: true),
              ),
              child: const Text('Open File...'),
            ),
            const MenuDivider(),
            MenuCheckbox(
              value: showHiddenFiles,
              autoClose: false,
              onChanged: (context, value) {
                setState(() {
                  showHiddenFiles = value;
                });
              },
              child: const Text('Show hidden files'),
            ),
            const MenuDivider(),
            MenuRadioGroup<String>(
              value: sortBy,
              onChanged: (context, value) {
                setState(() {
                  sortBy = value;
                });
              },
              children: const [
                MenuRadio(value: 'name', child: Text('Sort by Name')),
                MenuRadio(value: 'date', child: Text('Sort by Date')),
                MenuRadio(value: 'size', child: Text('Sort by Size')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
