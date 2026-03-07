import 'dart:io';

import 'package:flutter/services.dart';

const MethodChannel _markdownLinkChannel = MethodChannel(
  'shadcn_flutter_kit/markdown_link_opener',
);

Future<bool> openMarkdownLink(String url) async {
  final normalized = url.trim();
  if (normalized.isEmpty) {
    return false;
  }

  if (Platform.isAndroid || Platform.isIOS) {
    try {
      final result = await _markdownLinkChannel.invokeMethod<bool>('openLink', {
        'url': normalized,
      });
      return result ?? false;
    } on MissingPluginException {
      return false;
    } on PlatformException {
      return false;
    }
  }

  ProcessResult result;
  if (Platform.isMacOS) {
    result = await Process.run('open', <String>[normalized]);
  } else if (Platform.isWindows) {
    result = await Process.run('cmd', <String>['/c', 'start', '', normalized]);
  } else if (Platform.isLinux) {
    result = await Process.run('xdg-open', <String>[normalized]);
  } else {
    return false;
  }
  return result.exitCode == 0;
}
