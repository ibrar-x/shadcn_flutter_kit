import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/file_picker/file_picker.dart'
    as shadcn_file_picker;

const ComponentExample filePickerFileItemExample = ComponentExample(
  title: 'Controller + uploads',
  builder: _buildFilePickerFileItemExample,
  code: '''final controller = FileUploadController();

FileUpload(
  controller: controller,
  uploadFn: (file) => uploadStream(file),
)''',
);

Widget _buildFilePickerFileItemExample(BuildContext context) {
  return const _FilePickerControllerExample();
}

class _FilePickerControllerExample extends StatefulWidget {
  const _FilePickerControllerExample();

  @override
  State<_FilePickerControllerExample> createState() =>
      _FilePickerControllerExampleState();
}

class _FilePickerControllerExampleState
    extends State<_FilePickerControllerExample> {
  late final shadcn_file_picker.FileUploadController _controller;

  @override
  void initState() {
    super.initState();
    _controller = shadcn_file_picker.FileUploadController(
      allowMultiple: true,
      maxFiles: 6,
    );
    _controller.setItems([
      shadcn_file_picker.FileUploadItem.fromFile(
        const shadcn_file_picker.FileLike(
          id: 'proposal',
          name: 'proposal.pdf',
          size: 1024 * 900,
          extension: 'pdf',
          mimeType: 'application/pdf',
        ),
      ),
      shadcn_file_picker.FileUploadItem.fromFile(
        const shadcn_file_picker.FileLike(
          id: 'design',
          name: 'design-preview.png',
          size: 1024 * 350,
          extension: 'png',
          mimeType: 'image/png',
        ),
      ),
    ]);
    _controller.startUploads(_mockUpload);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Stream<double> _mockUpload(shadcn_file_picker.FileLike file) async* {
    for (var i = 1; i <= 10; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 140));
      yield i / 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_file_picker.FileUpload(
      title: const Text('Upload queue'),
      subtitle: const Text('Controller manages items and upload state'),
      controller: _controller,
      itemsLayout: shadcn_file_picker.FileUploadItemsLayout.list,
      itemsMaxHeight: 240,
      uploadFn: _mockUpload,
      itemBuilder: (context, item) {
        return shadcn_file_picker.FileItem(
          item: item,
          onRemove: () => _controller.removeFile(item.file),
        );
      },
    );
  }
}
