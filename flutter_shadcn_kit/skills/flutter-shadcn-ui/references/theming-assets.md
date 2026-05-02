# Theming, Assets, And Platform

## Theme Presets

```bash
flutter_shadcn theme --list
flutter_shadcn theme --apply modern-minimal
flutter_shadcn sync
flutter_shadcn validate --json
```

Use semantic theme values in app code instead of hardcoded colors.

## Widget-Level Themes

```bash
flutter_shadcn theme widget --list
flutter_shadcn theme widget @shadcn button --list-targets
flutter_shadcn theme widget @shadcn button --reset
```

Advanced JSON imports require `--advanced`:

```bash
flutter_shadcn --advanced theme --apply-file ./theme.json
flutter_shadcn --advanced theme widget @shadcn button --apply-file ./button-theme.json
```

## Assets

```bash
flutter_shadcn assets --icons
flutter_shadcn assets --typography
flutter_shadcn assets --all
```

Do not manually copy font assets or hand-edit `pubspec.yaml` when CLI asset actions exist.

## Platform Targets

```bash
flutter_shadcn platform --list
flutter_shadcn platform --set ios.infoPlist=ios/Runner/Info.plist
flutter_shadcn platform --reset ios.infoPlist
```

Run `doctor --json` after platform path changes.
