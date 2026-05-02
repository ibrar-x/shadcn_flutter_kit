# Component Composition Rules

## App Shell

Install app-level primitives before overlay-heavy screens:

```bash
flutter_shadcn add @shadcn/app @shadcn/scaffold @shadcn/card
```

Use one app-scope wrapper where overlay components are used:

- `ShadcnApp`
- `ShadcnLayer`
- `OverlayManagerLayer`

## Overlay Components

Overlay-dependent components include dialog, alert dialog, drawer, popover, popup, tooltip, refresh trigger, hover card, toast, menu, menubar, context menu, dropdown menu, and swiper.

Install and verify:

```bash
flutter_shadcn dry-run @shadcn/dialog @shadcn/drawer @shadcn/toast --json
flutter_shadcn add @shadcn/dialog @shadcn/drawer @shadcn/toast
```

## Prefer Registry Composition

- Use `layout/scaffold`, `layout/card`, `layout/basic`, `layout/flex`, and `layout/stage_container` before hand-building shells.
- Use `control/button`, `display/icon`, `display/text`, and `display/badge` for common controls.
- Use `overlay/menu`, `overlay/dropdown_menu`, and `overlay/context_menu` for action menus.
- Use `navigation/tabs`, `navigation/breadcrumb`, `navigation/pagination`, and `navigation/navigation_menu` for navigation.

## Safe Removal

```bash
flutter_shadcn remove @shadcn/form_field
```

Only use:

```bash
flutter_shadcn remove @shadcn/form_field --force
```

when dependency constraints are intentionally overridden.
