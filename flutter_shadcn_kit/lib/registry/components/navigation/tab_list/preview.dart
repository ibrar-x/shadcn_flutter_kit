import 'package:flutter/material.dart';

import '../tab_container/tab_container.dart';
import '../tab_list/_impl/core/tab_list.dart';
part '_impl/state/_tab_list_preview_state.dart';

/// TabListPreview defines a reusable type for this registry module.
class TabListPreview extends StatefulWidget {
  const TabListPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<TabListPreview> createState() => _TabListPreviewState();
}
