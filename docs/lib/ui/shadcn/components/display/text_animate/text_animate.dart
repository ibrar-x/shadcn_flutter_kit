import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';

part '_impl/core/streaming_cursor.dart';
part '_impl/core/streaming_text_effect_adapter.dart';
part '_impl/core/typewriter_effect.dart';
part '_impl/core/blur_in_effect.dart';
part '_impl/core/combined_effect.dart';

part '_impl/styles/character_span_factory.dart';

part '_impl/utils/text_diff.dart';
part '_impl/utils/time_math.dart';

part '_impl/themes/text_animate_theme.dart';

part '_impl/state/streaming_text_state.dart';

/// Callback fired once when the latest text update has fully settled.
typedef StreamingTextSettled = void Function(String text);

/// Stream-aware text renderer for incremental text updates.
class StreamingText extends StatefulWidget {
  const StreamingText({
    super.key,
    required this.text,
    this.style,
    this.typewriter,
    this.effect,
    this.cursor,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.locale,
    this.onSettled,
  });

  /// Latest full text value received from the stream.
  final String text;

  /// Optional base style for rendered text.
  final TextStyle? style;

  /// Typewriter behavior for newly appended characters.
  final TypewriterEffect? typewriter;

  /// Visual effect applied to newly revealed characters.
  final StreamingTextEffectAdapter? effect;

  /// Cursor behavior.
  final StreamingCursor? cursor;

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Locale? locale;

  /// Invoked once each time a new text revision has completely settled.
  final StreamingTextSettled? onSettled;

  @override
  State<StreamingText> createState() => _StreamingTextState();
}
