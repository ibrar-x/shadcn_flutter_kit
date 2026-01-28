part of '../../preview.dart';

class _FilePickerPreviewState extends State<FilePickerPreview> {
  final List<fp.PlatformFile> _files = [];
  final bool _hotDropping = false;

  Future<void> _pickFiles() async {
    final result = await fp.FilePicker.pickFiles(
      allowMultiple: true,
      withData: true,
      type: fp.FileType.any,
    );
    if (result == null) return;
    setState(() {
      _files
        ..clear()
        ..addAll(result.files);
    });
  }

  void _removeFile(fp.PlatformFile file) {
    setState(() {
      _files.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Scaffold(
      headers: const [AppBar(title: Text('File Upload / Dropzone'))],
      child: Padding(
        padding: EdgeInsets.all(24 * scaling),
        child: FilePicker(
          title: const Text('Upload files'),
          subtitle: const Text('PDF, images, or any supported file type.'),
          hint: const Text('Drop files here or click browse to upload.'),
          hotDropEnabled: true,
          hotDropping: _hotDropping,
          onAdd: _pickFiles,
          children: _files
              .map(
                (file) => FileItem.platform(
                  file: file,
                  onRemove: () => _removeFile(file),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
