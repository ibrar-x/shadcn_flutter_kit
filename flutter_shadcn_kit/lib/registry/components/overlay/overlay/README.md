# `overlay`

Central place to import overlay helpers (`OverlayHandler`, `OverlayBarrier`, `OverlayManagerLayer`, etc.) that the shared primitives expose.  

Install this component when you need access to the overlay manager/handler APIs without manually reaching into `_impl` files.

## ShadcnLayer

Use `ShadcnLayer` for a lightweight wrapper that only inserts an
`OverlayManagerLayer` when one is missing. It optionally applies a `Theme`
when provided.
