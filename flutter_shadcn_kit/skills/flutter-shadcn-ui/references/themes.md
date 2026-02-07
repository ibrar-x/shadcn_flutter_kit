# Themes

Use the CLI to discover and apply themes.

## List Themes

```bash
flutter_shadcn theme --list
```

## Apply a Preset

```bash
flutter_shadcn theme --apply <theme-id>
```

## Apply From File or URL

```bash
flutter_shadcn theme --apply-file <path>
flutter_shadcn theme --apply-url <url>
```

## Reapply After Config Changes

```bash
flutter_shadcn sync
```

Theme application rewrites `<sharedPath>/theme/color_scheme.dart`.
