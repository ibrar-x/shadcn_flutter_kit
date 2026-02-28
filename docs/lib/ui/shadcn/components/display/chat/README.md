# Chat (`chat`)

Chat bubbles, groups, and tail helpers for conversational layouts.

---

## When to use

- Use this when:
  - you need chat bubble styling with tails or grouped messages.
  - you want consistent spacing and alignment in chat threads.
- Avoid when:
  - a basic list of cards is enough.

---

## Install

```bash
flutter_shadcn add chat
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/chat/chat.dart';
```

---

## Minimal example

```dart
ChatBubble(
  child: const Text('Hello!'),
)
```

---

## Common patterns

### Pattern: Grouped messages with avatar

```dart
ChatGroup(
  avatarPrefix: const Avatar(initials: 'JD'),
  children: const [
    ChatBubble(child: Text('Hi there')),
    ChatBubble(child: Text('How can I help?')),
  ],
)
```

### Pattern: Bubble types

```dart
ChatBubble(
  type: ChatBubbleType.plain,
  child: const Text('Plain bubble'),
)
```

---

## API

### Constructor

- `ChatBubble`
  - `child` (`Widget`, required)
  - `type` (`ChatBubbleType?`)
  - `alignment`, `color`, `border`, `borderRadius`, `padding`, `widthFactor`
- `ChatGroup`
  - `children` (`List<Widget>`, required)
  - `avatarPrefix` / `avatarSuffix`
  - `alignment`, `spacing`, `avatarAlignment`, `avatarSpacing`
- `ChatBubbleType` — `plain`, `tail`, `sharpCorner`.
- `ChatConstrainedBox` — width/align helper used by bubbles.

---

## Theming

- `ChatTheme` and `ChatGroupTheme` control colors, spacing, and alignment.

---

## Accessibility

- Ensure text contrast inside bubbles.
- Provide semantic labels for avatars when needed.

---

## Do / Don’t

**Do**
- ✅ Use `ChatGroup` to keep bubble spacing consistent.

**Don’t**
- ❌ Mix multiple bubble types within the same group without intent.

---

## Related components

- `avatar`
- `tooltip`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
