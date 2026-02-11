import 'package:flutter/material.dart' show VerticalDivider;
import 'package:flutter/widgets.dart';

import '../../../components/layout/outlined_container/outlined_container.dart'
    /// Stores `layout` state/configuration for this implementation.
    as layout;
import '../../../components/navigation/navigation_bar/navigation_bar.dart'
    /// Stores `nav` state/configuration for this implementation.
    as nav;

/// Type alias for `NavigationRail` used by public or internal APIs.
typedef NavigationRail = nav.NavigationRail;

/// Type alias for `NavigationButton` used by public or internal APIs.
typedef NavigationButton = nav.NavigationButton;

/// Type alias for `NavigationItem` used by public or internal APIs.
typedef NavigationItem = nav.NavigationItem;

/// Type alias for `NavigationLabel` used by public or internal APIs.
typedef NavigationLabel = nav.NavigationLabel;

/// Type alias for `NavigationDivider` used by public or internal APIs.
typedef NavigationDivider = nav.NavigationDivider;

/// Type alias for `NavigationRailAlignment` used by public or internal APIs.
typedef NavigationRailAlignment = nav.NavigationRailAlignment;

/// Type alias for `NavigationLabelType` used by public or internal APIs.
typedef NavigationLabelType = nav.NavigationLabelType;

/// Type alias for `NavigationLabelPosition` used by public or internal APIs.
typedef NavigationLabelPosition = nav.NavigationLabelPosition;

/// Type alias for `OutlinedContainer` used by public or internal APIs.
typedef OutlinedContainer = layout.OutlinedContainer;

/// Descriptor for a single destination in [ExpandableSidebar].
class ExpandableSidebarDestination {
  /// Creates a `ExpandableSidebarDestination` instance.
  const ExpandableSidebarDestination({required this.icon, required this.label});

  /// Stores `icon` state/configuration for this implementation.
  final Widget icon;

  /// Stores `label` state/configuration for this implementation.
  final Widget label;
}

/// ExpandableSidebar defines a reusable type for this registry module.
class ExpandableSidebar extends StatefulWidget {
  /// Creates a `ExpandableSidebar` instance.
  const ExpandableSidebar({
    super.key,
    this.rail,
    this.destinations = const <ExpandableSidebarDestination>[],
    this.selectedIndex,
    this.initialIndex = 0,
    this.onSelected,
    this.contentBuilder,
    this.pages,
    this.railAlignment = NavigationRailAlignment.start,
    this.railLabelType = NavigationLabelType.selected,
    this.railLabelPosition = NavigationLabelPosition.bottom,
    this.railExpanded = true,
    this.content,
    this.divider = const VerticalDivider(),
    this.outlined = false,
    this.width,
    this.height,
  }) : assert(
         rail != null || destinations.length > 0,
         'Provide either rail or at least one destination.',
       );

  /// Stores `rail` state/configuration for this implementation.
  final NavigationRail? rail;

  /// Stores `destinations` state/configuration for this implementation.
  final List<ExpandableSidebarDestination> destinations;

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

  /// Stores `railAlignment` state/configuration for this implementation.
  final NavigationRailAlignment railAlignment;

  /// Stores `railLabelType` state/configuration for this implementation.
  final NavigationLabelType railLabelType;

  /// Stores `railLabelPosition` state/configuration for this implementation.
  final NavigationLabelPosition railLabelPosition;

  /// Stores `railExpanded` state/configuration for this implementation.
  final bool railExpanded;

  /// Stores `content` state/configuration for this implementation.
  final Widget? content;

  /// Stores `divider` state/configuration for this implementation.
  final Widget divider;

  /// Stores `outlined` state/configuration for this implementation.
  final bool outlined;

  /// Stores `width` state/configuration for this implementation.
  final double? width;

  /// Stores `height` state/configuration for this implementation.
  final double? height;

  @override
  /// Executes `createState` behavior for this component/composite.
  State<ExpandableSidebar> createState() => _ExpandableSidebarState();
}

class _ExpandableSidebarState extends State<ExpandableSidebar> {
  late int _index;

  int get _effectiveIndex => widget.selectedIndex ?? _index;

  @override
  /// Executes `initState` behavior for this component/composite.
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  /// Executes `didUpdateWidget` behavior for this component/composite.
  void didUpdateWidget(covariant ExpandableSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex == null &&
        oldWidget.initialIndex != widget.initialIndex) {
      _index = widget.initialIndex;
    }
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
  NavigationRail _buildRail() {
    if (widget.rail != null) {
      return widget.rail!;
    }
    return NavigationRail(
      alignment: widget.railAlignment,
      labelType: widget.railLabelType,
      labelPosition: widget.railLabelPosition,
      expanded: widget.railExpanded,
      index: _effectiveIndex,
      onSelected: _handleSelected,
      children: [
        for (final destination in widget.destinations)
          NavigationItem(child: destination.icon, label: destination.label),
      ],
    );
  }

  /// Executes `_buildContent` behavior for this component/composite.
  Widget _buildContent() {
    if (widget.content != null) {
      return widget.content!;
    }
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
    final rail = _buildRail();
    final child = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        rail,
        widget.divider,

        /// Creates a `Expanded` instance.
        Expanded(child: _buildContent()),
      ],
    );
    if (!widget.outlined) {
      return SizedBox(width: widget.width, height: widget.height, child: child);
    }
    return OutlinedContainer(
      width: widget.width,
      height: widget.height,
      child: child,
    );
  }
}
