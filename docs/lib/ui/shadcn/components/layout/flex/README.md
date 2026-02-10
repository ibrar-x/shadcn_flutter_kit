# Flex

Patched `Flex/Row/Column` and `Stack` widgets with custom `paintOrder`
support for layered painting and top-first hit testing.

## Highlights

- `Flexible` and `Expanded` support `paintOrder`.
- `PaintOrder` wraps non-flex children in a `Flex`.
- `Positioned` supports `paintOrder` in `Stack`.
- Keeps normal layout behavior while changing paint/hit-test order.
