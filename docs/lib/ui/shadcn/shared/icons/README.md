# Icons (`shared/icons`)

Bundled icon data for Radix, Lucide, and Bootstrap icon sets.

---

## When to use

- Use this when:
  - you need consistent icon sets across the registry.
  - you want access to icon lists for search or pickers.
- Avoid when:
  - you are bringing a separate icon pack.

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/shared/icons/radix_icons.dart';
import 'package:<your_app>/ui/shadcn/shared/icons/lucide_icons.dart';
import 'package:<your_app>/ui/shadcn/shared/icons/bootstrap_icons.dart';
```

---

## Minimal example

```dart
const Icon(RadixIcons.upload);
```

---

## API

### Icon sets

- `RadixIcons`
- `LucideIcons`
- `BootstrapIcons`

### Icon entry lists

- `RadixIconEntry`, `radixIconEntries`
- `LucideIconEntry`, `lucideIconEntries`
- `BootstrapIconEntry`, `bootstrapIconEntries`

---

## Notes

- Icon entries expose name + IconData for search UIs.

---

## Related modules

- `shared/fonts`
- `shared/theme`
