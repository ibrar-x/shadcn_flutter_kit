# Tooltip

Hover-triggered tooltips built on the overlay primitives. Use `TooltipContainer` for the styled surface and wrap the trigger with `Tooltip` or `InstantTooltip`.

## Usage

```dart
Tooltip(
  tooltip: (context) => const TooltipContainer(
    child: Text('More info'),
  ),
  child: Icon(Icons.info_outline),
)
```

```dart
InstantTooltip(
  tooltipBuilder: (context) => const TooltipContainer(
    child: Text('Quick help'),
  ),
  child: Icon(Icons.help_outline),
)
```

## Notes
- Requires the overlay manager (`OverlayManager`) to be present in the widget tree.
- Styling can be customized via `TooltipTheme` or per-widget overrides.
