// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

Future<bool> openMarkdownLink(String url) async {
  if (url.startsWith('#')) {
    html.window.location.hash = url.substring(1);
    return true;
  }
  html.window.open(url, '_blank');
  return true;
}
