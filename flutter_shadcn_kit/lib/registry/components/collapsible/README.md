# Collapsible

Independent expand/collapse sections that work alongside `CollapsibleTrigger` and `CollapsibleContent`.

```dart
import 'ui/shadcn/components/collapsible/collapsible.dart';

Collapsible(
  children: [
    CollapsibleTrigger(
      child: Text('Show advanced options'),
    ),
    CollapsibleContent(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Text('Details go here.'),
      ),
    ),
  ],
);
```

The component uses `GhostButton` from the Button registry and adapts to `ComponentTheme<CollapsibleTheme>` to adjust padding, icons, and layout alignment.
