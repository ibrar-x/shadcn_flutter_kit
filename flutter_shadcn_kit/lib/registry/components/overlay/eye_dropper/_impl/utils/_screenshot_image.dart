part of '../../eye_dropper.dart';

class _ScreenshotImage extends ImageProvider<_ScreenshotImage> {
  _ScreenshotImage(this.bytes, this.width, this.height, this.format);

  final Uint8List bytes;
  final int width;
  final int height;
  final ui.PixelFormat format;

  @override
  Future<_ScreenshotImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_ScreenshotImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    _ScreenshotImage key,
    ImageDecoderCallback decode,
  ) {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(bytes, width, height, format, completer.complete);
    return OneFrameImageStreamCompleter(
      completer.future.then((ui.Image image) => ImageInfo(image: image)),
    );
  }
}
