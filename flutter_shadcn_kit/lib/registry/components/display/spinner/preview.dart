import 'package:flutter/material.dart' as m;

import '../spinner/spinner.dart';

class SpinnerPreview extends m.StatelessWidget {
  const SpinnerPreview({super.key});

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: m.Wrap(
          spacing: 32,
          runSpacing: 32,
          children: const [
            CircleSpinner(),
            CircleSpinner(size: 20),
            CircleSpinner(size: 32),
            CircleSpinner(size: 48),
            CircleSpinner(color: m.Colors.blue),
            CircleSpinner(color: m.Colors.green),
            CircleSpinner(color: m.Colors.orange),
            CircleSpinner(color: m.Colors.red),
          ],
        ),
      ),
    );
  }
}

class CircleSpinner extends Spinner {
  const CircleSpinner({super.key, super.color, super.size});

  @override
  m.Widget build(m.BuildContext context) {
    final resolvedSize = resolveSize(context, 24);
    final resolvedColor = resolveColor(context);
    return m.SizedBox(
      width: resolvedSize,
      height: resolvedSize,
      child: m.CircularProgressIndicator(
        strokeWidth: resolvedSize / 8,
        valueColor: resolvedColor == null
            ? null
            : m.AlwaysStoppedAnimation<m.Color>(resolvedColor),
      ),
    );
  }
}
