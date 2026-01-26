# `ScrollableClient`

`ScrollableClient` exposes a two-dimensional scrolling surface that gives fine-grained control over drag behavior, clipping, keyboard dismissal, and overscroll handling. The builder receives the current viewport offset so consumers can redraw layout- or animation-sensitive views without paying for full widget rebuilds.

Use the accompanying `ScrollableClientTheme` to override defaults such as drag-gesture behavior, hit testing, or whether overscroll is allowed.
