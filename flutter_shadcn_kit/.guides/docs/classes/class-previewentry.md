---
title: "Class: PreviewEntry"
description: "Metadata for a complete component preview entry"
---

```dart
/// Metadata for a complete component preview entry
class PreviewEntry {
  /// Unique component identifier (e.g., 'button', 'card')
  final String id;
  /// Display name of the component
  final String title;
  /// Short description of what this component does
  final String description;
  /// Category grouping (e.g., 'Control', 'Layout', 'Form')
  final String category;
  /// Tags for searching/filtering
  final List<String> tags;
  /// Example usage code snippet
  final String usageCode;
  /// List of preview variants demonstrating different states/configurations
  final List<PreviewVariant> variants;
  const PreviewEntry({required this.id, required this.title, required this.description, required this.category, required this.tags, required this.usageCode, required this.variants});
}
```
