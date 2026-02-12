import 'package:flutter/widgets.dart';

import '../../layout/scaffold/scaffold.dart';
import '../../../shared/theme/theme.dart';
import 'dropzone.dart';

/// DropzonePreview represents a form-related type in the registry.
class DropzonePreview extends StatelessWidget {
  const DropzonePreview({super.key});

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Scaffold(
      headers: const [AppBar(title: Text('Dropzone'))],
      child: Padding(
        padding: EdgeInsets.all(24 * scaling),
        child: FileDropzone(
          hotDropEnabled: true,
          hint: const Text('Drag files here or click browse to upload.'),
          actionLabel: 'Browse files',
          onPressed: () {},
          state: DropzoneState.success,
        ),
      ),
    );
  }
}
