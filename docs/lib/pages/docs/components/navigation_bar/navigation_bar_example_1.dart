import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/display/divider/divider.dart'
    as shadcn_divider;
import '../../../../ui/shadcn/components/form/checkbox/checkbox.dart'
    as shadcn_checkbox;
import '../../../../ui/shadcn/components/form/select/select.dart'
    as shadcn_select;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/scaffold/scaffold.dart'
    as shadcn_scaffold;
import '../../../../ui/shadcn/components/navigation/navigation_bar/navigation_bar.dart'
    as shadcn_navbar;
import '../../../../ui/shadcn/components/overlay/popover/popover.dart'
    as shadcn_popover;

const ComponentExample navigationBarExample1 = ComponentExample(
  title: 'Configurator',
  builder: _buildNavigationBarExample1,
  code: '''NavigationBar(
  alignment: alignment,
  labelType: labelType,
  expanded: expanded,
  expands: expands,
  onSelected: (index) => setState(() => selected = index),
  index: selected,
  children: [
    NavigationItem(label: Text('Home'), child: Icon(Icons.home)),
  ],
)''',
);

Widget _buildNavigationBarExample1(BuildContext context) {
  return const _NavigationBarExample1();
}

class _NavigationBarExample1 extends StatefulWidget {
  const _NavigationBarExample1();

  @override
  State<_NavigationBarExample1> createState() => _NavigationBarExample1State();
}

class _NavigationBarExample1State extends State<_NavigationBarExample1> {
  int selected = 0;

  shadcn_navbar.NavigationBarAlignment alignment =
      shadcn_navbar.NavigationBarAlignment.spaceAround;
  bool expands = true;
  shadcn_navbar.NavigationLabelType labelType =
      shadcn_navbar.NavigationLabelType.none;
  bool customButtonStyle = true;
  bool expanded = true;

  shadcn_navbar.NavigationItem buildButton(String label, IconData icon) {
    return shadcn_navbar.NavigationItem(
      style: customButtonStyle
          ? const shadcn_buttons.ButtonStyle.muted(
              density: shadcn_buttons.ButtonDensity.icon,
            )
          : null,
      selectedStyle: customButtonStyle
          ? const shadcn_buttons.ButtonStyle.fixed(
              density: shadcn_buttons.ButtonDensity.icon,
            )
          : null,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_outlined.OutlinedContainer(
      width: 500,
      height: 400,
      child: shadcn_scaffold.Scaffold(
        footers: [
          const shadcn_divider.Divider(),
          shadcn_navbar.NavigationBar(
            alignment: alignment,
            labelType: labelType,
            expanded: expanded,
            expands: expands,
            onSelected: (index) {
              setState(() {
                selected = index;
              });
            },
            index: selected,
            children: [
              buildButton('Home', Icons.home_outlined),
              buildButton('Explore', Icons.explore_outlined),
              buildButton('Library', Icons.library_music_outlined),
              buildButton('Profile', Icons.person_outline),
              buildButton('App', Icons.apps_outlined),
            ],
          ),
        ],
        child: Container(
          color: Colors.primaries[Colors.primaries.length - selected - 1],
          padding: const EdgeInsets.all(24),
          child: shadcn_card.Card(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              spacing: 8,
              children: [
                shadcn_select.Select<shadcn_navbar.NavigationBarAlignment>(
                  value: alignment,
                  itemBuilder: (
                    BuildContext context,
                    shadcn_navbar.NavigationBarAlignment item,
                  ) {
                    return Text(item.name);
                  },
                  popupWidthConstraint:
                      shadcn_popover.PopoverConstraint.anchorFixedSize,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        alignment = value;
                      });
                    }
                  },
                  popup: shadcn_select.SelectPopup(
                    items: shadcn_select.SelectItemList(
                      children: [
                        for (var value
                            in shadcn_navbar.NavigationBarAlignment.values)
                          shadcn_select.SelectItemButton(
                            value: value,
                            child: Text(value.name),
                          ),
                      ],
                    ),
                  ),
                ),
                shadcn_select.Select<shadcn_navbar.NavigationLabelType>(
                  value: labelType,
                  itemBuilder: (
                    BuildContext context,
                    shadcn_navbar.NavigationLabelType item,
                  ) {
                    return Text(item.name);
                  },
                  popupWidthConstraint:
                      shadcn_popover.PopoverConstraint.anchorFixedSize,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        labelType = value;
                      });
                    }
                  },
                  popup: shadcn_select.SelectPopup(
                    items: shadcn_select.SelectItemList(
                      children: [
                        for (var value
                            in shadcn_navbar.NavigationLabelType.values)
                          shadcn_select.SelectItemButton(
                            value: value,
                            child: Text(value.name),
                          ),
                      ],
                    ),
                  ),
                ),
                shadcn_checkbox.Checkbox(
                  state: expands
                      ? shadcn_checkbox.CheckboxState.checked
                      : shadcn_checkbox.CheckboxState.unchecked,
                  onChanged: (value) {
                    setState(() {
                      expands = value == shadcn_checkbox.CheckboxState.checked;
                    });
                  },
                  trailing: const Text('Expands'),
                ),
                shadcn_checkbox.Checkbox(
                  state: customButtonStyle
                      ? shadcn_checkbox.CheckboxState.checked
                      : shadcn_checkbox.CheckboxState.unchecked,
                  onChanged: (value) {
                    setState(() {
                      customButtonStyle =
                          value == shadcn_checkbox.CheckboxState.checked;
                    });
                  },
                  trailing: const Text('Custom Button Style'),
                ),
                shadcn_checkbox.Checkbox(
                  state: expanded
                      ? shadcn_checkbox.CheckboxState.checked
                      : shadcn_checkbox.CheckboxState.unchecked,
                  onChanged: (value) {
                    setState(() {
                      expanded = value == shadcn_checkbox.CheckboxState.checked;
                    });
                  },
                  trailing: const Text('Expanded'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
