import 'package:flutter/material.dart' as m;

import '../menu/menu.dart' as shadcn_menu;
import '../menubar/menubar.dart' as shadcn;

class MenubarPreview extends m.StatelessWidget {
  const MenubarPreview({super.key});

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: shadcn.Menubar(
          border: true,
          children: [
            shadcn_menu.MenuButton(
              subMenu: [
                shadcn_menu.MenuButton(child: const m.Text('New')),
                shadcn_menu.MenuButton(child: const m.Text('Open')),
                const shadcn_menu.MenuDivider(),
                shadcn_menu.MenuButton(child: const m.Text('Exit')),
              ],
              child: const m.Text('File'),
            ),
            shadcn_menu.MenuButton(
              subMenu: [
                shadcn_menu.MenuButton(child: const m.Text('Cut')),
                shadcn_menu.MenuButton(child: const m.Text('Copy')),
                shadcn_menu.MenuButton(child: const m.Text('Paste')),
              ],
              child: const m.Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
