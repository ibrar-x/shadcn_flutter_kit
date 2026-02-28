# Number Ticker (`number_ticker`)

Animated number display with formatter or custom builder.

---

## When to use

- Use this when:
  - you want smooth numeric transitions.
  - you need a custom UI for changing numbers.
- Avoid when:
  - a static label is enough.

---

## Install

```bash
flutter_shadcn add number_ticker
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/number_ticker/number_ticker.dart';
```

---

## Minimal example

```dart
NumberTicker(
  number: 1200,
  formatter: (value) => value.toStringAsFixed(0),
)
```

---

## Common patterns

### Pattern: Custom builder

```dart
NumberTicker.builder(
  number: 42,
  builder: (context, value, child) {
    return Text(value.toStringAsFixed(1));
  },
)
```

---

## API

### Constructor

- `NumberTicker`
  - `number` (`num`, required)
  - `formatter` (`NumberTickerFormatted`, required)
  - `initialNumber` (`num?`)
  - `duration` (`Duration?`)
  - `curve` (`Curve?`)
  - `style` (`TextStyle?`)
- `NumberTicker.builder`
  - `builder` (`NumberTickerBuilder`, required)
  - `child` (`Widget?`)

---

## Theming

- `NumberTickerTheme` controls duration, curve, and text style.

---

## Accessibility

- Keep number updates readable (avoid excessive frequency).

---

## Do / Don’t

**Do**
- ✅ Use `initialNumber` for smooth first transition.

**Don’t**
- ❌ Format numbers inconsistently across the UI.

---

## Related components

- `text`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
