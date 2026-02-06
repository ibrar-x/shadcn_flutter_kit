part of '../../dialog.dart';

class _DialogOverlayWrapper<T> extends StatefulWidget {
  final DialogRoute<T> route;
  final Widget child;

  const _DialogOverlayWrapper({
    super.key,
    required this.route,
    required this.child,
  });

  @override
  State<_DialogOverlayWrapper<T>> createState() =>
      _DialogOverlayWrapperState<T>();
}
