import 'package:flutter/widgets.dart';

class CommandQuery {
  final Stream<List<Widget>> stream;
  final String? query;

  CommandQuery({required this.stream, this.query});
}
