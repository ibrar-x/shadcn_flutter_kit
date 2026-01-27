import 'package:flutter/material.dart' hide TextField;

import '../autocomplete/autocomplete.dart' as shadcn;
import '../text_field/text_field.dart';

part '_impl/state/_autocomplete_preview_state.dart';


class AutocompletePreview extends StatefulWidget {
  const AutocompletePreview({super.key});

  @override
  State<AutocompletePreview> createState() => _AutocompletePreviewState();
}
