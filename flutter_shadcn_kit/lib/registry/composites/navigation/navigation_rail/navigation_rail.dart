import 'package:flutter/widgets.dart';

import '../../../components/navigation/navigation_bar/navigation_bar.dart'
    /// Stores `nav` state/configuration for this implementation.
    as nav;

/// Type alias for `NavigationRail` used by public or internal APIs.
typedef NavigationRail = nav.NavigationRail;

/// Type alias for `NavigationItem` used by public or internal APIs.
typedef NavigationItem = nav.NavigationItem;

/// Type alias for `NavigationDivider` used by public or internal APIs.
typedef NavigationDivider = nav.NavigationDivider;

/// Type alias for `NavigationLabel` used by public or internal APIs.
typedef NavigationLabel = nav.NavigationLabel;

/// Type alias for `NavigationGap` used by public or internal APIs.
typedef NavigationGap = nav.NavigationGap;

/// Type alias for `NavigationWidget` used by public or internal APIs.
typedef NavigationWidget = nav.NavigationWidget;

/// Type alias for `NavigationLabelType` used by public or internal APIs.
typedef NavigationLabelType = nav.NavigationLabelType;

/// Type alias for `NavigationLabelPosition` used by public or internal APIs.
typedef NavigationLabelPosition = nav.NavigationLabelPosition;

/// Type alias for `NavigationRailAlignment` used by public or internal APIs.
typedef NavigationRailAlignment = nav.NavigationRailAlignment;

/// Type alias for `NavigationButton` used by public or internal APIs.
typedef NavigationButton = nav.NavigationButton;

/// Descriptor for a rail destination item.
class RailDestination {
  /// Creates a `RailDestination` instance.
  const RailDestination({required this.icon, required this.label});

  /// Stores `icon` state/configuration for this implementation.
  final Widget icon;

  /// Stores `label` state/configuration for this implementation.
  final Widget label;
}

/// Fully functional navigation rail composite with optional body switching.
class RailNavigation extends StatefulWidget {
  /// Creates a `RailNavigation` instance.
  const RailNavigation({
    super.key,
    required this.destinations,
    this.selectedIndex,
    this.initialIndex = 0,
    this.onSelected,
    this.contentBuilder,
    this.pages,
    this.backgroundColor,
    this.alignment = NavigationRailAlignment.start,
    this.direction = Axis.vertical,
    this.spacing,
    this.labelType = NavigationLabelType.selected,
    this.labelPosition = NavigationLabelPosition.bottom,
    this.padding,
    this.constraints,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded = true,
    this.keepMainAxisSize = false,
    this.keepCrossAxisSize = false,
  }) : assert(destinations.length > 0, 'destinations cannot be empty.');

  /// Stores `destinations` state/configuration for this implementation.
  final List<RailDestination> destinations;

  /// Stores `selectedIndex` state/configuration for this implementation.
  final int? selectedIndex;

  /// Stores `initialIndex` state/configuration for this implementation.
  final int initialIndex;

  /// Stores `onSelected` state/configuration for this implementation.
  final ValueChanged<int>? onSelected;

  /// Stores `contentBuilder` state/configuration for this implementation.
  final IndexedWidgetBuilder? contentBuilder;

  /// Stores `pages` state/configuration for this implementation.
  final List<Widget>? pages;

  /// Stores `backgroundColor` state/configuration for this implementation.
  final Color? backgroundColor;

  /// Stores `alignment` state/configuration for this implementation.
  final NavigationRailAlignment alignment;

  /// Stores `direction` state/configuration for this implementation.
  final Axis direction;

  /// Stores `spacing` state/configuration for this implementation.
  final double? spacing;

  /// Stores `labelType` state/configuration for this implementation.
  final NavigationLabelType labelType;

  /// Stores `labelPosition` state/configuration for this implementation.
  final NavigationLabelPosition labelPosition;

  /// Stores `padding` state/configuration for this implementation.
  final EdgeInsetsGeometry? padding;

  /// Stores `constraints` state/configuration for this implementation.
  final BoxConstraints? constraints;

  /// Stores `surfaceOpacity` state/configuration for this implementation.
  final double? surfaceOpacity;

  /// Stores `surfaceBlur` state/configuration for this implementation.
  final double? surfaceBlur;

  /// Stores `expanded` state/configuration for this implementation.
  final bool expanded;

  /// Stores `keepMainAxisSize` state/configuration for this implementation.
  final bool keepMainAxisSize;

  /// Stores `keepCrossAxisSize` state/configuration for this implementation.
  final bool keepCrossAxisSize;

  @override
  /// Executes `createState` behavior for this component/composite.
  State<RailNavigation> createState() => _RailNavigationState();
}

class _RailNavigationState extends State<RailNavigation> {
  late int _index;

  int get _effectiveIndex => widget.selectedIndex ?? _index;

  @override
  /// Executes `initState` behavior for this component/composite.
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  /// Executes `_handleSelected` behavior for this component/composite.
  void _handleSelected(int next) {
    if (widget.selectedIndex == null) {
      setState(() {
        _index = next;
      });
    }
    widget.onSelected?.call(next);
  }

  /// Executes `_buildRail` behavior for this component/composite.
  Widget _buildRail() {
    return NavigationRail(
      backgroundColor: widget.backgroundColor,
      alignment: widget.alignment,
      direction: widget.direction,
      spacing: widget.spacing,
      labelType: widget.labelType,
      labelPosition: widget.labelPosition,
      padding: widget.padding,
      constraints: widget.constraints,
      index: _effectiveIndex,
      onSelected: _handleSelected,
      surfaceOpacity: widget.surfaceOpacity,
      surfaceBlur: widget.surfaceBlur,
      expanded: widget.expanded,
      keepMainAxisSize: widget.keepMainAxisSize,
      keepCrossAxisSize: widget.keepCrossAxisSize,
      children: [
        for (final destination in widget.destinations)
          NavigationItem(child: destination.icon, label: destination.label),
      ],
    );
  }

  /// Executes `_buildBody` behavior for this component/composite.
  Widget _buildBody() {
    if (widget.contentBuilder != null) {
      return widget.contentBuilder!(context, _effectiveIndex);
    }
    if (widget.pages != null &&
        _effectiveIndex >= 0 &&
        _effectiveIndex < widget.pages!.length) {
      return widget.pages![_effectiveIndex];
    }
    return const SizedBox.shrink();
  }

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    if (widget.direction == Axis.horizontal) {
      return Column(
        children: [
          _buildRail(),
          Expanded(child: _buildBody()),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRail(),
        Expanded(child: _buildBody()),
      ],
    );
  }
}
