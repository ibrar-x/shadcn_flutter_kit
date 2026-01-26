import 'dart:io';

Future<void> main(List<String> args) async {
  final scriptPath = _resolveScriptPath();
  final result = await Process.run(
    'python3',
    [scriptPath, ...args],
  );
  stdout.write(result.stdout);
  stderr.write(result.stderr);
  exit(result.exitCode);
}

String _resolveScriptPath() {
  final scriptFile = File.fromUri(Platform.script);
  final docsRoot = scriptFile.parent.parent;
  return docsRoot
      .uri
      .resolve('scripts/generate_component_pages.py')
      .toFilePath();
}
