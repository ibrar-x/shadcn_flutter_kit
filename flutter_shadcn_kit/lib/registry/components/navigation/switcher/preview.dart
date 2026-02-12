import 'package:flutter/material.dart';

import '../switcher/switcher.dart';
part '_impl/state/_switcher_preview_state.dart';

/// SwitcherPreview defines a reusable type for this registry module.
class SwitcherPreview extends StatefulWidget {
  const SwitcherPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<SwitcherPreview> createState() => _SwitcherPreviewState();
}
