import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'dropdown_menu_example_1.dart';

const ComponentExample dropdownMenuExample1 = ComponentExample(
  title: "Dropdown Menu Example",
  builder: _buildDropdownMenuExample1,
  code: "import 'package:flutter/foundation.dart';\nimport 'package:docs/shadcn_ui.dart';\nimport 'package:docs/ui/shadcn/components/overlay/menu/menu.dart';\n\n/// Dropdown menu anchored to a button.\n///\n/// Uses [showDropdown] to present a [DropdownMenu] overlay with labels,\n/// dividers, buttons, and a nested submenu.\nclass DropdownMenuExample1 extends StatelessWidget {\n  const DropdownMenuExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return OutlineButton(\n      onPressed: () {\n        // Show the dropdown relative to the button.\n        showDropdown(\n          context: context,\n          builder: (context) {\n            return DropdownMenu(\n              children: [\n                const MenuLabel(child: Text('My Account')),\n                const MenuDivider(),\n                const MenuButton(\n                  child: Text('Profile'),\n                ),\n                const MenuButton(\n                  child: Text('Billing'),\n                ),\n                const MenuButton(\n                  child: Text('Settings'),\n                ),\n                const MenuButton(\n                  child: Text('Keyboard shortcuts'),\n                ),\n                const MenuDivider(),\n                const MenuButton(\n                  child: Text('Team'),\n                ),\n                const MenuButton(\n                  // Demonstrates a nested submenu.\n                  subMenu: [\n                    MenuButton(\n                      child: Text('Email'),\n                    ),\n                    MenuButton(\n                      child: Text('Message'),\n                    ),\n                    MenuDivider(),\n                    MenuButton(\n                      child: Text('More...'),\n                    ),\n                  ],\n                  child: Text('Invite users'),\n                ),\n                const MenuButton(\n                  child: Text('New Team'),\n                ),\n                const MenuDivider(),\n                const MenuButton(\n                  child: Text('GitHub'),\n                ),\n                const MenuButton(\n                  child: Text('Support'),\n                ),\n                const MenuButton(\n                  enabled: false,\n                  child: Text('API'),\n                ),\n                const MenuButton(\n                  child: Text('Log out'),\n                ),\n              ],\n            );\n          },\n        ).future.then((_) {\n          // Called when the dropdown is closed.\n          if (kDebugMode) {\n            print('Closed');\n          }\n        });\n      },\n      child: const Text('Open'),\n    );\n  }\n}\n",
);

Widget _buildDropdownMenuExample1(BuildContext context) {
  return const DropdownMenuExample1();
}

const List<ComponentExample> dropdownMenuExamples = [
  dropdownMenuExample1,
];
