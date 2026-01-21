import 'package:flutter/material.dart';

import '../tab_container/tab_container.dart';

class TabContainerPreview extends StatefulWidget {
  const TabContainerPreview({super.key});

  @override
  State<TabContainerPreview> createState() => _TabContainerPreviewState();
}

class _TabContainerPreviewState extends State<TabContainerPreview> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: TabContainer(
            selected: _selected,
            onSelect: (index) => setState(() => _selected = index),
            builder: (context, children) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                  const SizedBox(height: 16),
                  Text('Selected tab: ${_selected + 1}'),
                ],
              );
            },
            childBuilder: (context, data, child) {
              final selected = data.selected == data.index;
              return GestureDetector(
                onTap: () => data.onSelect?.call(data.index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    child: child,
                  ),
                ),
              );
            },
            children: const [
              TabItem(child: Text('Overview')),
              TabItem(child: Text('Details')),
              TabItem(child: Text('Reviews')),
            ],
          ),
        ),
      ),
    );
  }
}
