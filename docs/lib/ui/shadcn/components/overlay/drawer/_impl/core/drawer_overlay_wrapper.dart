part of '../../drawer.dart';

class _DrawerOverlayWrapper extends StatefulWidget {
  final Widget child;
  final Completer completer;
  const _DrawerOverlayWrapper({
    required this.child,
    required this.completer,
  });

  @override
  State<_DrawerOverlayWrapper> createState() => _DrawerOverlayWrapperState();
}
