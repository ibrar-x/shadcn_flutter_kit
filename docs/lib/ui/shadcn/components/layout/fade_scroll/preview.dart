import 'package:flutter/material.dart';
import '../fade_scroll/fade_scroll.dart';
part '_impl/state/_fade_scroll_preview_state.dart';

/// FadeScrollPreview defines a reusable type for this registry module.
class FadeScrollPreview extends StatefulWidget {
  const FadeScrollPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<FadeScrollPreview> createState() => _FadeScrollPreviewState();
}
