# Common Tasks

## Initialize with Defaults

```bash
flutter_shadcn init --yes
```

## Discover Components

```bash
flutter_shadcn list
flutter_shadcn search form
flutter_shadcn info button
```

## Preview and Install

```bash
flutter_shadcn dry-run button
flutter_shadcn add button
```

## Remove a Component Safely

```bash
flutter_shadcn remove button
```

Force removal if dependents must be ignored:

```bash
flutter_shadcn remove button --force
```

## Apply Theme / Assets

```bash
flutter_shadcn theme --list
flutter_shadcn assets --all
```

## Validate Project State

```bash
flutter_shadcn doctor
flutter_shadcn validate
flutter_shadcn audit
flutter_shadcn deps
```

## Use Overlay Components Safely

If `dry-run` shows overlay dependencies, ensure one wrapper is present at app/root scope:
- `ShadcnApp`
- `ShadcnLayer`
- `OverlayManagerLayer`

Install common base building blocks:

```bash
flutter_shadcn add app scaffold app_bar card
```
