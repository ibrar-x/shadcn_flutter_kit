import 'package:flutter/material.dart';

import '../navigation_menu/navigation_menu.dart';

class NavigationMenuPreview extends StatelessWidget {
  const NavigationMenuPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NavigationMenu(
          children: [
            const NavigationMenuItem(
              content: NavigationMenuContentList(
                children: [
                  NavigationMenuContent(
                    title: Text('Web Apps'),
                    content: Text('Landing pages and dashboards.'),
                  ),
                  NavigationMenuContent(
                    title: Text('Mobile'),
                    content: Text('Native iOS and Android builds.'),
                  ),
                ],
              ),
              child: Text('Products'),
            ),
            const NavigationMenuItem(
              content: NavigationMenuContentList(
                children: [
                  NavigationMenuContent(
                    title: Text('About'),
                    content: Text('Team, culture, and careers.'),
                  ),
                  NavigationMenuContent(
                    title: Text('Blog'),
                    content: Text('Product updates and guides.'),
                  ),
                ],
              ),
              child: Text('Company'),
            ),
            NavigationMenuItem(
              onPressed: () {},
              child: const Text('Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
