import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/display/triple_dots/triple_dots.dart'
    as shadcn_dots;
import '../../../../ui/shadcn/components/navigation/breadcrumb/breadcrumb.dart'
    as shadcn_breadcrumb;

const ComponentExample breadcrumbExample1 = ComponentExample(
  title: 'Arrow separator',
  builder: _buildBreadcrumbExample1,
  code: '''Breadcrumb(
  separator: Breadcrumb.arrowSeparator,
  children: [
    TextButton(child: Text('Home')),
    MoreDots(),
    TextButton(child: Text('Components')),
    Text('Breadcrumb'),
  ],
)''',
);

Widget _buildBreadcrumbExample1(BuildContext context) {
  return shadcn_breadcrumb.Breadcrumb(
    separator: shadcn_breadcrumb.Breadcrumb.arrowSeparator,
    children: [
      shadcn_buttons.TextButton(
        onPressed: () {},
        density: shadcn_buttons.ButtonDensity.compact,
        child: const Text('Home'),
      ),
      const shadcn_dots.MoreDots(),
      shadcn_buttons.TextButton(
        onPressed: () {},
        density: shadcn_buttons.ButtonDensity.compact,
        child: const Text('Components'),
      ),
      const Text('Breadcrumb'),
    ],
  );
}
