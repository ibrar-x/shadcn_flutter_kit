part of '../../navigation_bar.dart';

/// _NavigationChildOverflowHandle defines a reusable type for this registry module.
class _NavigationChildOverflowHandle extends StatelessWidget {
/// Stores `overflow` state/configuration for this implementation.
  final NavigationOverflow overflow;
/// Stores `child` state/configuration for this implementation.
  final Widget child;

/// Creates a `_NavigationChildOverflowHandle` instance.
  const _NavigationChildOverflowHandle({
    required this.overflow,
    required this.child,
  });

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    switch (overflow) {
      case NavigationOverflow.clip:
        return ClipRect(child: child);
      case NavigationOverflow.marquee:
        return OverflowMarquee(child: child);
      case NavigationOverflow.ellipsis:
        return DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: child,
        );
      case NavigationOverflow.none:
        return child;
    }
  }
}
