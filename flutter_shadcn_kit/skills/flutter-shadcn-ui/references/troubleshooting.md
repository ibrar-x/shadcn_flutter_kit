# Troubleshooting

## Component Not Found

```bash
flutter_shadcn search <name>  # Search by keyword
flutter_shadcn list --refresh  # Force cache refresh
```

## Dependency Conflicts

```bash
flutter_shadcn dry-run <component>  # Preview dependencies
flutter_shadcn doctor             # Validate setup
```

## Theme Not Applying

```bash
flutter_shadcn sync              # Reapply current theme
flutter_shadcn theme modern-minimal  # Reapply specific theme
```

## Cache Issues

```bash
flutter_shadcn list --refresh    # Clear and rebuild cache
flutter_shadcn doctor            # Show cache location
```
