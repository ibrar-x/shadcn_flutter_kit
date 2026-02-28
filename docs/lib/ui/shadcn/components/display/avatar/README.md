# Avatar (`avatar`)

Initials/photo avatar with badge and group support.

---

## When to use

- Use this when:
  - you need a profile avatar with initials or a photo.
  - you want to show a status badge on an avatar.
  - you need stacked avatar groups.
- Avoid when:
  - a simple `Image` or `CircleAvatar` is enough.

---

## Install

```bash
flutter_shadcn add avatar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/avatar/avatar.dart';
```

---

## Minimal example

```dart
Avatar(
  initials: Avatar.getInitials('Jane Doe'),
)
```

---

## Common patterns

### Pattern: Photo avatar

```dart
Avatar.network(
  initials: Avatar.getInitials('Jane Doe'),
  photoUrl: 'https://example.com/photo.jpg',
)
```

### Pattern: Status badge

```dart
Avatar(
  initials: 'JD',
  badge: const AvatarBadge(),
)
```

### Pattern: Avatar group

```dart
AvatarGroup.toLeft(
  children: const [
    Avatar(initials: 'JS'),
    Avatar(initials: 'AL'),
    Avatar(initials: 'RB'),
  ],
)
```

---

## API

### Constructor

- `Avatar` — initials avatar with optional photo provider.
- `Avatar.network` — loads a network image with optional resize caching.
- `AvatarBadge` — small circular badge widget.
- `AvatarGroup` — stacks multiple avatars with overlap.
- `AvatarGroup.toLeft/toRight/toStart/toEnd/toTop/toBottom` — alignment helpers.

---

## Theming

- `AvatarTheme` controls size, border radius, background, and badge defaults.

---

## Accessibility

- Provide meaningful initials for screen readers.
- Ensure color contrast for initials and badge indicators.

---

## Do / Don’t

**Do**
- ✅ Use `Avatar.getInitials` for consistent initials generation.
- ✅ Use `AvatarGroup` for stacked avatars.

**Don’t**
- ❌ Rely on low-contrast badge colors.

---

## Related components

- `badge`
- `icon`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
