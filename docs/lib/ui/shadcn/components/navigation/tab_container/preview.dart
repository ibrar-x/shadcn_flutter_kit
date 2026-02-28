import 'package:flutter/material.dart';

import '../tab_container/tab_container.dart';
part '_impl/state/_tab_container_preview_state.dart';

/// TabContainerPreview defines a reusable type for this registry module.
class TabContainerPreview extends StatefulWidget {
  const TabContainerPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<TabContainerPreview> createState() => _TabContainerPreviewState();
}
