# Component Composition Rules

## Contents

- Keep overlay wrappers in place
- Compose with installed shadcn building blocks first
- Use dry-run before add/remove changes
- Use dependency-safe remove flows

---

## Keep overlay wrappers in place

If components (or their dependencies) rely on overlay behavior, app/root scope must include one of:

- `ShadcnApp`
- `ShadcnLayer`
- `OverlayManagerLayer`

Use `dry-run` to confirm overlay dependencies before installation.

```bash
flutter_shadcn dry-run @shadcn/dialog --json
```

---

## Compose with installed shadcn building blocks first

Prefer base composables (`app`, `scaffold`, `app_bar`, `card`) before building custom replacements.

**Incorrect:**

```bash
# Skip foundational components and hand-build everything from scratch
flutter_shadcn add @shadcn/dialog
```

**Correct:**

```bash
flutter_shadcn add @shadcn/app @shadcn/scaffold @shadcn/app_bar @shadcn/card
flutter_shadcn add @shadcn/dialog
```

---

## Use dry-run before add/remove changes

Preview dependency and file impact first.

**Incorrect:**

```bash
flutter_shadcn add @shadcn/navigation_menu @shadcn/select
```

**Correct:**

```bash
flutter_shadcn dry-run @shadcn/navigation_menu @shadcn/select --json
flutter_shadcn add @shadcn/navigation_menu @shadcn/select
```

---

## Use dependency-safe remove flows

Avoid force-removal unless explicitly intended.

**Incorrect:**

```bash
flutter_shadcn remove @shadcn/form_field --force
```

**Correct:**

```bash
flutter_shadcn remove @shadcn/form_field
# Only use --force after confirming consequences
```
