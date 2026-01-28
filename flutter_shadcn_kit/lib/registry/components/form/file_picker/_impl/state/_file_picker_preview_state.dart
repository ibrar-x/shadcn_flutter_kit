part of '../../preview.dart';

class _FilePickerPreviewState extends State<FilePickerPreview> {
  Stream<double> _simulateUpload(FileLike file) async* {
    const steps = 16;
    for (var i = 1; i <= steps; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 120));
      yield i / steps;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Scaffold(
      headers: const [AppBar(title: Text('File Upload / Dropzone'))],
      child: Padding(
        padding: EdgeInsets.all(24 * scaling),
        child: FileUpload(
          title: const Text('Upload files'),
          subtitle: const Text('PDFs, images, and other supported files.'),
          hint: const Text('Drag files here or click browse to upload.'),
          allowMultiple: true,
          maxFiles: 5,
          maxFileSizeBytes: 10 * 1024 * 1024,
          allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
          uploadFn: _simulateUpload,
          onError: (error) {
            // Errors are announced inline; hook for analytics if needed.
          },
        ),
      ),
    );
  }
}
