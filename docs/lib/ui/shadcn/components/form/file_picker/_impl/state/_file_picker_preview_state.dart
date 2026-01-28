part of '../../preview.dart';

class _FilePickerPreviewState extends State<FilePickerPreview> {
  late final FileUploadController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FileUploadController(
      allowMultiple: true,
      maxFiles: 5,
      maxFileSizeBytes: 10 * 1024 * 1024,
      allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Stream<double> _simulateUpload(FileLike file) async* {
    const steps = 16;
    for (var i = 1; i <= steps; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 120));
      yield i / steps;
    }
  }

  List<FileLike> _seedFiles() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return [
      FileLike(
        id: 'seed-$now-a',
        name: 'Roadmap.pdf',
        size: 280000,
        extension: 'pdf',
        mimeType: 'application/pdf',
      ),
      FileLike(
        id: 'seed-$now-b',
        name: 'Hero.jpg',
        size: 840000,
        extension: 'jpg',
        mimeType: 'image/jpeg',
      ),
    ];
  }

  Widget _buildControllerBar(double scaling) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final count = _controller.items.length;
        final hasItems = count > 0;
        return Wrap(
          spacing: 12 * scaling,
          runSpacing: 8 * scaling,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Controller: $count file${count == 1 ? '' : 's'}'),
            PrimaryButton(
              onPressed: hasItems ? _controller.clear : null,
              child: const Text('Clear'),
            ),
            SecondaryButton(
              onPressed: () => _controller.addFiles(_seedFiles()),
              child: const Text('Seed demo files'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Scaffold(
      headers: const [AppBar(title: Text('File Upload / Dropzone'))],
      child: Padding(
        padding: EdgeInsets.all(24 * scaling),
        child: FileIconProvider.builder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildControllerBar(scaling),
              SizedBox(height: 16 * scaling),
              FileUpload(
                controller: _controller,
                title: const Text('Upload files'),
                subtitle:
                    const Text('PDFs, images, and other supported files.'),
                hint: const Text('Drag files here or click browse to upload.'),
                allowMultiple: true,
                uploadFn: _simulateUpload,
                onError: (error) {
                  // Errors are announced inline; hook for analytics if needed.
                },
              ),
              FileUploadItemsView(
                items: _controller.items,
                layout: FileUploadItemsLayout.list,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
