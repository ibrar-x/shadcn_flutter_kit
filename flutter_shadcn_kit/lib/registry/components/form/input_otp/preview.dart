import 'package:flutter/material.dart';
import '../input_otp/input_otp.dart';

class InputOtpPreview extends StatefulWidget {
  const InputOtpPreview({super.key});

  @override
  State<InputOtpPreview> createState() => _InputOtpPreviewState();
}

class _InputOtpPreviewState extends State<InputOtpPreview> {
  String value = '';
  String? submittedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputOTP(
              onChanged: (value) {
                setState(() {
                  this.value = value.otpToString();
                });
              },
              onSubmitted: (value) {
                setState(() {
                  submittedValue = value.otpToString();
                });
              },
              children: [
                InputOTPChild.character(allowDigit: true),
                InputOTPChild.character(allowDigit: true),
                InputOTPChild.character(allowDigit: true),
                InputOTPChild.separator,
                InputOTPChild.character(allowDigit: true),
                InputOTPChild.character(allowDigit: true),
                InputOTPChild.character(allowDigit: true),
              ],
            ),
            const SizedBox(height: 16),
            Text('Current: $value'),
            if (submittedValue != null)
              Text('Submitted: $submittedValue'),
          ],
        ),
      ),
    );
  }
}
