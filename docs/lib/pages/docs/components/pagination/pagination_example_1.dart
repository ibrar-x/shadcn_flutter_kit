import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/navigation/pagination/pagination.dart'
    as shadcn_pagination;

const ComponentExample paginationExample1 = ComponentExample(
  title: 'Basic',
  builder: _buildPaginationExample1,
  code: '''Pagination(
  page: page,
  totalPages: 20,
  maxPages: 3,
  onPageChanged: (value) => setState(() => page = value),
)''',
);

Widget _buildPaginationExample1(BuildContext context) {
  return const _PaginationExample1();
}

class _PaginationExample1 extends StatefulWidget {
  const _PaginationExample1();

  @override
  State<_PaginationExample1> createState() => _PaginationExample1State();
}

class _PaginationExample1State extends State<_PaginationExample1> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return shadcn_pagination.Pagination(
      page: page,
      totalPages: 20,
      onPageChanged: (value) {
        setState(() {
          page = value;
        });
      },
      maxPages: 3,
    );
  }
}
