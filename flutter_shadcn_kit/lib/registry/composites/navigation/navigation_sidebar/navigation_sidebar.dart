import 'package:flutter/widgets.dart';

import '../../../components/layout/outlined_container/outlined_container.dart'
    /// Stores `layout` state/configuration for this implementation.
    as layout;
import '../../../components/navigation/navigation_bar/navigation_bar.dart'
    /// Stores `nav` state/configuration for this implementation.
    as nav;

/// Type alias for `NavigationSidebar` used by public or internal APIs.
typedef NavigationSidebar = nav.NavigationSidebar;

/// Type alias for `NavigationItem` used by public or internal APIs.
typedef NavigationItem = nav.NavigationItem;

/// Type alias for `NavigationDivider` used by public or internal APIs.
typedef NavigationDivider = nav.NavigationDivider;

/// Type alias for `NavigationLabel` used by public or internal APIs.
typedef NavigationLabel = nav.NavigationLabel;

/// Type alias for `NavigationGap` used by public or internal APIs.
typedef NavigationGap = nav.NavigationGap;

/// Type alias for `NavigationLabelType` used by public or internal APIs.
typedef NavigationLabelType = nav.NavigationLabelType;

/// Type alias for `NavigationLabelPosition` used by public or internal APIs.
typedef NavigationLabelPosition = nav.NavigationLabelPosition;

/// Type alias for `NavigationButton` used by public or internal APIs.
typedef NavigationButton = nav.NavigationButton;

/// Type alias for `OutlinedContainer` used by public or internal APIs.
typedef OutlinedContainer = layout.OutlinedContainer;

/// Descriptor for a sidebar destination item.
class SidebarDestination {
  /// Creates a `SidebarDestination` instance.
  const SidebarDestination({required this.icon, required this.label});

  /// Stores `icon` state/configuration for this implementation.
  final Widget icon;

  /// Stores `label` state/configuration for this implementation.
  final Widget label;
}

/// Fully functional sidebar composite with built-in selection handling.
class SidebarNavigation extends StatefulWidget {
  /// Creates a `SidebarNavigation` instance.
  const SidebarNavigation({
    super.key,
    required this.destinations,
    this.selectedIndex,
    this.initialIndex = 0,
    this.onSelected,
    this.contentBuilder,
    this.pages,
    this.backgroundColor,
    this.spacing,
    this.labelType = NavigationLabelType.expanded,
    this.labelPosition = NavigationLabelPosition.end,
    this.padding,
    this.constraints,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded = true,
    this.keepCrossAxisSize = false,
    this.keepMainAxisSize = false,
    this.outlined = false,
  }) : assert(destinations.length > 0, 'destinations cannot be empty.');

  /// Stores `destinations` state/configuration for this implementation.
  final List<SidebarDestination> destinations;

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

  /// Stores `keepCrossAxisSize` state/configuration for this implementation.
  final bool keepCrossAxisSize;

  /// Stores `keepMainAxisSize` state/configuration for this implementation.
  final bool keepMainAxisSize;

  /// Stores `outlined` state/configuration for this implementation.
  final bool outlined;

  @override
  /// Executes `createState` behavior for this component/composite.
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
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

  /// Executes `_buildSidebar` behavior for this component/composite.
  Widget _buildSidebar() {
    final sidebar = NavigationSidebar(
      backgroundColor: widget.backgroundColor,
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
      keepCrossAxisSize: widget.keepCrossAxisSize,
      keepMainAxisSize: widget.keepMainAxisSize,
      children: [
        for (final destination in widget.destinations)
          NavigationItem(child: destination.icon, label: destination.label),
      ],
    );
    if (!widget.outlined) {
      return sidebar;
    }
    return OutlinedContainer(child: sidebar);
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSidebar(),
        Expanded(child: _buildBody()),
      ],
    );
  }
}
