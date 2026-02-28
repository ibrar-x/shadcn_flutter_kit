# Shared (`shared`)

Shared helpers, primitives, tokens, and assets used by registry components.

---

## When to use

- Use this when:
  - you are extending or contributing to the registry.
  - you need shared utilities referenced by multiple components.
- Avoid when:
  - a component-local helper is sufficient.

---

## Install

- Shared entries are not installed directly; components reference them as shared dependencies.

---

## Import

- Import the specific shared module you need (see subfolders).

---

## Contents

- `icons` — Radix/Lucide/Bootstrap icon data and lists.
- `fonts` — bundled font assets for icons and typography.
- `localizations` — minimal localization values + extensions.
- `primitives` — foundational widgets and overlay primitives.
- `theme` — theme data, color scheme, typography, presets.
- `utils` — utility helpers used across components.
- `shared_index.json` / `shared_index.md` — generated inventory of shared symbols.
- `shared.schema.json` — schema for shared index metadata.

---

## Registry rules

- Keep shared surface area minimal.
- Use shared entries only when multiple components depend on the same helper.
