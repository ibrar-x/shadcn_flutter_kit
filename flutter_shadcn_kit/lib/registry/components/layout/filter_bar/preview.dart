import 'package:flutter/widgets.dart';

import '../../control/button/button.dart';
import '../../form/select/select.dart';
import '../scaffold/scaffold.dart' as shadcn_scaffold;
import 'filter_bar.dart';
import '../../../shared/theme/theme.dart';

part '_impl/state/_filter_bar_preview_state.dart';

class FilterBarPreview extends StatefulWidget {
  const FilterBarPreview({super.key});

  @override
  State<FilterBarPreview> createState() => _FilterBarPreviewState();
}
