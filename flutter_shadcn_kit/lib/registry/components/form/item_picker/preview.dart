import 'package:flutter/material.dart';

import '../item_picker/item_picker.dart';

part '_impl/state/_item_picker_preview_state.dart';

/// ItemPickerPreview represents a form-related type in the registry.
class ItemPickerPreview extends StatefulWidget {
  const ItemPickerPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<ItemPickerPreview> createState() => _ItemPickerPreviewState();
}
