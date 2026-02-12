import 'package:flutter/material.dart';

import '../state/hover_preview_state.dart';

/// HoverPreview defines a reusable type for this registry module.
class HoverPreview extends StatefulWidget {
  const HoverPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<HoverPreview> createState() => HoverPreviewState();
}
