import 'package:flutter/widgets.dart';

/// CommandQuery defines a reusable type for this registry module.
class CommandQuery {
/// Stores `stream` state/configuration for this implementation.
  final Stream<List<Widget>> stream;
/// Stores `query` state/configuration for this implementation.
  final String? query;

  CommandQuery({required this.stream, this.query});
}
