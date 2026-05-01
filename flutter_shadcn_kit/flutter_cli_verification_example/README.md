# Flutter CLI Verification Example

This Flutter app is a smoke-test target for `flutter_shadcn_cli` install flows.
Its `.shadcn/config.json` points at the hosted GitHub registry under
`flutter_shadcn_kit/lib` and declares the manifest paths the CLI needs to
resolve components, schemas, the component index, theme index, and folder
structure.

Do not commit generated component installs from this example unless the smoke
test fixture intentionally changes.
