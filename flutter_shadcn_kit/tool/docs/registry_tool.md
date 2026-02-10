# registry_tool.dart

Interactive registry helper for bootstrapping and syncing components.

## Commands
- `init` — prompt-driven component/composite creation and components.json update.
- `sync` — refreshes file lists and taxonomy folders for existing entries.
- `add-impl` — creates a stub under `_impl` and adds part "../../../tool/docs"directives.

## Usage
```bash
dart run ../tool/registry_tool.dart <command>
```
