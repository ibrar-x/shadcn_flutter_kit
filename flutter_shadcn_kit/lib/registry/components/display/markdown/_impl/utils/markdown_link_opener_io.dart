import 'dart:io';

Future<bool> openMarkdownLink(String url) async {
  ProcessResult result;
  if (Platform.isMacOS) {
    result = await Process.run('open', <String>[url]);
  } else if (Platform.isWindows) {
    result = await Process.run('cmd', <String>['/c', 'start', '', url]);
  } else if (Platform.isLinux) {
    result = await Process.run('xdg-open', <String>[url]);
  } else {
    return false;
  }
  return result.exitCode == 0;
}
