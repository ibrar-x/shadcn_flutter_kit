import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/locale_utils/locale_utils.dart';

const ComponentExample localeUtilsFileSizeExample = ComponentExample(
  title: 'File size formatting',
  builder: _buildLocaleUtilsFileSizeExample,
  code: '''Text(formatFileSize(1536, SizeUnitLocale.fileBytes));''',
);

Widget _buildLocaleUtilsFileSizeExample(BuildContext context) {
  return Text(formatFileSize(1536, SizeUnitLocale.fileBytes));
}
