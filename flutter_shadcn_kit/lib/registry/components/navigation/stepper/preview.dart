import 'package:flutter/material.dart' hide Stepper, Step;

import '../../control/button/button.dart';
import '../stepper/stepper.dart';
part '_impl/state/_stepper_preview_state.dart';

class StepperPreview extends StatefulWidget {
  const StepperPreview({super.key});

  @override
  State<StepperPreview> createState() => _StepperPreviewState();
}
