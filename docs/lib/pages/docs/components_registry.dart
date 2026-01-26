import 'dart:convert';

import 'package:flutter/services.dart';

class RegistryComponent {
  final String id;
  final String name;
  final String description;
  final String category;
  final List<String> tags;

  const RegistryComponent({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.tags,
  });

  factory RegistryComponent.fromJson(Map<String, dynamic> json) {
    return RegistryComponent(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'Misc',
      tags: (json['tags'] as List<dynamic>? ?? const [])
          .map((tag) => tag.toString())
          .toList(),
    );
  }
}

Future<List<RegistryComponent>> loadRegistryComponents() async {
  final raw = await rootBundle.loadString('assets/registry/components.json');
  final data = jsonDecode(raw) as Map<String, dynamic>;
  final components = (data['components'] as List<dynamic>? ?? const [])
      .cast<Map<String, dynamic>>()
      .map(RegistryComponent.fromJson)
      .toList();
  components.sort((a, b) => a.name.compareTo(b.name));
  return components;
}
