# Core Concepts

Source: this skill reference set and CLI behavior.

## Registry

The registry defines components and shared helpers.
CLI can resolve local or remote registries.

## Paths

- Install path: where component files are copied
- Shared path: where shared helpers are copied

Defaults come from `components.json` and can be overridden in `.shadcn/config.json`.

## Config and State

- `.shadcn/config.json`: user preferences (paths, registry mode, aliases)
- `.shadcn/state.json`: managed dependency and sync metadata

## Manifests

- `<installPath>/components.json`: installed component metadata
- `.shadcn/components/<id>.json`: per-component install metadata

## Schema Validation

`components.json` is validated against schema to ensure structural consistency.

## JSON Output Envelope

Commands that support `--json` return:
- `status`
- `command`
- `data`
- `errors`
- `warnings`
- `meta`

## Offline Mode

Use `--offline` to disable network and rely on cached registry/index data.

## Base Widgets from Registry

Core base widgets/composites you should know:

- `app`: provides `ShadcnApp` (app wrapper with overlay + theme wiring)
- `scaffold`: provides `Scaffold` and `AppBar` base layout primitives
- `app_bar`: composite export for `AppBar`, `OutlinedContainer`, `OutlineButton`, `ButtonDensity`
- `card`: provides `Card` and `SurfaceCard`

## Overlay Wrapper Requirement

If a selected component depends on overlay behavior, wrap the tree with one of:
- `ShadcnApp`
- `ShadcnLayer`
- `OverlayManagerLayer`

Overlay category IDs in the registry:
- `alert_dialog`, `context_menu`, `dialog`, `drawer`, `dropdown_menu`, `eye_dropper`
- `hover_card`, `menu`, `menubar`, `overlay`, `popover`, `popup`
- `refresh_trigger`, `sheet`, `swiper`, `toast`, `tooltip`

Components outside the overlay category that currently depend on overlay IDs:
- `color_input`, `color_picker`, `command`, `error_system`, `form_field`
- `item_picker`, `material`, `navigation_menu`, `scaffold`, `select`, `tracker`

Verification flow:

```bash
flutter_shadcn dry-run <component>
```

If the preview includes overlay-category dependencies, enforce the wrapper requirement.
