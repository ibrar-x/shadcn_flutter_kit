---
title: "Class: Accordion"
description: "A container of expandable sections where only one panel may be open at once."
---

```dart
/// A container of expandable sections where only one panel may be open at once.
class Accordion extends StatefulWidget {
  /// Creates an accordion with the provided [items].
  const Accordion({super.key, required this.items});
  /// The children that make up the accordion.
  final List<Widget> items;
  AccordionState createState();
}
```
