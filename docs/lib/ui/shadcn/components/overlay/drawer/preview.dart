import 'package:flutter/material.dart';

import '../../control/button/button.dart';
import '../drawer/drawer.dart';
import '../../../shared/primitives/overlay.dart';

part '_impl/state/_drawer_preview_state.dart';

class DrawerPreview extends StatefulWidget {
  const DrawerPreview({super.key});

  @override
  State<DrawerPreview> createState() => _DrawerPreviewState();
}
