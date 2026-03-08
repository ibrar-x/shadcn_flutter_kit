# Icons and Assets Rules

## Contents

- Install icon assets through CLI
- Use typography/font flows through CLI
- Remove asset bundles via CLI

---

## Install icon assets through CLI

Do not hand-edit font files and pubspec when asset actions exist.

**Incorrect:**

```bash
# manual copying into assets + manual pubspec edits
```

**Correct:**

```bash
flutter_shadcn assets --icons
```

---

## Use typography/font flows through CLI

```bash
flutter_shadcn assets --typography
# or
flutter_shadcn assets --fonts
```

Install both packs:

```bash
flutter_shadcn assets --all
```

---

## Remove asset bundles via CLI

When assets were installed as component bundles, remove them through managed commands:

```bash
flutter_shadcn remove icon_fonts
flutter_shadcn remove typography_fonts
```

For full rollback:

```bash
flutter_shadcn remove --all
```
