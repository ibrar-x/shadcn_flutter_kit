# Eye Dropper

Wrap `EyeDropperLayer` around the subtree where you want to sample screen pixels.
Call `pickColorFromScreen` (or reach the scope via `EyeDropperLayerScope.find`) to prompt
the built-in overlay that shows a magnified preview and returns the selected color.

The optional `previewLabelBuilder` and `previewAlignment` let you customize the callout so
it matches your UI; the layer also hooks into `ColorHistoryStorage` so recent picks stay
in sync with `ColorInput`/`ColorPicker` history panels.
