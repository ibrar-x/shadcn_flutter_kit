import 'package:flutter/widgets.dart';
import '../../display/border_loading/border_loading.dart';

import '../../layout/scaffold/scaffold.dart';
import '../../control/button/button.dart';
import '../file_picker/file_picker.dart';
import '../../../shared/theme/theme.dart';
import '../file_input/file_input.dart';

part '_impl/state/_file_picker_preview_state.dart';

/// FilePickerPreview represents a form-related type in the registry.
class FilePickerPreview extends StatefulWidget {
  const FilePickerPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<FilePickerPreview> createState() => _FilePickerPreviewState();
}
