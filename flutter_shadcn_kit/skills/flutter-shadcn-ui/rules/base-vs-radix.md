# Default Namespace vs Explicit Namespace

`flutter_shadcn` supports multi-registry resolution. Use explicit namespaces for deterministic installs.

## Contents

- Unqualified vs qualified IDs
- Namespace selection in list/search/info
- Remove behavior with namespace references
- Recommended patterns

---

## Unqualified vs qualified IDs

Unqualified IDs can be ambiguous across enabled registries.

**Incorrect:**

```bash
flutter_shadcn add button
```

**Correct:**

```bash
flutter_shadcn add @shadcn/button
flutter_shadcn add @orient/button
```

`add` also accepts legacy `namespace:component`, but `@namespace/component` is preferred.

---

## Namespace selection in list/search/info

`list` and `search` accept namespace tokens:

```bash
flutter_shadcn list @shadcn --json
flutter_shadcn search @orient button --json
```

`info` supports qualified component references directly:

```bash
flutter_shadcn info @shadcn/dialog --json
```

---

## Remove behavior with namespace references

For non-default namespaces, `remove` may require registry namespace selection through `--registry-name`.

**Incorrect:**

```bash
flutter_shadcn remove @orient/button
```

**Correct:**

```bash
flutter_shadcn --registry-name orient remove @orient/button
```

---

## Recommended patterns

1. Set default namespace intentionally:

```bash
flutter_shadcn default shadcn
```

2. Use explicit namespace references in scripts and docs:

```bash
flutter_shadcn add @shadcn/card @shadcn/dialog
```

3. Use `registries --json` to verify available namespaces before large installs.
