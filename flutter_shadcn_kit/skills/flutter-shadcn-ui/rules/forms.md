# Forms and Inputs Rules

## Contents

- Install form primitives as a set
- Preview transitive dependencies
- Keep validation in form components
- Verify after form changes
- Start from docs app recipes

---

## Install form primitives as a set

Avoid ad-hoc, partial installs for form-heavy screens.

**Incorrect:**

```bash
flutter_shadcn add @shadcn/input
```

**Correct:**

```bash
flutter_shadcn add \
  @shadcn/form \
  @shadcn/form_field \
  @shadcn/input \
  @shadcn/select \
  @shadcn/checkbox \
  @shadcn/radio_group \
  @shadcn/switch \
  @shadcn/slider
```

---

## Preview transitive dependencies

Form-related components often bring extra shared helpers or overlay dependencies.

**Correct:**

```bash
flutter_shadcn dry-run @shadcn/form_field @shadcn/select --json
```

---

## Keep validation in form components

Do not duplicate validation plumbing in unrelated wrapper layers when the installed form components already provide it.

**Incorrect:**

```dart
// ad-hoc validation flags spread across unrelated widgets
bool hasError = email.text.isEmpty;
```

**Correct:**

```dart
// keep validation in the chosen form primitives and shared helpers
// then keep outer widget trees focused on composition
```

---

## Verify after form changes

```bash
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

---

## Start from docs app recipes

Before building form screens from scratch, use:
`references/docs_app_common_examples.md`

Prioritize these patterns:
- Basic profile form
- Validation states and submit states
- Async + cross-field registration validation
- Sheet/dialog form composition
- Login/register switcher form flows
