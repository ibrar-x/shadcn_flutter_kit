part of '../../navigation_bar.dart';

abstract class _AbstractNavigationButtonState<
  T extends AbstractNavigationButton
>
    extends State<T> {
  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<NavigationControlData>(context);
    final childData = Data.maybeOf<NavigationChildControlData>(context);
    if (data?.containerType == NavigationContainerType.sidebar) {
      return buildSliver(context, data, childData);
    }
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.tooltip) {
      return buildTooltip(context, data, childData);
    }
    return _buildBox(context, data, childData);
  }

  Widget buildTooltip(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    if (widget.label == null) {
      return buildBox(context, data, childData);
    }
    AlignmentGeometry alignment = Alignment.topCenter;
    AlignmentGeometry anchorAlignment = Alignment.bottomCenter;
    if (data?.direction == Axis.vertical) {
      alignment = AlignmentDirectional.centerStart;
      anchorAlignment = AlignmentDirectional.centerEnd;
    }
    return Tooltip(
      waitDuration: !isMobile(Theme.of(context).platform)
          ? Duration.zero
          : const Duration(milliseconds: 500),
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      tooltip: TooltipContainer(child: widget.label!).call,
      child: buildBox(context, data, childData),
    );
  }

  Widget buildSliver(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    final labelType = data?.parentLabelType ?? NavigationLabelType.none;
    if (labelType == NavigationLabelType.tooltip) {
      return SliverToBoxAdapter(child: buildTooltip(context, data, childData));
    }
    return SliverToBoxAdapter(child: _buildBox(context, data, childData));
  }

  Widget _buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  ) {
    if (childData == null) {
      return buildBox(context, data, null);
    }
    return RepaintBoundary.wrap(
      buildBox(context, data, childData),
      childData.actualIndex,
    );
  }

  Widget buildBox(
    BuildContext context,
    NavigationControlData? data,
    NavigationChildControlData? childData,
  );
}
