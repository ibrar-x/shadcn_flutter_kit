import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'table_example_1.dart';
import 'table_example_2.dart';
import 'table_example_3.dart';

const ComponentExample tableExample1 = ComponentExample(
  title: "Example",
  builder: _buildTableExample1,
  code: '',
);

Widget _buildTableExample1(BuildContext context) {
  return const TableExample1();
}

const ComponentExample tableExample2 = ComponentExample(
  title: "Resizable Example",
  builder: _buildTableExample2,
  code: '',
);

Widget _buildTableExample2(BuildContext context) {
  return const TableExample2();
}

const ComponentExample tableExample3 = ComponentExample(
  title: "Scrollable Example",
  builder: _buildTableExample3,
  code: '',
);

Widget _buildTableExample3(BuildContext context) {
  return const TableExample3();
}

const List<ComponentExample> tableExamples = [
  tableExample1,
  tableExample2,
  tableExample3,
];
