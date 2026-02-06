import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'pagination_example_1.dart';

const ComponentExample paginationExample1 = ComponentExample(
  title: "Pagination Example",
  builder: _buildPaginationExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass PaginationExample1 extends StatefulWidget {\n  const PaginationExample1({super.key});\n\n  @override\n  State<PaginationExample1> createState() => _PaginationExample1State();\n}\n\nclass _PaginationExample1State extends State<PaginationExample1> {\n  int page = 1;\n  @override\n  Widget build(BuildContext context) {\n    return Pagination(\n      page: page,\n      totalPages: 20,\n      // Limit how many page buttons are visible at once (rest via ellipsis).\n      onPageChanged: (value) {\n        setState(() {\n          page = value;\n        });\n      },\n      maxPages: 3,\n    );\n  }\n}\n",
);

Widget _buildPaginationExample1(BuildContext context) {
  return const PaginationExample1();
}

const List<ComponentExample> paginationExamples = [
  paginationExample1,
];
