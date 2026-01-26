# File Input

File input helpers that let you register custom icons for extensions and reuse them across the registry.

Wrap tree nodes that render file lists with `FileIconProvider` so downstream widgets can call
`FileIconProvider.buildIcon(context, extension)` instead of inlining icon logic each time. You can
provide either a custom builder (for dynamic logic) or a static map of extension→widget pairs.

The default builder already handles common document, image, archive, and media extensions using
`BootstrapIcons`.
