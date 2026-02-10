part of '../../wrapper.dart';

class _WrapperState extends State<Wrapper> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget wrappedChild = widget.child;
    if (widget.maintainStructure) {
      wrappedChild = KeyedSubtree(key: _key, child: wrappedChild);
    }
    if (widget.wrap && widget.builder != null) {
      wrappedChild = widget.builder!(context, wrappedChild);
    }
    return wrappedChild;
  }
}
