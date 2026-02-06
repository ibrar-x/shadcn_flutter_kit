# Avatar Group (`avatar_group`)

Composite export for AvatarGroup, Avatar, and AvatarBadge.

---

## When to use

- Use this when:
  - you need overlapping avatar stacks.
  - you want a concise import for avatar primitives.
- Avoid when:
  - a single avatar is enough.

---

## Install

```bash
flutter_shadcn add avatar_group
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/display/avatar_group/avatar_group.dart';
```

---

## Minimal example

```dart
AvatarGroup.toRight(
  children: const [
    Avatar(initials: 'AL'),
    Avatar(initials: 'BR'),
    Avatar(initials: 'CT'),
  ],
)
```

---

## API

### Types

- `Avatar`
- `AvatarBadge`
- `AvatarGroup`

---

## Theming

- Uses avatar theming from the display registry.

---

## Accessibility

- Provide initials or labels for screen readers.

---

## Do / Don’t

**Do**
- ✅ Keep avatar groups small to maintain clarity.

**Don’t**
- ❌ Overlap too many avatars without a summary.

---

## Related components

- `avatar`
- `badge`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
