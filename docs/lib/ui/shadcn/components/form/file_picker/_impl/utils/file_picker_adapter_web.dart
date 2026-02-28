// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

import 'file_like.dart';
import 'file_picker_adapter.dart';

/// Performs `createAdapter` logic for this form component.
FilePickerAdapter createAdapter() => _WebFilePickerAdapter();

/// _WebFilePickerAdapter represents a form-related type in the registry.
class _WebFilePickerAdapter implements FilePickerAdapter {
  /// Field storing `supportsDragDrop` for this form implementation.
  @override
  bool get supportsDragDrop => true;

  @override
  Widget buildDropTarget({
    required Widget child,
    required bool enabled,
    required bool withData,
    required ValueChanged<bool> onDragActive,
    required ValueChanged<List<FileLike>> onDrop,
    VoidCallback? onTap,
  }) {
    if (!enabled) return child;
    return _WebDropTargetView(
      child: child,
      withData: withData,
      onDragActive: onDragActive,
      onDrop: onDrop,
      onTap: onTap,
      handleDrop: _handleDrop,
    );
  }

  Future<void> _handleDrop(
    web.FileList files,
    bool withData,
    ValueChanged<List<FileLike>> onDrop,
  ) async {
    final futures = <Future<FileLike>>[];
    for (var index = 0; index < files.length; index++) {
      final file = files.item(index);
      if (file == null) continue;
      futures.add(_fromWebFile(file, withData));
    }
    onDrop(await Future.wait(futures));
  }

  Future<Uint8List> _readWebFileBytes(web.File file) {
    final completer = Completer<Uint8List>();
    final reader = web.FileReader();
    reader.onload = ((web.Event _) {
      final result = reader.result;
      if (result == null) {
        completer.completeError(StateError('FileReader result was null'));
        return;
      }
      final buffer = (result as JSArrayBuffer).toDart;
      completer.complete(Uint8List.view(buffer));
    }).toJS;
    reader.onerror = ((web.Event _) {
      completer.completeError(StateError('FileReader failed for ${file.name}'));
    }).toJS;
    reader.readAsArrayBuffer(file);
    return completer.future;
  }

  Future<FileLike> _fromWebFile(web.File file, bool withData) async {
    final bytes = withData ? await _readWebFileBytes(file) : null;
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

  /// Performs `_extensionFromName` logic for this form component.
  String? _extensionFromName(String name) {
    final parts = name.split('.');
    if (parts.length <= 1) return null;
    return parts.last.toLowerCase();
  }
}

/// _WebDropTargetView represents a form-related type in the registry.
class _WebDropTargetView extends StatefulWidget {
  /// Constructs `_WebDropTargetView` with the provided parameters.
  const _WebDropTargetView({
    required this.child,
    required this.withData,
    required this.onDragActive,
    required this.onDrop,
    required this.onTap,
    required this.handleDrop,
  });

  /// Field storing `child` for this form implementation.
  final Widget child;

  /// Field storing `withData` for this form implementation.
  final bool withData;

  /// Callback invoked for `onDragActive` events.
  final ValueChanged<bool> onDragActive;

  /// Callback invoked for `onDrop` events.
  final ValueChanged<List<FileLike>> onDrop;

  /// Callback invoked for `onTap` events.
  final VoidCallback? onTap;
  final Future<void> Function(
    web.FileList files,
    bool withData,
    ValueChanged<List<FileLike>> onDrop,
  )
  handleDrop;

  /// Creates the `State` object for this widget.
  @override
  State<_WebDropTargetView> createState() => _WebDropTargetViewState();
}

/// _WebDropTargetViewState stores and manages mutable widget state.
class _WebDropTargetViewState extends State<_WebDropTargetView> {
  /// Field storing `_counter` for this form implementation.
  static int _counter = 0;

  /// Field storing `_viewType` for this form implementation.
  late final String _viewType;
  late final web.HTMLDivElement _div;

  /// Field storing `_dragDepth` for this form implementation.
  var _dragDepth = 0;

  /// Field storing `_isActive` for this form implementation.
  var _isActive = false;

  /// Performs `_setActive` logic for this form component.
  void _setActive(bool value) {
    if (_isActive == value) return;
    _isActive = value;
    widget.onDragActive(value);
  }

  /// Initializes stateful resources for this widget.
  @override
  void initState() {
    super.initState();
    _viewType = 'shadcn-file-dropzone-${_counter++}';
    _div = web.HTMLDivElement()
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.backgroundColor = 'transparent'
      ..style.pointerEvents = 'auto';

    _div.onDragOver.listen((event) {
      event.preventDefault();
      event.stopPropagation();
      if (_dragDepth == 0) _dragDepth = 1;
      _setActive(true);
    });
    _div.onDragEnter.listen((event) {
      event.preventDefault();
      event.stopPropagation();
      _dragDepth += 1;
      _setActive(true);
    });
    _div.onDragLeave.listen((event) {
      event.preventDefault();
      event.stopPropagation();
      _dragDepth = (_dragDepth - 1).clamp(0, 1 << 31);
      if (_dragDepth == 0) {
        _setActive(false);
      }
    });
    _div.onDrop.listen((event) {
      event.preventDefault();
      event.stopPropagation();
      _dragDepth = 0;
      _setActive(false);
      final dragEvent = event as web.DragEvent;
      final dataTransfer = dragEvent.dataTransfer;
      if (dataTransfer == null) return;
      final files = dataTransfer.files;
      if (files == null) return;
      unawaited(widget.handleDrop(files, widget.withData, widget.onDrop));
    });
    if (widget.onTap != null) {
      _div.onclick = ((web.Event _) {
        widget.onTap?.call();
      }).toJS;
    }

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return _div;
    });
  }

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(child: HtmlElementView(viewType: _viewType)),
      ],
    );
  }
}
