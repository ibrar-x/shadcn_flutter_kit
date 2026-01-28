import 'dart:typed_data';

class FileLike {
  const FileLike({
    required this.id,
    required this.name,
    required this.size,
    this.bytes,
    this.path,
    this.mimeType,
    this.extension,
    this.source,
  });

  final String id;
  final String name;
  final int size;
  final Uint8List? bytes;
  final String? path;
  final String? mimeType;
  final String? extension;
  final Object? source;

  String get resolvedExtension {
    final explicit = extension;
    if (explicit != null && explicit.isNotEmpty) {
      return explicit.toLowerCase();
    }
    final parts = name.split('.');
    if (parts.length <= 1) return '';
    return parts.last.toLowerCase();
  }

  bool get isImage {
    final type = mimeType;
    if (type != null && type.startsWith('image/')) {
      return true;
    }
    const imageExtensions = [
      'png',
      'jpg',
      'jpeg',
      'gif',
      'webp',
      'bmp',
      'svg',
      'heic',
    ];
    return imageExtensions.contains(resolvedExtension);
  }
}
