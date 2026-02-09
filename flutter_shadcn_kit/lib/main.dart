import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/components/display/text_animate/preview.dart';

import 'package:flutter_shadcn_kit/registry/composites/layout/app/app.dart';
import 'package:flutter_shadcn_kit/registry/components/display/empty_state/preview.dart';
import 'package:flutter_shadcn_kit/registry/shared/theme/theme.dart' as shadcn;

void main() {
  runApp(const _RegistryApp());
}

class _RegistryApp extends StatelessWidget {
  const _RegistryApp();

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Text Animate Preview',
      theme: const shadcn.ThemeData(),
      home: const TextAnimatePreview(),
    );
  }
}
