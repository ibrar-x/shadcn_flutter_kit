# Refresh Trigger

Pull-to-refresh wrapper that displays a customizable indicator and handles async callbacks.

```dart
import 'ui/shadcn/components/refresh_trigger/refresh_trigger.dart';

RefreshTrigger(
  onRefresh: () async {
    await fetchData();
  },
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  ),
);
```

Use `ComponentTheme<RefreshTriggerTheme>` to change the min/max extents, indicator builder, or animation curve before installing the widget.
