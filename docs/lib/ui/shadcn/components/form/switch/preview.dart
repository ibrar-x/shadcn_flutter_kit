import 'package:flutter/material.dart' hide Switch;

import '../switch/switch.dart';

part '_impl/state/_switch_preview_state.dart';


class SwitchPreview extends StatefulWidget {
  const SwitchPreview({super.key});

  @override
  State<SwitchPreview> createState() => _SwitchPreviewState();
}
