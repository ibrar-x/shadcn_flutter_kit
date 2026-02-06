# Spinner (`spinner`)

Base spinner helpers for resolving color and size with theming.

---

## When to use

- Use this when:
  - you are building a custom spinner widget.
  - you want consistent size/color resolution from the theme.
- Avoid when:
  - you need a ready-made spinner (use circular/linear progress).

---

## Install

```bash
flutter_shadcn add spinner
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/spinner/spinner.dart';
```

---

## Minimal example

```dart
class CustomSpinner extends Spinner {
  const CustomSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    final color = resolveColor(context) ?? Theme.of(context).colorScheme.primary;
    final size = resolveSize(context, 24);
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(color: color),
    );
  }
}
```

---

## API

### Constructor

- `Spinner`
  - `color` (`Color?`)
  - `size` (`double?`)
  - `resolveColor(BuildContext)`
  - `resolveSize(BuildContext, double)`

---

## Theming

- `SpinnerTheme` controls default color and size.

---

## Accessibility

- Provide labels for custom spinners when used as status indicators.

---

## Do / Don’t

**Do**
- ✅ Use `resolveColor`/`resolveSize` in custom spinner builds.

**Don’t**
- ❌ Reimplement size/color logic repeatedly.

---

## Related components

- `circular_progress_indicator`
- `linear_progress_indicator`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
