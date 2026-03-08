import 'dart:io';

Future<String> loadMarkdownFile(String path) {
  return File(path).readAsString();
}
