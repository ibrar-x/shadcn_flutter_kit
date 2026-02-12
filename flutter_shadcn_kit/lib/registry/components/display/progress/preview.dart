import 'package:flutter/material.dart';
import '../progress/progress.dart';
import '../../control/button/button.dart';

part '_progress_preview_state.dart';

/// Core class used by the progress component.
class ProgressPreview extends StatefulWidget {
  const ProgressPreview({super.key});

  /// Creates the State object used by this progress widget.
  @override
  State<ProgressPreview> createState() => _ProgressPreviewState();
}
