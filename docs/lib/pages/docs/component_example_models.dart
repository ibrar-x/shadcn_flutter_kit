import 'package:flutter/widgets.dart';

typedef ExampleBuilder = Widget Function(BuildContext context);

class ComponentExample {
  final String title;
  final ExampleBuilder builder;
  final String code;

  const ComponentExample({
    required this.title,
    required this.builder,
    required this.code,
  });
}

class ComponentExampleBatch {
  final String title;
  final List<String> componentIds;

  const ComponentExampleBatch({
    required this.title,
    required this.componentIds,
  });
}
