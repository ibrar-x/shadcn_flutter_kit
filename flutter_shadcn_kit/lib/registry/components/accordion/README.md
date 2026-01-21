# Accordion

Ordered sections that expand one at a time. Each `AccordionItem` pairs a trigger and collapsible content.

```dart
import 'ui/shadcn/components/accordion/accordion.dart';

Accordion(
  items: [
    AccordionItem(
      trigger: AccordionTrigger(
        child: Text('Section 1'),
      ),
      content: Padding(
        padding: const EdgeInsets.all(16),
        child: const Text('Content 1'),
      ),
    ),
    AccordionItem(
      trigger: AccordionTrigger(
        child: Text('Section 2'),
      ),
      content: const Text('Content 2'),
      expanded: true,
    ),
  ],
);
```

Custom theming uses `ComponentTheme<AccordionTheme>` from `registry/shared/theme/theme.dart` to override colors, padding, icons, and animation curves.
