# App (`app`)

Application wrapper for shadcn theme and overlay layers.

---

## Install

```bash
flutter_shadcn add app
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/app/app.dart';
```

---

## Complete example

```dart
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/shadcn/layout/app/app.dart';
import 'package:<your_app>/ui/shadcn/utility/shadcn_localizations/shadcn_localizations.dart';

void main() => runApp(const AppExample());

class AppExample extends StatelessWidget {
  const AppExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Demo',
      localizationsDelegates: ShadcnLocalizations.localizationsDelegates,
      supportedLocales: ShadcnLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: const Scaffold(
        child: Center(child: Text('Hello from ShadcnApp')),
      ),
    );
  }
}
```
