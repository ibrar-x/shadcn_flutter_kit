# Customization and Theming

Theme behavior is registry-driven and applied through CLI commands. Prefer CLI flows before manual file edits.

## Contents

- How theme application works
- Preset theme operations
- Custom theme JSON flows
- Widget-level theming
- Asset and platform customization
- Safe customization workflow

---

## How Theme Application Works

1. `flutter_shadcn theme` resolves the active registry namespace.
2. Presets or JSON payloads are applied to the shared theme files under configured `sharedPath`.
3. Installed components consume theme tokens from shared theme utilities.

Check the effective paths with:

```bash
flutter_shadcn doctor --json
```

---

## Preset Themes

```bash
flutter_shadcn theme --list
flutter_shadcn theme --apply <preset-id>
flutter_shadcn theme --refresh --list
```

Use namespace-specific targeting when needed:

```bash
flutter_shadcn --registry-name shadcn theme --list
```

---

## Custom Theme JSON (Experimental)

Global `--experimental` is required for top-level JSON theme input:

```bash
flutter_shadcn --experimental theme --apply-file ./theme.json
flutter_shadcn --experimental theme --apply-url https://example.com/theme.json
```

---

## Widget-Level Theming

List themeable widgets and targets:

```bash
flutter_shadcn theme widget --list
flutter_shadcn theme widget @shadcn button --list-targets
```

Apply or reset widget-level theme overrides:

```bash
flutter_shadcn theme widget @shadcn button --apply-file ./button-theme.json
flutter_shadcn theme widget @shadcn button --apply-url https://example.com/button-theme.json
flutter_shadcn theme widget @shadcn button --reset
```

---

## Assets and Platform Customization

Install shared assets through CLI:

```bash
flutter_shadcn assets --icons
flutter_shadcn assets --typography
flutter_shadcn assets --all
```

Override platform targets:

```bash
flutter_shadcn platform --list
flutter_shadcn platform --set ios.infoPlist=ios/Runner/Info.plist
flutter_shadcn platform --set android.manifest=android/app/src/main/AndroidManifest.xml
flutter_shadcn platform --reset ios.infoPlist
```

---

## Safe Customization Workflow

1. Confirm namespace and paths with `registries`, `default`, and `doctor --json`.
2. Apply theme/assets/platform changes with CLI commands.
3. Run `sync` when config path/theme settings changed.
4. Validate state with `validate`, `audit`, and `deps`.
