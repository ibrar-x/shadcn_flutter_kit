import 'dart:async';

import 'package:flutter/material.dart' as m;

import 'text_animate.dart';

part '_impl/state/_text_animate_preview_state.dart';

/// Core class used by the text animate component.
class TextAnimatePreview extends m.StatefulWidget {
  const TextAnimatePreview({super.key});

  @override
  m.State<TextAnimatePreview> createState() => _TextAnimatePreviewState();
}
