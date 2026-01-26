import 'package:data_widget/data_widget.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:gap/gap.dart';

import '../../../shared/primitives/text.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/util.dart';
import '../../control/button/button.dart';

part '_impl/collapsible_content.dart';
part '_impl/collapsible_state_data.dart';
part '_impl/collapsible_theme.dart';
part '_impl/collapsible_trigger.dart';

/// Expandable layout that keeps its own open/close state by default.
class Collapsible extends StatefulWidget {
  /// Creates a widget that expands/collapses a set of children.
  const Collapsible({
    super.key,
    required this.children,
    this.isExpanded,
    this.onExpansionChanged,
  });

  /// Children are usually a trigger followed by one or more content widgets.
  final List<Widget> children;

  /// Controls the initial expansion for uncontrolled mode.
  final bool? isExpanded;

  /// Called when the user toggles the collapse state.
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<Collapsible> createState() => CollapsibleState();
}

/// Tracks the current expansion state and exposes an event for children.
class CollapsibleState extends State<Collapsible> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded ?? false;
  }

  @override
  void didUpdateWidget(covariant Collapsible oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != null) {
      _isExpanded = widget.isExpanded!;
    }
  }

  void _handleTap() {
    if (widget.onExpansionChanged != null) {
      widget.onExpansionChanged!(_isExpanded);
    } else {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<CollapsibleTheme>(context);

    return Data.inherit(
      data: CollapsibleStateData(
        isExpanded: _isExpanded,
        handleTap: _handleTap,
      ),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment:
              compTheme?.crossAxisAlignment ?? CrossAxisAlignment.stretch,
          mainAxisAlignment:
              compTheme?.mainAxisAlignment ?? MainAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}
