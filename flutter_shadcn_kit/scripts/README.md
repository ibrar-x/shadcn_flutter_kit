# Registry Scripts

## new_component.dart
Scaffolds a new registry component under `lib/registry/components/<category>/<id>`, then
updates `lib/registry/manifests/components.json` plus `docs/assets/registry/components.json`.

Example:
```bash
dart run scripts/new_component.dart button --category control --description "Shadcn-style button."
```

What it does:
- Creates `README.md`, `GETTING_STARTED.md`, `meta.json`, and stub Dart files
  (`<id>.dart`, `preview.dart`).
- Creates `_impl/` taxonomy folders (`core`, `state`, `styles`, `themes`, `utils`,
  `variants`, `extensions`).
- Overwrites `lib/main.dart` to point at the new component preview, wrapped in
  `ShadcnApp`.
- Writes `version: 1.0.0` into `meta.json` and `components.json`.
- Skips hidden files (e.g. `.DS_Store`) when assembling file lists.

Flags:
- `--sync` runs the full registry sync pipeline after create/remove.
- `--remove` deletes the component folder and removes it from `components.json`.

More examples:
```bash
dart run scripts/new_component.dart button --category control --sync
dart run scripts/new_component.dart button --category control --remove --sync
dart run scripts/new_component.dart --sync
```
