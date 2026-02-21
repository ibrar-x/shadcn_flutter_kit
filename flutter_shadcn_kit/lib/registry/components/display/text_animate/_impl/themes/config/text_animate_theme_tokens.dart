import 'package:flutter/widgets.dart';

import '../../../text_animate.dart';

// ═══════════════════════════════════════════════════════════
// COMPONENT THEME TOKENS
// User customization layer (replace this file from website output)
// Defaults intentionally mirror TextAnimateThemeDefaults
// ═══════════════════════════════════════════════════════════

class TextAnimateThemeTokens {
  const TextAnimateThemeTokens({
    this.style = const TextStyle(),
    this.typewriter = const TypewriterEffect(),
    this.effect = const NoEffect(),
    this.cursor = const StreamingCursor.none(),
    this.ignoreGlobalScaling = false,
    this.ignoreGlobalRadius = false,
  });

  final TextStyle style;
  final TypewriterEffect typewriter;
  final StreamingTextEffectAdapter effect;
  final StreamingCursor cursor;
  final bool ignoreGlobalScaling;
  final bool ignoreGlobalRadius;
}

const textAnimateThemeTokens = TextAnimateThemeTokens();
