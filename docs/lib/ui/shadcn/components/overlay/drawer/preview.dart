import 'package:flutter/material.dart';

import '../../control/button/button.dart';
import '../drawer/drawer.dart';
import '../../../shared/primitives/overlay.dart';

part '_impl/state/_drawer_preview_state.dart';

/// DrawerPreview defines a reusable type for this registry module.
class DrawerPreview extends StatefulWidget {
  const DrawerPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<DrawerPreview> createState() => _DrawerPreviewState();
}
