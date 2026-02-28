import 'package:flutter/material.dart';

import '../star_rating/star_rating.dart';

part '_impl/state/_star_rating_preview_state.dart';

/// StarRatingPreview represents a form-related type in the registry.
class StarRatingPreview extends StatefulWidget {
  const StarRatingPreview({super.key});

  /// Creates the `State` object for this widget.
  @override
  State<StarRatingPreview> createState() => _StarRatingPreviewState();
}
