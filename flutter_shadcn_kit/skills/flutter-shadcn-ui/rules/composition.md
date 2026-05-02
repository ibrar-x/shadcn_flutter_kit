# Composition Rules

Use `references/composition.md` for the current full rules.

Key points:

- Keep `ShadcnApp`, `ShadcnLayer`, or `OverlayManagerLayer` at app scope for overlay components.
- Prefer registry components before custom Material/Cupertino widgets.
- Hide framework conflicts instead of aliasing registry imports.
- Run `dry-run --json` before non-trivial installs.
