# Hover Card

A hover/long-press popover wrapper for showing contextual content.

## Usage

```dart
HoverCard(
  hoverBuilder: (context) => const TooltipContainer(
    child: Text('More details'),
  ),
  child: Icon(Icons.info_outline),
)
```

## Notes
- Uses `OverlayManager` for popover placement and follows tooltip layer defaults.
- Theme with `HoverCardTheme` to adjust delays and alignment.
