import 'package:flutter/widgets.dart';

import '../../layout/scaffold/scaffold.dart';
import '../../control/button/button.dart';
import '../file_picker/file_picker.dart';
import '../../../shared/theme/theme.dart';
import '../file_input/file_input.dart';

part '_impl/state/_file_picker_preview_state.dart';

class FilePickerPreview extends StatefulWidget {
  const FilePickerPreview({super.key});

  @override
  State<FilePickerPreview> createState() => _FilePickerPreviewState();
}
