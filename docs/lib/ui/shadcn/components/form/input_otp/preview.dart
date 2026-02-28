import 'package:flutter/material.dart';
import '../input_otp/input_otp.dart';

part '_impl/state/_input_otp_preview_state.dart';

/// InputOtpPreview renders form UI and wires input behavior.
class InputOtpPreview extends StatefulWidget {
  const InputOtpPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<InputOtpPreview> createState() => _InputOtpPreviewState();
}
