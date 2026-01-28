import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/widgets.dart';

import 'file_like.dart';
import 'file_picker_adapter.dart';

FilePickerAdapter createAdapter() => _WebFilePickerAdapter();

class _WebFilePickerAdapter implements FilePickerAdapter {
  static int _viewTypeCounter = 0;

  @override
  bool get supportsDragDrop => true;

  @override
  Widget buildDropTarget({
    required Widget child,
    required bool enabled,
    required bool withData,
    required ValueChanged<bool> onDragActive,
    required ValueChanged<List<FileLike>> onDrop,
  }) {
    if (!enabled) return child;
    final viewType = 'shadcn-file-dropzone-${_viewTypeCounter++}';
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final div = html.DivElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.backgroundColor = 'transparent'
        ..style.pointerEvents = 'auto';

      div.onDragOver.listen((event) {
        event.preventDefault();
        onDragActive(true);
      });
      div.onDragEnter.listen((event) {
        event.preventDefault();
        onDragActive(true);
      });
      div.onDragLeave.listen((event) {
        event.preventDefault();
        onDragActive(false);
      });
      div.onDrop.listen((event) {
        event.preventDefault();
        onDragActive(false);
        final dataTransfer = event.dataTransfer;
        if (dataTransfer == null) return;
        final files = dataTransfer.files;
        if (files == null) return;
        unawaited(_handleDrop(files, withData, onDrop));
      });
      return div;
    });

    return Stack(
      children: [
        child,
        Positioned.fill(child: HtmlElementView(viewType: viewType)),
      ],
    );
  }

  @override
  Future<List<FileLike>> pickFiles({
    required bool allowMultiple,
    required bool withData,
    List<String>? allowedExtensions,
    List<String>? allowedMimeTypes,
  }) async {
    final result = await fp.FilePicker.pickFiles(
      allowMultiple: allowMultiple,
      withData: withData,
      type: (allowedExtensions != null && allowedExtensions.isNotEmpty)
          ? fp.FileType.custom
          : fp.FileType.any,
      allowedExtensions:
          (allowedExtensions != null && allowedExtensions.isNotEmpty)
          ? allowedExtensions.map((ext) => ext.replaceFirst('.', '')).toList()
          : null,
    );
    if (result == null) return const [];
    return result.files.map(_fromPlatformFile).toList();
  }

  FileLike _fromPlatformFile(fp.PlatformFile file) {
    return FileLike(
      id:
          file.identifier ??
          '${DateTime.now().microsecondsSinceEpoch}-${file.name}',
      name: file.name,
      size: file.size,
      bytes: file.bytes,
      extension: file.extension,
      source: file,
    );
  }

  Future<void> _handleDrop(
    List<html.File> files,
    bool withData,
    ValueChanged<List<FileLike>> onDrop,
  ) async {
    final results = <FileLike>[];
    for (final file in files) {
      results.add(await _fromHtmlFile(file, withData));
    }
    onDrop(results);
  }

  Future<FileLike> _fromHtmlFile(html.File file, bool withData) async {
    Uint8List? bytes;
    if (withData) {
      bytes = await _readBytes(file);
    }
    return FileLike(
      id: '${DateTime.now().microsecondsSinceEpoch}-${file.name}',
      name: file.name,
      size: file.size,
      bytes: bytes,
      mimeType: file.type,
      extension: _extensionFromName(file.name),
      source: file,
    );
  }

  String? _extensionFromName(String name) {
    final parts = name.split('.');
    if (parts.length <= 1) return null;
    return parts.last.toLowerCase();
  }

  Future<Uint8List> _readBytes(html.File file) {
    final completer = Completer<Uint8List>();
    final reader = html.FileReader();
    reader.onError.listen((event) {
      completer.completeError(StateError('Failed to read file bytes.'));
    });
    reader.onLoadEnd.listen((event) {
      final result = reader.result;
      if (result is ByteBuffer) {
        completer.complete(Uint8List.view(result));
      } else if (result is Uint8List) {
        completer.complete(result);
      } else {
        completer.completeError(StateError('Unexpected file data type.'));
      }
    });
    reader.readAsArrayBuffer(file);
    return completer.future;
  }
}
