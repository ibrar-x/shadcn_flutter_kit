import 'package:flutter/material.dart';

import '../hsv/hsv_color_slider.dart';

part '_impl/state/_hsv_preview_state.dart';

class HsvPreview extends StatefulWidget {
  const HsvPreview({super.key});

  @override
  State<HsvPreview> createState() => _HsvPreviewState();
}
