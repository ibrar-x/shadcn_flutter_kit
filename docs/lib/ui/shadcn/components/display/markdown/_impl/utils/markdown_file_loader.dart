import 'markdown_file_loader_stub.dart'
    if (dart.library.io) 'markdown_file_loader_io.dart'
    as impl;

Future<String> loadMarkdownFile(String path) {
  return impl.loadMarkdownFile(path);
}
