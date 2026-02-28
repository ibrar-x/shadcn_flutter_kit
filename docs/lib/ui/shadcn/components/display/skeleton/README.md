# Skeleton (`skeleton`)

Skeletonizer helpers with theme-aware config and extensions.

---

## When to use

- Use this when:
  - you want skeleton loading states tied to the shadcn theme.
  - you need helper extensions for common skeleton patterns.
- Avoid when:
  - a simple spinner is enough.

---

## Install

```bash
flutter_shadcn add skeleton
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/skeleton/skeleton.dart';
```

---

## Minimal example

```dart
ShadcnSkeletonizerConfigLayer(
  theme: Theme.of(context),
  child: ListView.builder(
    itemCount: 5,
    itemBuilder: (_, __) => const Text('Loading...'),
  ),
)
```

---

## Common patterns

### Pattern: Extension helpers

```dart
Text('Loading')
  .asSkeleton(enabled: true)
```

---

## API

### Constructor

- `ShadcnSkeletonizerConfigLayer`
  - `theme` (`ThemeData`, required)
  - `child` (`Widget`, required)
  - `duration`, `fromColor`, `toColor`, `enableSwitchAnimation`

### Extensions

- `asSkeleton`, `asSkeletonSliver`, `ignoreSkeleton`, `excludeSkeleton`

---

## Theming

- `SkeletonTheme` controls pulse duration and colors.

---

## Accessibility

- Use skeletons sparingly and replace with real content quickly.

---

## Do / Don’t

**Do**
- ✅ Keep skeleton shapes similar to final content layout.

**Don’t**
- ❌ Leave skeletons running without loading feedback.

---

## Related components

- `spinner`
- `progress`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
