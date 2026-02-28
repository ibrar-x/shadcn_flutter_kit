part of '../../eye_dropper.dart';

/// EyeDropperLayer defines a reusable type for this registry module.
class EyeDropperLayer extends StatefulWidget {
  /// The child widget to wrap.
  final Widget child;

  /// Alignment of the preview overlay.
  final AlignmentGeometry? previewAlignment;

  /// Whether to show the magnified preview.
  final bool showPreview;

  /// Size of the preview overlay.
  final Size? previewSize;

  /// Magnification scale of the preview.
  final double previewScale;

  /// Builder for custom preview label widgets.
  final PreviewLabelBuilder? previewLabelBuilder;

  /// Creates an [EyeDropperLayer].
  const EyeDropperLayer({
    super.key,
    required this.child,
    this.previewAlignment,
    this.showPreview = true,
    this.previewSize,
    this.previewScale = 8,
    this.previewLabelBuilder,
  });

  @override
/// Executes `createState` behavior for this component/composite.
  State<EyeDropperLayer> createState() => _EyeDropperLayerState();
}
