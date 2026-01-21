import 'package:flutter/material.dart';

import '../star_rating/star_rating.dart';

class StarRatingPreview extends StatefulWidget {
  const StarRatingPreview({super.key});

  @override
  State<StarRatingPreview> createState() => _StarRatingPreviewState();
}

class _StarRatingPreviewState extends State<StarRatingPreview> {
  double _value = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StarRating(
          value: _value,
          step: 0.5,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ),
    );
  }
}
