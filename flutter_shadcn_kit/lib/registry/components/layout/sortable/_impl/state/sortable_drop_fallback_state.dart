part of '../../sortable.dart';

/// _SortableDropFallbackState defines a reusable type for this registry module.
class _SortableDropFallbackState<T> extends State<SortableDropFallback<T>> {
  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
/// Creates a `Positioned.fill` instance.
        Positioned.fill(
          child: MetaData(
            behavior: HitTestBehavior.translucent,
            metaData: this,
          ),
        ),
        widget.child,
      ],
    );
  }
}
