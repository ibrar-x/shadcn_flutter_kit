import 'package:flutter/material.dart';
import '../autocomplete/autocomplete.dart';
import '../chip_input/chip_input.dart';
import '../../../shared/theme/theme.dart';

part '_impl/state/_chip_input_preview_state.dart';

/// ChipInputPreview renders form UI and wires input behavior.
class ChipInputPreview extends StatefulWidget {
  const ChipInputPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<ChipInputPreview> createState() => _ChipInputPreviewState();
}
