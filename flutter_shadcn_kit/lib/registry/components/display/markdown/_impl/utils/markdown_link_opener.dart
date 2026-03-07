import 'markdown_link_opener_stub.dart'
    if (dart.library.html) 'markdown_link_opener_web.dart'
    if (dart.library.io) 'markdown_link_opener_io.dart'
    as impl;

Future<bool> openMarkdownLink(String url) {
  return impl.openMarkdownLink(url);
}
