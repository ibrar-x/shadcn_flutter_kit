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

const Map<String, RegistryComponent> _docsOnlyDependentEntries = {
  'toggle': RegistryComponent(
    id: 'toggle',
    name: 'Toggle (Composed)',
    description: 'Docs-only composition example built from button primitives.',
    category: 'control',
    tags: ['docs-only', 'composed', 'button'],
  ),
  'avatar_group': RegistryComponent(
    id: 'avatar_group',
    name: 'Avatar Group (Composed)',
    description: 'Docs-only composition example built from avatar widgets.',
    category: 'display',
    tags: ['docs-only', 'composed', 'avatar'],
  ),
  'choices': RegistryComponent(
    id: 'choices',
    name: 'Choices (Composed)',
    description:
        'Docs-only composition example built from multiple_choice widgets.',
    category: 'form',
    tags: ['docs-only', 'composed', 'multiple_choice'],
  ),
  'multiselect': RegistryComponent(
    id: 'multiselect',
    name: 'Multiselect (Composed)',
    description: 'Docs-only composition example built from select widgets.',
    category: 'form',
    tags: ['docs-only', 'composed', 'select'],
  ),
  'number_input': RegistryComponent(
    id: 'number_input',
    name: 'Number Input (Composed)',
    description:
        'Docs-only composition example built from text_field + formatter.',
    category: 'form',
    tags: ['docs-only', 'composed', 'text_field'],
  ),
  'radio_card': RegistryComponent(
    id: 'radio_card',
    name: 'Radio Card (Composed)',
    description:
        'Docs-only composition example built from radio_group widgets.',
    category: 'form',
    tags: ['docs-only', 'composed', 'radio_group'],
  ),
  'app_bar': RegistryComponent(
    id: 'app_bar',
    name: 'App Bar (Composed)',
    description: 'Docs-only composition example built from scaffold app bar.',
    category: 'layout',
    tags: ['docs-only', 'composed', 'scaffold'],
  ),
  'material': RegistryComponent(
    id: 'material',
    name: 'Material (Composed)',
    description:
        'Docs-only composition example built from app/card/dialog/button.',
    category: 'layout',
    tags: ['docs-only', 'composed', 'layout'],
  ),
  'expandable_sidebar': RegistryComponent(
    id: 'expandable_sidebar',
    name: 'Expandable Sidebar (Composed)',
    description:
        'Docs-only composition example built from navigation_bar + outlined_container.',
    category: 'navigation',
    tags: ['docs-only', 'composed', 'navigation_bar'],
  ),
  'navigation_rail': RegistryComponent(
    id: 'navigation_rail',
    name: 'Navigation Rail (Composed)',
    description:
        'Docs-only composition example built from navigation_bar widgets.',
    category: 'navigation',
    tags: ['docs-only', 'composed', 'navigation_bar'],
  ),
  'navigation_sidebar': RegistryComponent(
    id: 'navigation_sidebar',
    name: 'Navigation Sidebar (Composed)',
    description:
        'Docs-only composition example built from navigation_bar + outlined_container.',
    category: 'navigation',
    tags: ['docs-only', 'composed', 'navigation_bar'],
  ),
  'sheet': RegistryComponent(
    id: 'sheet',
    name: 'Sheet (Composed)',
    description: 'Docs-only composition example built from drawer/form/button.',
    category: 'overlay',
    tags: ['docs-only', 'composed', 'drawer'],
  ),
};

Future<List<RegistryComponent>> loadRegistryComponents() async {
  final raw = await rootBundle.loadString('assets/registry/components.json');
  final data = jsonDecode(raw) as Map<String, dynamic>;
  final components = (data['components'] as List<dynamic>? ?? const [])
      .cast<Map<String, dynamic>>()
      .map(RegistryComponent.fromJson)
      .toList();
  final existingIds = components.map((component) => component.id).toSet();
  for (final entry in _docsOnlyDependentEntries.entries) {
    if (!existingIds.contains(entry.key)) {
      components.add(entry.value);
    }
  }
  components.sort((a, b) => a.name.compareTo(b.name));
  return components;
}
