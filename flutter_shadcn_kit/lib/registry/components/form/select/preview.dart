import 'package:flutter/material.dart';
import '../select/select.dart';
import 'select.dart';

part '_impl/state/_select_preview_state.dart';

/// SelectPreview represents a form-related type in the registry.
class SelectPreview extends StatefulWidget {
  const SelectPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<SelectPreview> createState() => _SelectPreviewState();
}
