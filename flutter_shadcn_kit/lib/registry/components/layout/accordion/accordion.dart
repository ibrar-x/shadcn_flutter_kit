import 'dart:math';

import 'package:data_widget/data_widget.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter/services.dart';

import '../../../shared/primitives/text.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/constants.dart';

part '_impl/accordion_item.dart';
part '_impl/accordion_theme.dart';
part '_impl/accordion_trigger.dart';

/// A container of expandable sections where only one panel may be open at once.
class Accordion extends StatefulWidget {
  /// Creates an accordion with the provided [items].
  const Accordion({super.key, required this.items});

  /// The children that make up the accordion.
  final List<Widget> items;

  @override
  AccordionState createState() => AccordionState();
}

/// State helper that tracks the currently expanded item.
class AccordionState extends State<Accordion> {
  final ValueNotifier<_AccordionItemState?> _expanded = ValueNotifier(null);

  @override
  void dispose() {
    _expanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final accTheme = ComponentTheme.maybeOf<AccordionTheme>(context);
    final dividerColor = accTheme?.dividerColor ?? theme.colorScheme.muted;
    final dividerHeight = accTheme?.dividerHeight ?? 1 * scaling;

    final children = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      children.add(widget.items[i]);
      if (i < widget.items.length - 1) {
        children.add(Container(
          color: dividerColor,
          height: dividerHeight,
        ));
      }
    }
    children.add(const Divider());

    return Data.inherit(
      data: this,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
