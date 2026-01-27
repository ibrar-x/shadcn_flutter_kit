import 'package:flutter/widgets.dart';

import 'scroll_view_interceptor_state.dart';

/// Widget that intercepts scroll events to simulate middle-button drag scrolling.
class ScrollViewInterceptor extends StatefulWidget {
  final Widget child;
  final bool enabled;

  const ScrollViewInterceptor({
    super.key,
    required this.child,
    this.enabled = true,
  });

  @override
  State<ScrollViewInterceptor> createState() => ScrollViewInterceptorState();
}
