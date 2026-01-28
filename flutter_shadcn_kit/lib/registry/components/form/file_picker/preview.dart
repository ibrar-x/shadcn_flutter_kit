import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart' as fp;

import '../../layout/scaffold/scaffold.dart';
import '../file_picker/file_picker.dart';
import '../../../shared/theme/theme.dart';

part '_impl/state/_file_picker_preview_state.dart';

class FilePickerPreview extends StatefulWidget {
  const FilePickerPreview({super.key});

  @override
  State<FilePickerPreview> createState() => _FilePickerPreviewState();
}
