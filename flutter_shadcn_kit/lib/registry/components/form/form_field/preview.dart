import 'package:flutter/material.dart';

import '../form_field/form_field.dart';

part '_impl/state/_form_field_preview_state.dart';

/// FormFieldPreview represents a form-related type in the registry.
class FormFieldPreview extends StatefulWidget {
  const FormFieldPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<FormFieldPreview> createState() => _FormFieldPreviewState();
}
