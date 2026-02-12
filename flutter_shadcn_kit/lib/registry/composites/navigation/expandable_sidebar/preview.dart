import 'package:flutter/material.dart';

import 'expandable_sidebar.dart';

/// Preview for `ExpandableSidebar` composite usage.
class ExpandableSidebarPreview extends StatefulWidget {
  const ExpandableSidebarPreview({super.key});

  @override
  State<ExpandableSidebarPreview> createState() =>
      _ExpandableSidebarPreviewState();
}

class _ExpandableSidebarPreviewState extends State<ExpandableSidebarPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandableSidebar(
        selectedIndex: _index,
        outlined: true,
        railExpanded: false,
        onSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        destinations: const [
          ExpandableSidebarDestination(
            icon: Icon(Icons.home_outlined),
            label: Text('Home'),
          ),
          ExpandableSidebarDestination(
            icon: Icon(Icons.explore_outlined),
            label: Text('Explore'),
          ),
          ExpandableSidebarDestination(
            icon: Icon(Icons.settings_outlined),
            label: Text('Settings'),
          ),
        ],
        pages: [
          _Page(title: 'Home'),
          _Page(title: 'Explore'),
          _Page(title: 'Settings'),
        ],
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
