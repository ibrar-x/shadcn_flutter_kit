import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/navigation/tab_container/tab_container.dart'
    as shadcn_tab_container;
import '../../../../ui/shadcn/components/navigation/tab_pane/tab_pane.dart'
    as shadcn_tab_pane;
import '../../../../ui/shadcn/shared/primitives/basic.dart' as shadcn_basic;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample tabPaneExample1 = ComponentExample(
  title: 'Closable tabs',
  builder: _buildTabPaneExample1,
  code: '''TabPane(
  items: tabs,
  itemBuilder: (context, item, index) => TabItem(...),
  focused: focused,
)''',
);

Widget _buildTabPaneExample1(BuildContext context) {
  return const _TabPaneExample1();
}

class _TabPaneExample1 extends StatefulWidget {
  const _TabPaneExample1();

  @override
  State<_TabPaneExample1> createState() => _TabPaneExample1State();
}

class MyTab {
  final String title;
  final int count;
  final String content;
  MyTab(this.title, this.count, this.content);

  @override
  String toString() {
    return 'TabData{title: $title, count: $count, content: $content}';
  }
}

class _TabPaneExample1State extends State<_TabPaneExample1> {
  late List<shadcn_tab_pane.TabPaneData<MyTab>> tabs;
  int focused = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabs = [
      for (int i = 0; i < 3; i++)
        shadcn_tab_pane.TabPaneData(
          MyTab('Tab ${i + 1}', i + 1, 'Content ${i + 1}'),
        ),
    ];
  }

  shadcn_tab_container.TabItem _buildTabItem(MyTab data) {
    final theme = shadcn_theme.Theme.of(context);
    return shadcn_tab_container.TabItem(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 150),
        child: shadcn_basic.Label(
          leading: shadcn_outlined.OutlinedContainer(
            backgroundColor: Colors.white,
            width: 18,
            height: 18,
            borderRadius: theme.borderRadiusMd,
            child: Center(
              child: Text(
                data.count.toString(),
                style: const TextStyle(color: Colors.black),
              ).xSmall().bold(),
            ),
          ),
          trailing: shadcn_buttons.IconButton.ghost(
            shape: shadcn_buttons.ButtonShape.circle,
            size: shadcn_buttons.ButtonSize.xSmall,
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                tabs.remove(data);
              });
            },
          ),
          child: Text(data.title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_tab_pane.TabPane<MyTab>(
      items: tabs,
      itemBuilder: (context, item, index) {
        return _buildTabItem(item.data);
      },
      focused: focused,
      onFocused: (value) {
        setState(() {
          focused = value;
        });
      },
      onSort: (value) {
        setState(() {
          tabs = value;
        });
      },
      leading: [
        shadcn_buttons.IconButton.secondary(
          icon: const Icon(Icons.arrow_drop_down),
          size: shadcn_buttons.ButtonSize.small,
          density: shadcn_buttons.ButtonDensity.iconDense,
          onPressed: () {},
        ),
      ],
      trailing: [
        shadcn_buttons.IconButton.ghost(
          icon: const Icon(Icons.add),
          size: shadcn_buttons.ButtonSize.small,
          density: shadcn_buttons.ButtonDensity.iconDense,
          onPressed: () {
            setState(() {
              final max = tabs.fold<int>(0, (previousValue, element) {
                return element.data.count > previousValue
                    ? element.data.count
                    : previousValue;
              });
              tabs.add(
                shadcn_tab_pane.TabPaneData(
                  MyTab('Tab ${max + 1}', max + 1, 'Content ${max + 1}'),
                ),
              );
            });
          },
        ),
      ],
      child: SizedBox(
        height: 400,
        child: Center(
          child: Text('Tab ${focused + 1}').xLarge().bold(),
        ),
      ),
    );
  }
}
