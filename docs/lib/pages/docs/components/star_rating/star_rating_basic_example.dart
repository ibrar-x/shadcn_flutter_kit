import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/star_rating/star_rating.dart'
    as shadcn_star_rating;

const ComponentExample starRatingBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildStarRatingBasicExample,
  code: '''StarRating(
  starSize: 32,
  value: value,
  onChanged: (value) => setState(() => this.value = value),
)''',
);

Widget _buildStarRatingBasicExample(BuildContext context) {
  return const _StarRatingBasicExample();
}

class _StarRatingBasicExample extends StatefulWidget {
  const _StarRatingBasicExample();

  @override
  State<_StarRatingBasicExample> createState() => _StarRatingBasicExampleState();
}

class _StarRatingBasicExampleState extends State<_StarRatingBasicExample> {
  double _value = 1.5;

  @override
  Widget build(BuildContext context) {
    return shadcn_star_rating.StarRating(
      starSize: 32,
      value: _value,
      onChanged: (value) {
        setState(() => _value = value);
      },
    );
  }
}
