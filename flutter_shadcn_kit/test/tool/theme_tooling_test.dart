import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final packageRoot = Directory.current.path;
  final themeIndexScript = '$packageRoot/tool/theme/theme_index_generate.dart';
  final themePresetScript =
      '$packageRoot/tool/theme/theme_preset_json_to_dart.dart';

  group('theme tooling', () {
    test(
      'theme index generator writes hashed artifact manifest entries',
      () async {
        final tempDir = _createFixture();
        addTearDown(() {
          if (tempDir.existsSync()) {
            tempDir.deleteSync(recursive: true);
          }
        });

        _writeThemePreset(
          tempDir,
          fileName: 'sunrise.json',
          data: <String, Object?>{
            'id': 'sunrise',
            'name': 'Sunrise',
            'description': 'Warm orange accent.',
            'light': <String, String>{'primary': '0xFFFF8800'},
            'dark': <String, String>{'primary': '0xFFFF5500'},
          },
        );

        final result = await Process.run('dart', <String>[
          themeIndexScript,
        ], workingDirectory: tempDir.path);

        expect(
          result.exitCode,
          0,
          reason: 'stdout=${result.stdout}\nstderr=${result.stderr}',
        );

        final manifestFile = File(
          '${tempDir.path}/lib/registry/manifests/theme.index.json',
        );
        expect(manifestFile.existsSync(), isTrue);

        final manifest =
            jsonDecode(manifestFile.readAsStringSync()) as Map<String, dynamic>;
        final themes = manifest['themes'] as List<dynamic>;
        expect(themes, hasLength(1));

        final entry = themes.single as Map<String, dynamic>;
        expect(entry['name'], 'sunrise');
        expect(entry['label'], 'Sunrise');
        expect(entry['description'], 'Warm orange accent.');
        expect(entry['source'], 'themes_preset/sunrise.json');
        expect(entry.containsKey('id'), isFalse);
        expect(entry.containsKey('file'), isFalse);

        final files = (entry['files'] as List<dynamic>)
            .cast<Map<String, dynamic>>();
        expect(files, hasLength(2));
        expect(files.map((file) => file['target']).toSet(), <String>{
          'lib/ui/shadcn/shared/theme/preset_themes.dart',
          'lib/ui/shadcn/shared/theme/app_theme_preset.dart',
        });

        for (final file in files) {
          final sourceFile = File(
            '${tempDir.path}/lib/registry/${file['source']}',
          );
          expect(
            sourceFile.existsSync(),
            isTrue,
            reason: 'missing generated source ${file['source']}',
          );
          expect(file['sha256'], _sha256Hex(sourceFile));
        }
      },
    );

    test(
      'theme preset generator no longer accepts converter envelopes',
      () async {
        final tempDir = _createFixture();
        addTearDown(() {
          if (tempDir.existsSync()) {
            tempDir.deleteSync(recursive: true);
          }
        });

        final presetFile = _writeThemePreset(
          tempDir,
          fileName: 'sunrise.json',
          data: <String, Object?>{
            'id': 'sunrise',
            'name': 'Sunrise',
            'light': <String, String>{'primary': '0xFFFF8800'},
            'dark': <String, String>{'primary': '0xFFFF5500'},
          },
        );

        final requestFile = File('${tempDir.path}/theme-request.json')
          ..writeAsStringSync(
            const JsonEncoder.withIndent('  ')
                .convert(<String, Object?>{
                  'scope': 'global',
                  'action': 'apply',
                  'payloadFile': '__PAYLOAD__',
                  'context': <String, String>{
                    'sharedPath': 'lib/ui/shadcn/shared',
                  },
                })
                .replaceFirst('__PAYLOAD__', presetFile.path),
          );

        final result = await Process.run('dart', <String>[
          themePresetScript,
          requestFile.path,
        ], workingDirectory: tempDir.path);

        expect(result.exitCode, isNot(0));
        expect(result.stdout.toString(), isNot(contains('"installPlan"')));
        expect(
          result.stderr.toString(),
          contains('Provide --preset-id=<id> or --preset-json=<path>.'),
        );
      },
    );
  });
}

Directory _createFixture() {
  final tempDir = Directory.systemTemp.createTempSync('theme_tooling_test_');
  Directory(
    '${tempDir.path}/lib/registry/themes_preset',
  ).createSync(recursive: true);
  Directory(
    '${tempDir.path}/lib/registry/manifests',
  ).createSync(recursive: true);
  Directory(
    '${tempDir.path}/lib/registry/shared/theme',
  ).createSync(recursive: true);
  File(
    '${tempDir.path}/lib/registry/manifests/themes.index.schema.json',
  ).writeAsStringSync('{}');
  return tempDir;
}

File _writeThemePreset(
  Directory tempDir, {
  required String fileName,
  required Map<String, Object?> data,
}) {
  final file = File('${tempDir.path}/lib/registry/themes_preset/$fileName');
  file.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(data)}\n',
  );
  return file;
}

String _sha256Hex(File file) {
  final result = Process.runSync('shasum', <String>['-a', '256', file.path]);
  if (result.exitCode != 0) {
    throw StateError('Failed to hash ${file.path}: ${result.stderr}');
  }
  return result.stdout.toString().trim().split(RegExp(r'\s+')).first;
}
