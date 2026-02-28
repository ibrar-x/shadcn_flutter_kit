import 'package:flutter/material.dart' hide Stepper, Step;

import '../../control/button/button.dart';
import '../stepper/stepper.dart';
part '_impl/state/_stepper_preview_state.dart';

/// StepperPreview defines a reusable type for this registry module.
class StepperPreview extends StatefulWidget {
  const StepperPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<StepperPreview> createState() => _StepperPreviewState();
}
