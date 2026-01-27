import 'package:flutter/material.dart' hide Checkbox;

import '../checkbox/checkbox.dart';

part '_impl/state/_checkbox_preview_state.dart';


class CheckboxPreview extends StatefulWidget {
  const CheckboxPreview({super.key});

  @override
  State<CheckboxPreview> createState() => _CheckboxPreviewState();
}
