import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/locale_utils/locale_utils.dart';

const ComponentExample localeUtilsDatePartsExample = ComponentExample(
  title: 'Date parts',
  builder: _buildLocaleUtilsDatePartsExample,
  code: '''final date = DateTime(2024, 7, 7);
final parts = DatePart.values
    .map((part) => '${part.name}: ${part.getter(date)}')
    .join(' | ');

Text(parts);''',
);

Widget _buildLocaleUtilsDatePartsExample(BuildContext context) {
  final date = DateTime(2024, 7, 7);
  final parts = DatePart.values
      .map((part) => '${part.name}: ${part.getter(date)}')
      .join(' | ');
  return Text(parts);
}
