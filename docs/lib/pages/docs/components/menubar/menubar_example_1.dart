import 'package:docs/shadcn_ui.dart';
import 'package:docs/ui/shadcn/components/overlay/menu/menu.dart' as menu;
import 'package:docs/ui/shadcn/components/overlay/menubar/menubar.dart'
    as menubar;

class MenubarExample1 extends StatefulWidget {
  const MenubarExample1({super.key});

  @override
  State<MenubarExample1> createState() => _MenubarExample1State();
}

class _MenubarExample1State extends State<MenubarExample1> {
  bool _showBookmarksBar = false;
  bool _showFullURLs = true;
  int _selectedProfile = 1;
  @override
  Widget build(BuildContext context) {
    // Typical desktop-style menubar with nested submenus, shortcuts,
    // checkboxes (non-closing), and a radio group.
    return menubar.Menubar(
      children: [
        const menu.MenuButton(
          subMenu: [
            menu.MenuButton(
              leading: Icon(RadixIcons.filePlus),
              trailing: menu.MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyT,
                  control: true,
                ),
              ),
              child: Text('New Tab'),
            ),
            menu.MenuButton(
              trailing: menu.MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyN,
                  control: true,
                ),
              ),
              child: Text('New Window'),
            ),
            menu.MenuButton(
              enabled: false,
              child: Text('New Incognito Window'),
            ),
            menu.MenuDivider(),
            menu.MenuButton(
              subMenu: [
                menu.MenuButton(
                  child: Text('Email Link'),
                ),
                menu.MenuButton(
                  child: Text('Messages'),
                ),
                menu.MenuButton(
                  child: Text('Notes'),
                ),
              ],
              child: Text('Share'),
            ),
            menu.MenuButton(
              trailing: menu.MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyP,
                  control: true,
                ),
              ),
              child: Text('Print'),
            ),
            menu.MenuButton(
              subMenu: [
                menu.MenuButton(
                  child: Text('Save and Exit'),
                ),
                menu.MenuButton(
                  child: Text('Discard and Exit'),
                ),
              ],
              child: Text('Exit'),
            ),
          ],
          child: Text('File'),
        ),
        const menu.MenuButton(
          subMenu: [
            menu.MenuButton(
              trailing: menu.MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyZ,
                  control: true,
                ),
              ),
              child: Text('Undo'),
            ),
            menu.MenuButton(
              trailing: menu.MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyZ,
                  control: true,
                  shift: true,
                ),
              ),
              child: Text('Redo'),
            ),
            menu.MenuDivider(),
            menu.MenuButton(
              subMenu: [
                menu.MenuButton(
                  child: Text('Search the Web'),
                ),
                menu.MenuDivider(),
                menu.MenuButton(
                  child: Text('Find...'),
                ),
                menu.MenuButton(
                  child: Text('Find Next'),
                ),
                menu.MenuButton(
                  child: Text('Find Previous'),
                ),
              ],
              child: Text('Find'),
            ),
            menu.MenuDivider(),
            menu.MenuButton(
              child: Text('Cut'),
            ),
            menu.MenuButton(
              child: Text('Copy'),
            ),
            menu.MenuButton(
              child: Text('Paste'),
            ),
          ],
          child: Text('Edit'),
        ),
        menu.MenuButton(
          subMenu: [
            menu.MenuCheckbox(
              value: _showBookmarksBar,
              onChanged: (context, value) {
                setState(() {
                  _showBookmarksBar = value;
                });
              },
              // Keep the submenu open while toggling for quicker multi-actions.
              autoClose: false,
              child: const Text('Always Show Bookmarks Bar'),
            ),
            menu.MenuCheckbox(
              value: _showFullURLs,
              onChanged: (context, value) {
                setState(() {
                  _showFullURLs = value;
                });
              },
              // Also keep open here to demonstrate autoClose control.
              autoClose: false,
              child: const Text('Always Show Full URLs'),
            ),
            const menu.MenuDivider(),
            const menu.MenuButton(
              trailing: menu.MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                ),
              ),
              child: Text('Reload'),
            ),
            const menu.MenuButton(
              enabled: false,
              trailing: menu.MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                  shift: true,
                ),
              ),
              child: Text('Force Reload'),
            ),
            const menu.MenuDivider(),
            const menu.MenuButton(
              child: Text('Toggle Full Screen'),
            ),
            const menu.MenuDivider(),
            const menu.MenuButton(
              child: Text('Hide Sidebar'),
            ),
          ],
          child: const Text('View'),
        ),
        menu.MenuButton(
          subMenu: [
            menu.MenuRadioGroup<int>(
              value: _selectedProfile,
              onChanged: (context, value) {
                setState(() {
                  _selectedProfile = value;
                });
              },
              children: const [
                menu.MenuRadio<int>(
                  value: 0,
                  // Disable auto-close to let users quickly toggle multiple options.
                  autoClose: false,
                  child: Text('Andy'),
                ),
                menu.MenuRadio<int>(
                  value: 1,
                  autoClose: false,
                  child: Text('Benoit'),
                ),
                menu.MenuRadio<int>(
                  value: 2,
                  autoClose: false,
                  child: Text('Luis'),
                ),
              ],
            ),
            const menu.MenuDivider(),
            const menu.MenuButton(
              child: Text('Edit...'),
            ),
            const menu.MenuDivider(),
            const menu.MenuButton(
              child: Text('Add Profile...'),
            ),
          ],
          child: const Text('Profiles'),
        ),
      ],
    );
  }
}
