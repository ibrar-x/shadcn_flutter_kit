import 'package:flutter/material.dart' hide Checkbox;

import '../checkbox/checkbox.dart';

part '_impl/state/_checkbox_preview_state.dart';

/// CheckboxPreview represents a form-related type in the registry.
class CheckboxPreview extends StatefulWidget {
  const CheckboxPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<CheckboxPreview> createState() => _CheckboxPreviewState();
}
