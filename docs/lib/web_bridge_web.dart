import 'dart:js_interop';

import 'package:web/web.dart' as web;

void dispatchWebAppReady() {
  try {
    final readyEvent = web.CustomEvent('shadcn_flutter_app_ready');
    web.window.dispatchEvent(readyEvent);
  } catch (_) {
    // Ignore if not available.
  }
}

void dispatchWebThemeChanged(Map<String, String> colors) {
  try {
    final themeEvent = web.CustomEvent(
      'shadcn_flutter_theme_changed',
      web.CustomEventInit(detail: colors.jsify()),
    );
    web.window.dispatchEvent(themeEvent);
  } catch (_) {
    // Ignore if not available.
  }
}
