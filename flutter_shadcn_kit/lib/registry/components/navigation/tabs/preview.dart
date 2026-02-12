import 'package:flutter/material.dart';
import '../tabs/tabs.dart';
part '_impl/state/_tabs_preview_state.dart';

/// TabsPreview defines a reusable type for this registry module.
class TabsPreview extends StatefulWidget {
  const TabsPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<TabsPreview> createState() => _TabsPreviewState();
}
