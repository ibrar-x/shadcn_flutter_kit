import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../menu/menu.dart';
import '../context_menu/context_menu.dart';

part '_impl/state/_context_menu_preview_state.dart';

class ContextMenuPreview extends StatefulWidget {
  const ContextMenuPreview({super.key});

  @override
  State<ContextMenuPreview> createState() => _ContextMenuPreviewState();
}
