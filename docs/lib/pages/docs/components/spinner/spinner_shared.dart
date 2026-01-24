import 'package:flutter/material.dart';

import '../../../../ui/shadcn/components/display/spinner/spinner.dart';

class CircleSpinner extends Spinner {
  const CircleSpinner({super.key, super.color, super.size});

  @override
  Widget build(BuildContext context) {
    final resolvedSize = resolveSize(context, 24);
    final resolvedColor = resolveColor(context);
    return SizedBox(
      width: resolvedSize,
      height: resolvedSize,
      child: CircularProgressIndicator(
        strokeWidth: resolvedSize / 8,
        valueColor: resolvedColor == null
            ? null
            : AlwaysStoppedAnimation<Color>(resolvedColor),
      ),
    );
  }
}
