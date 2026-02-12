import 'package:flutter/material.dart';
import '../pagination/pagination.dart';
part '_impl/state/_pagination_preview_state.dart';

/// PaginationPreview defines a reusable type for this registry module.
class PaginationPreview extends StatefulWidget {
  const PaginationPreview({super.key});

  @override
/// Executes `createState` behavior for this component/composite.
  State<PaginationPreview> createState() => _PaginationPreviewState();
}
