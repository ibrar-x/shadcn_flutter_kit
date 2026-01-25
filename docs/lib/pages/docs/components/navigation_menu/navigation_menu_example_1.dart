import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/clickable/clickable.dart'
    as shadcn_clickable;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/components/navigation/navigation_menu/navigation_menu.dart'
    as shadcn_nav_menu;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample navigationMenuExample1 = ComponentExample(
  title: 'Content lists',
  builder: _buildNavigationMenuExample1,
  code: '''NavigationMenu(
  children: [
    NavigationMenuItem(content: NavigationMenuContentList(...), child: Text('Getting started')),
    NavigationMenuItem(content: NavigationMenuContentList(...), child: Text('Components')),
  ],
)''',
);

Widget _buildNavigationMenuExample1(BuildContext context) {
  return const _NavigationMenuExample1();
}

class _NavigationMenuExample1 extends StatelessWidget {
  const _NavigationMenuExample1();

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    return shadcn_nav_menu.NavigationMenu(
      children: [
        shadcn_nav_menu.NavigationMenuItem(
          content: shadcn_nav_menu.NavigationMenuContentList(
            reverse: true,
            children: [
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Introduction'),
                content: const Text(
                  'Component library for Flutter based on Shadcn/UI design.',
                ),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Installation'),
                content: const Text(
                  'How to install this package in your Flutter project.',
                ),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Typography'),
                content: const Text(
                  'Styles and usage of typography in this package.',
                ),
                onPressed: () {},
              ),
              shadcn_clickable.Clickable(
                mouseCursor:
                    const WidgetStatePropertyAll(SystemMouseCursors.click),
                child: shadcn_card.Card(
                  borderRadius: theme.borderRadiusMd,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const FlutterLogo(size: 32),
                      gap(16),
                      const Text('shadcn_flutter').mono().semiBold().large(),
                      gap(8),
                      const Text(
                        'Beautifully designed components from Shadcn/UI is now available for Flutter',
                      ).muted(),
                    ],
                  ),
                ).constrained(maxWidth: 192),
              ),
            ],
          ),
          child: const Text('Getting started'),
        ),
        shadcn_nav_menu.NavigationMenuItem(
          content: shadcn_nav_menu.NavigationMenuContentList(
            children: [
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Accordion'),
                content: const Text('Accordion component for Flutter.'),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Alert'),
                content: const Text('Alert component for Flutter.'),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Alert Dialog'),
                content: const Text('Alert Dialog component for Flutter.'),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Animation'),
                content: const Text('Animation component for Flutter.'),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Avatar'),
                content: const Text('Avatar component for Flutter.'),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Badge'),
                content: const Text('Badge component for Flutter.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Components'),
        ),
        shadcn_nav_menu.NavigationMenuItem(
          content: shadcn_nav_menu.NavigationMenuContentList(
            crossAxisCount: 2,
            children: [
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Latest news'),
                content: const Text('Stay updated with the latest news.'),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Change log'),
                content: const Text('View the change log of this package.'),
                onPressed: () {},
              ),
              shadcn_nav_menu.NavigationMenuContent(
                title: const Text('Contributors'),
                content: const Text('List of contributors to this package.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Blog'),
        ),
        shadcn_nav_menu.NavigationMenuItem(
          onPressed: () {},
          child: const Text('Documentation'),
        ),
      ],
    );
  }
}
