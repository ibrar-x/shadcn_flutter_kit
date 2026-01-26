import 'package:flutter/material.dart' hide Card, Divider, NavigationBar, Checkbox;

import '../../control/button/button.dart' as shadcn_button;
import '../../../shared/primitives/outlined_container.dart';
import '../../layout/card/card.dart';
import '../../form/checkbox/checkbox.dart';
import '../../display/divider/divider.dart';
import '../navigation_bar/navigation_bar.dart';
import '../../overlay/popover/popover.dart';
import '../../layout/scaffold/scaffold.dart' as shadcn_scaffold;
import '../../form/select/select.dart';

class NavigationBarPreview extends StatefulWidget {
  const NavigationBarPreview({super.key});

  @override
  State<NavigationBarPreview> createState() => _NavigationBarPreviewState();
}

class _NavigationBarPreviewState extends State<NavigationBarPreview> {
  int selected = 0;

  NavigationBarAlignment alignment = NavigationBarAlignment.spaceAround;
  bool expands = true;
  NavigationLabelType labelType = NavigationLabelType.none;
  bool customButtonStyle = true;
  bool expanded = true;

  NavigationItem buildButton(String label, IconData icon) {
    return NavigationItem(
      style: customButtonStyle
          ? const shadcn_button.ButtonStyle.muted(
              density: shadcn_button.ButtonDensity.icon,
            )
          : null,
      selectedStyle: customButtonStyle
          ? const shadcn_button.ButtonStyle.fixed(
              density: shadcn_button.ButtonDensity.icon,
            )
          : null,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      width: 500,
      height: 400,
      child: shadcn_scaffold.Scaffold(
        footers: [
          const Divider(),
          NavigationBar(
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
          child: Card(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              spacing: 8,
              children: [
                Select<NavigationBarAlignment>(
                  value: alignment,
                  itemBuilder:
                      (BuildContext context, NavigationBarAlignment item) {
                    return Text(item.name);
                  },
                  popupWidthConstraint: PopoverConstraint.anchorFixedSize,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        alignment = value;
                      });
                    }
                  },
                  popup: SelectPopup(
                    items: SelectItemList(
                      children: [
                        for (var value in NavigationBarAlignment.values)
                          SelectItemButton(
                            value: value,
                            child: Text(value.name),
                          ),
                      ],
                    ),
                  ).call,
                ),
                Select<NavigationLabelType>(
                  value: labelType,
                  itemBuilder:
                      (BuildContext context, NavigationLabelType item) {
                    return Text(item.name);
                  },
                  popupWidthConstraint: PopoverConstraint.anchorFixedSize,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        labelType = value;
                      });
                    }
                  },
                  popup: SelectPopup(
                    items: SelectItemList(
                      children: [
                        for (var value in NavigationLabelType.values)
                          SelectItemButton(
                            value: value,
                            child: Text(value.name),
                          ),
                      ],
                    ),
                  ).call,
                ),
                Checkbox(
                  state:
                      expands ? CheckboxState.checked : CheckboxState.unchecked,
                  onChanged: (value) {
                    setState(() {
                      expands = value == CheckboxState.checked;
                    });
                  },
                  trailing: const Text('Expands'),
                ),
                Checkbox(
                  state: customButtonStyle
                      ? CheckboxState.checked
                      : CheckboxState.unchecked,
                  onChanged: (value) {
                    setState(() {
                      customButtonStyle = value == CheckboxState.checked;
                    });
                  },
                  trailing: const Text('Custom Button Style'),
                ),
                Checkbox(
                  state:
                      expanded ? CheckboxState.checked : CheckboxState.unchecked,
                  onChanged: (value) {
                    setState(() {
                      expanded = value == CheckboxState.checked;
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
