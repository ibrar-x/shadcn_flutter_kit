# Avatar

Display user initials or photos with optional badges and grouped stacks.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/avatar/avatar.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Avatar(initials: 'JD'),
        const SizedBox(width: 12),
        Avatar.network(
          initials: 'MS',
          photoUrl: 'https://example.com/photo.jpg',
        ),
        const SizedBox(width: 12),
        Avatar(
          initials: 'AB',
          badge: const AvatarBadge(),
        ),
      ],
    );
  }
}
```

## Grouping

```dart
AvatarGroup.toRight(
  children: const [
    Avatar(initials: 'AL'),
    Avatar(initials: 'BK'),
    Avatar(initials: 'CM'),
  ],
);
```

## Theming

Override defaults with `ComponentTheme<AvatarTheme>` and the shared theme
extensions (`Theme.of(context).scaling`, `colorScheme`, etc.).
