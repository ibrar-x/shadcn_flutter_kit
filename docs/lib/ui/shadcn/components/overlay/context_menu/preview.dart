import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../menu/menu.dart';
import '../context_menu/context_menu.dart';

part '_impl/state/_context_menu_preview_state.dart';

/// ContextMenuPreview defines a reusable type for this registry module.
class ContextMenuPreview extends StatefulWidget {
  const ContextMenuPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<ContextMenuPreview> createState() => _ContextMenuPreviewState();
}
