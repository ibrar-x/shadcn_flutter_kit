import 'package:flutter/material.dart' show VerticalDivider;
import 'package:flutter/widgets.dart';

import '../../../components/layout/outlined_container/outlined_container.dart'
    as layout;
import '../../../components/navigation/navigation_bar/navigation_bar.dart'
    as nav;

typedef NavigationRail = nav.NavigationRail;
typedef NavigationButton = nav.NavigationButton;
typedef NavigationItem = nav.NavigationItem;
typedef NavigationLabel = nav.NavigationLabel;
typedef NavigationDivider = nav.NavigationDivider;
typedef NavigationRailAlignment = nav.NavigationRailAlignment;
typedef NavigationLabelType = nav.NavigationLabelType;
typedef NavigationLabelPosition = nav.NavigationLabelPosition;
typedef OutlinedContainer = layout.OutlinedContainer;

class ExpandableSidebar extends StatelessWidget {
  const ExpandableSidebar({
    super.key,
    required this.rail,
    this.content,
    this.divider = const VerticalDivider(),
    this.outlined = false,
    this.width,
    this.height,
  });

  final NavigationRail rail;
  final Widget? content;
  final Widget divider;
  final bool outlined;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        rail,
        divider,
        Expanded(child: content ?? const SizedBox.shrink()),
      ],
    );
    if (!outlined) {
      return SizedBox(width: width, height: height, child: child);
    }
    return OutlinedContainer(width: width, height: height, child: child);
  }
}
