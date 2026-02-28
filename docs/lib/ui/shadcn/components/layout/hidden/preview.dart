import 'package:flutter/material.dart';
import '../hidden/hidden.dart';
part '_impl/state/_hidden_preview_state.dart';

/// HiddenPreview defines a reusable type for this registry module.
class HiddenPreview extends StatefulWidget {
  const HiddenPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<HiddenPreview> createState() => _HiddenPreviewState();
}
