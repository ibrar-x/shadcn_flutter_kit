import 'package:flutter/material.dart' hide LinearProgressIndicator;
import '../linear_progress_indicator/linear_progress_indicator.dart';
import '../../../shared/theme/theme.dart';
import '../../control/button/button.dart';

part '_linear_progress_indicator_preview_state.dart';

/// Core class used by the linear progress indicator component.
class LinearProgressIndicatorPreview extends StatefulWidget {
  const LinearProgressIndicatorPreview({super.key});

  /// Creates the State object used by this linear progress indicator widget.
  @override
  State<LinearProgressIndicatorPreview> createState() =>
      _LinearProgressIndicatorPreviewState();
}
