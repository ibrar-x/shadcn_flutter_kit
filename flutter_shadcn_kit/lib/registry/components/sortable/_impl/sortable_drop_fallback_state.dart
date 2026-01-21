part of '../sortable.dart';

class _SortableDropFallbackState<T> extends State<SortableDropFallback<T>> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
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

