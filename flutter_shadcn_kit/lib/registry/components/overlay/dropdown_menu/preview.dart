import 'package:flutter/material.dart' as m;

import '../../control/button/button.dart';
import '../dropdown_menu/dropdown_menu.dart' as shadcn;
import '../menu/menu.dart' as shadcn_menu;

class DropdownMenuPreview extends m.StatelessWidget {
  const DropdownMenuPreview({super.key});

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: OutlineButton(
          onPressed: () {
            shadcn.showDropdown(
              context: context,
              builder: (context) {
                return const shadcn.DropdownMenu(
                  children: [
                    shadcn_menu.MenuLabel(child: m.Text('My Account')),
                    shadcn_menu.MenuDivider(),
                    shadcn_menu.MenuButton(child: m.Text('Profile')),
                    shadcn_menu.MenuButton(child: m.Text('Billing')),
                    shadcn_menu.MenuButton(child: m.Text('Settings')),
                    shadcn_menu.MenuButton(child: m.Text('Keyboard shortcuts')),
                    shadcn_menu.MenuDivider(),
                    shadcn_menu.MenuButton(child: m.Text('Team')),
                    shadcn_menu.MenuButton(
                      subMenu: [
                        shadcn_menu.MenuButton(child: m.Text('Email')),
                        shadcn_menu.MenuButton(child: m.Text('Message')),
                        shadcn_menu.MenuDivider(),
                        shadcn_menu.MenuButton(child: m.Text('More...')),
                      ],
                      child: m.Text('Invite users'),
                    ),
                    shadcn_menu.MenuButton(child: m.Text('New Team')),
                    shadcn_menu.MenuDivider(),
                    shadcn_menu.MenuButton(child: m.Text('GitHub')),
                    shadcn_menu.MenuButton(child: m.Text('Support')),
                    shadcn_menu.MenuDivider(),
                    shadcn_menu.MenuButton(child: m.Text('Log out')),
                  ],
                );
              },
            );
          },
          child: const m.Text('Open Menu'),
        ),
      ),
    );
  }
}
