import 'package:flutter/material.dart';

import '../tab_container/tab_container.dart';
import '../tab_list/tab_list.dart';

class TabListPreview extends StatefulWidget {
  const TabListPreview({super.key});

  @override
  State<TabListPreview> createState() => _TabListPreviewState();
}

class _TabListPreviewState extends State<TabListPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabList(
                index: _index,
                onChanged: (value) => setState(() => _index = value),
                children: const [
                  TabChildWidget(indexed: true, child: Text('General')),
                  TabChildWidget(indexed: true, child: Text('Billing')),
                  TabChildWidget(indexed: true, child: Text('Security')),
                ],
              ),
              const SizedBox(height: 16),
              Text('Active tab: ${_index + 1}'),
            ],
          ),
        ),
      ),
    );
  }
}
