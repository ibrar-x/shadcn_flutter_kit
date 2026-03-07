import 'dart:async';

import 'package:flutter/foundation.dart' as f;
import 'package:flutter/material.dart' as m;

import 'markdown.dart';
import '../text_animate/text_animate.dart' as ta;
import '../text_animate/_impl/extensions/markdown_streaming_extension.dart';

part '_impl/state/_markdown_preview_state.dart';

class MarkdownPreview extends m.StatefulWidget {
  const MarkdownPreview({super.key});

  @override
  m.State<MarkdownPreview> createState() => _MarkdownPreviewState();
}
