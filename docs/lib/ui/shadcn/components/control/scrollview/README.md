# Scroll View Interceptor (`scrollview`)

Middle-click drag scroll interceptor for desktop/web.

---

## When to use

- Use this when:
  - you want middle-mouse drag scrolling on desktop/web.
  - you need a wrapper that can be toggled on/off.
- Avoid when:
  - your app targets touch-only platforms.

---

## Install

```bash
flutter_shadcn add scrollview
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/control/scrollview/scrollview.dart';
```

---

## Minimal example

```dart
ScrollViewInterceptor(
  child: ListView.builder(
    itemCount: 50,
    itemBuilder: (_, index) => Text('Row $index'),
  ),
)
```

---

## Common patterns

### Pattern: Toggle interception

```dart
ScrollViewInterceptor(
  enabled: isDesktopMode,
  child: ListView.builder(
    itemCount: 50,
    itemBuilder: (_, index) => Text('Row $index'),
  ),
)
```

---

## API

### Constructor

- `ScrollViewInterceptor`
  - `child` (`Widget`, required)
  - `enabled` (`bool`, default: `true`)

---

## Theming

- No theme dependencies.

---

## Accessibility

- Provide alternate scroll controls for keyboard users.

---

## Do / Don’t

**Do**
- ✅ Use for desktop/web experiences where middle-click drag is expected.
- ✅ Allow users to disable the behavior when needed.

**Don’t**
- ❌ Enable by default on touch-only platforms.

---

## Related components

- `scrollbar`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
