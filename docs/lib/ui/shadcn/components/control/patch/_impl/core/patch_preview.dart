import 'package:flutter/material.dart';

import '../state/patch_preview_state.dart';

/// PatchPreview defines a reusable type for this registry module.
class PatchPreview extends StatefulWidget {
  const PatchPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<PatchPreview> createState() => PatchPreviewState();
}
