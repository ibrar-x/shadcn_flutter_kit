# Flutter Shadcn Registry Schemas

This guide explains the three core registry schemas and how they work together.

---

## Overview

| Schema | File | Purpose | Used For | Size |
|--------|------|---------|----------|------|
| **Index** | `index.json` | Lightweight discovery | list, search, info | ~50KB |
| **Components** | `components.json` | Full registry metadata | add, remove, dry-run | ~500KB |
| **Shared** | `<name>.json` | Shared utilities | All components | Per-file |

The schemas work as a hierarchy:
```
index.json (fast discovery)
    ↓
  components.json (detailed metadata)
    ↓
  shared/*.json (shared utilities)
```

---

## Index Schema (`index.json`)

The lightweight index used by discovery commands.

### Structure

```json
{
  "schemaVersion": 1,
  "generatedAt": "2024-02-04T10:30:00Z",
  "components": [
    {
      "id": "button",
      "name": "Button",
      "category": "Interactive",
      "description": "Interactive clickable element",
      "tags": ["interactive", "form", "action"],
      "install": "flutter_shadcn add button",
      "import": "import 'package:shadcn_flutter/button.dart';",
      "importPath": "lib/ui/shadcn/components/control/button/button.dart",
      "api": {
        "constructors": [
          "ShadButton({required String label, VoidCallback? onPressed})",
          "ShadButton.icon({required Icon icon, VoidCallback? onPressed})"
        ],
        "callbacks": [
          "onPressed - Called when button is clicked"
        ]
      },
      "examples": {
        "minimal": "ShadButton(label: 'Click', onPressed: () {})"
      },
      "dependencies": {
        "pubspec": {
          "gap": "^2.0.0"
        },
        "shared": ["color_extensions", "theme_tokens"]
      },
      "related": ["icon_button", "button_group"]
    }
  ]
}
```

### Key Properties

- **id** (string): Unique identifier, lowercase with underscores
- **name** (string): Display name
- **category** (string): Component category (Interactive, Form, Layout, etc.)
- **description** (string): One-line description
- **tags** (array): Search keywords
- **install** (string): Command to install this component
- **import** (string): Import statement to use the component
- **importPath** (string): Full path relative to project root
- **api** (object): Constructor and callback signatures
- **examples** (object): Minimal usage code snippet
- **dependencies** (object): pubspec packages and shared utilities
- **related** (array): List of related component IDs

### Why Index is Lightweight

Only includes:
- Metadata (name, description, tags)
- One import statement (not full file list)
- Constructors (not full API)
- One minimal example (not all variations)
- Dependency overview (not detailed files)

**NOT included:**
- Full file listings
- Complete platform configurations
- All code examples
- Detailed post-install steps

Result: `index.json` (~50KB) vs `components.json` (~500KB) = **10x faster discovery**

### Discovery Flow

```bash
$ flutter_shadcn search button
1. Load index.json (from cache or remote) [FAST - 50KB]
2. Search component metadata (name, description, tags)
3. Return matching components [INSTANT]

$ flutter_shadcn info button
1. Load index.json
2. Retrieve component details from index
3. Display with code formatting [COMPLETE INFO]

$ flutter_shadcn add button
1. Load index.json (get basic info)
2. Load components.json (get full details) [DETAILED]
3. Resolve dependencies
4. Execute installation
```

---

## Components Schema (`components.json`)

The full registry manifest with complete metadata.

### Structure

```json
{
  "schemaVersion": 1,
  "name": "shadcn-flutter-registry",
  "flutter": {
    "minSdk": "3.0.0"
  },
  "defaults": {
    "installPath": "lib/ui/shadcn",
    "sharedPath": "lib/ui/shadcn/shared"
  },
  "shared": [
    {
      "id": "color_extensions",
      "description": "Color utility extensions",
      "files": [
        {
          "path": "theme/color_extensions.dart",
          "symbols": [
            {
              "kind": "extension",
              "name": "ColorX",
              "signature": "extension ColorX on Color",
              "description": "Extension methods for Color",
              "visibility": "public",
              "usageExamples": [
                "Colors.blue.withOpacity(0.5)"
              ]
            }
          ]
        }
      ]
    }
  ],
  "components": [
    {
      "id": "button",
      "name": "Button",
      "description": "Interactive clickable button with variants",
      "category": "Interactive",
      "tags": ["interactive", "form", "action"],
      "files": [
        {
          "source": "components/control/button/button.dart",
          "destination": "<installPath>/components/control/button/button.dart"
        },
        {
          "source": "components/control/button/_impl/core/button_core.dart",
          "destination": "<installPath>/components/control/button/_impl/core/button_core.dart"
        }
      ],
      "shared": ["color_extensions", "theme_tokens"],
      "dependsOn": [],
      "pubspec": {
        "dependencies": {
          "gap": "^2.0.0",
          "flutter": {"sdk": "flutter"}
        }
      },
      "assets": [],
      "fonts": [],
      "platform": {
        "ios": {
          "notes": ["Button works on iOS 12+"]
        }
      },
      "postInstall": [
        "Run flutter pub get",
        "Restart your IDE for autocomplete"
      ]
    }
  ]
}
```

### Root Properties

```typescript
{
  "schemaVersion": number        // Version for schema evolution
  "name": string                 // Registry name
  "flutter": {
    "minSdk": string            // Minimum Flutter SDK version (e.g., "3.0.0")
  }
  "defaults": {
    "installPath": string       // Default component install location
    "sharedPath": string        // Default shared utilities location
  }
  "shared": SharedEntry[]       // Shared utility definitions
  "components": ComponentEntry[] // Component definitions
}
```

### Component Properties

```typescript
{
  "id": string                              // Unique ID
  "name": string                            // Display name
  "description": string                     // What it does
  "category": string                        // Category (Interactive, Form, Layout, etc.)
  "tags": string[]                          // Search keywords
  "files": FileMapping[]                    // Source → destination files
  "shared": string[]                        // Shared utility IDs required
  "dependsOn": string[]                     // Component dependencies
  "pubspec": {
    "dependencies": Record<string, string>  // pubspec.yaml dependencies
    "dev_dependencies": Record<string, string>
  }
  "assets": string[]                        // Asset paths to copy
  "fonts": FontEntry[]                      // Font definitions
  "platform": {                             // Platform-specific config
    "ios": PlatformEntry
    "android": PlatformEntry
    "windows": PlatformEntry
    "macos": PlatformEntry
  }
  "postInstall": string[]                   // Instructions after install
}
```

### FileMapping Options

Simple string (source = destination):
```json
"files": ["components/control/button/button.dart"]
```

Complex object with optional dependsOn:
```json
"files": [
  {
    "source": "components/control/button/button.dart",
    "destination": "<installPath>/components/control/button/button.dart"
  },
  {
    "source": "components/control/button/_impl/core/button_core.dart",
    "destination": "<installPath>/components/control/button/_impl/core/button_core.dart",
    "dependsOn": [
      "theme_tokens",
      {"source": "utils/extensions.dart", "optional": false}
    ]
  }
]
```

### Shared Entry Structure

```typescript
{
  "id": string                       // Shared utility ID
  "description": string              // Purpose
  "files": SharedFile[]              // Shared file definitions
  "pubspec": Record<string, string>  // Dependencies for this shared group
  "dependsOnShared": string[]        // Other shared groups this depends on
}
```

### Platform Entry Structure

```typescript
{
  "permissions": string[]            // Required permissions
  "infoPlist": Record<string, string>// iOS Info.plist entries
  "entitlements": string[]            // iOS entitlements
  "podfile": string[]                // Cocoapods dependencies
  "gradle": string[]                 // Android Gradle configurations
  "config": string[]                 // Windows/macOS configs
  "notes": string[]                  // Post-install notes
}
```

---

## Shared Schema (`shared/schema.json`)

Defines shared utilities that components depend on.

### Structure

```json
{
  "schemaVersion": 1,
  "id": "form_helpers",
  "name": "Form Helpers",
  "description": "Utilities for form building and validation",
  "files": [
    {
      "path": "form_control.dart",
      "symbols": [
        {
          "kind": "class",
          "name": "FormControl",
          "signature": "class FormControl<T> extends ValueNotifier<T?>",
          "description": "Base class for form field control",
          "visibility": "public",
          "doc": "Manages form field value and validation state",
          "usageExamples": [
            "final control = FormControl<String>()",
            "control.value = 'text'"
          ]
        },
        {
          "kind": "typedef",
          "name": "Validator",
          "signature": "typedef Validator<T> = String? Function(T? value)",
          "description": "Validation function signature"
        }
      ]
    },
    {
      "path": "form_value_supplier.dart",
      "symbols": [
        {
          "kind": "class",
          "name": "FormValueSupplier",
          "signature": "class FormValueSupplier",
          "visibility": "public"
        }
      ]
    }
  ],
  "pubspec": {
    "data_widget": "^2.0.0"
  },
  "dependsOnShared": ["theme_tokens"]
}
```

### Symbol Kinds

- **class** - Dart class
- **mixin** - Dart mixin
- **extension** - Extension on another type
- **enum** - Enumeration
- **typedef** - Type alias
- **function** - Top-level function
- **const** - Constant value
- **variable** - Module variable

### Symbol Properties

```typescript
{
  "kind": SymbolKind                              // What this is
  "name": string                                  // Identifier name
  "signature": string                             // Full type signature
  "description": string                           // One-line description
  "visibility": "public" | "internal"             // public = can be used by apps/skills
  "doc": string                                   // Doc comment
  "tags": string[]                                // Search tags
  "usageExamples": string[]                       // Code examples
  "since": string                                 // Version/date introduced
  "deprecated": {
    "isDeprecated": boolean
    "message": string                             // Deprecation message
  }
}
```

### Visibility

- **public** - Can be used by component code and user apps/skills
- **internal** - Intended only for internal CLI use, not exposed to users

---

## Schema Validation

### Validation Rules

1. **IDs must be unique and lowercase**
   ```json
   "id": "button"        ✓ Valid
   "id": "Button"        ✗ Invalid (must be lowercase)
   "id": "my-button"     ✗ Invalid (use underscore, not hyphen)
   ```

2. **File paths must be relative**
   ```json
   "source": "components/control/button/button.dart"     ✓ Valid
   "source": "/components/control/button/button.dart"    ✗ Invalid (no leading slash)
   "source": "button.dart"            ✓ Valid (can be single file)
   ```

3. **Dependencies must be resolvable**
   ```json
   "dependsOn": ["input", "theme"]
   // Each ID must exist in components[]
   ```

4. **Shared references must exist**
   ```json
   "shared": ["color_extensions", "form_helpers"]
   // Each ID must exist in shared[]
   ```

5. **pubspec versions must be semantic**
   ```json
   "pubspec": {
     "gap": "^2.0.0"     ✓ Valid
     "gap": "2.0"        ✗ Invalid (incomplete semver)
   }
   ```

### Using `doctor` to Validate

```bash
$ flutter_shadcn doctor
✓ components.json: Valid schema
✓ Dependency graph: Resolvable (no cycles)
✓ Shared references: All exist
✓ File paths: 42 components, 156 files

$ flutter_shadcn doctor --verbose
Validating against components.schema.json...
✓ Schema version: 1 (current)
✓ Required fields present
✓ Type validation passed
✓ ID patterns correct
✓ Dependency resolution: DAG (no cycles)
```

---

## Schema Evolution

### Version History

- **Version 1**: Initial schema (current)
  - component files with mappings
  - shared utilities with symbol definitions
  - platform configurations
  - pubspec dependencies

### Migration Example

If schemaVersion updates to 2 (hypothetical):

```bash
# Old: version 1
{
  "schemaVersion": 1,
  "components": [...]
}

# New: version 2
{
  "schemaVersion": 2,
  "components": [...]
  "features": {        # New field
    "theming": true
  }
}

# CLI automatically handles migration
```

---

## Common Schema Patterns

### Pattern 1: Component with No Dependencies

```json
{
  "id": "badge",
  "name": "Badge",
  "dependsOn": [],        // No component dependencies
  "files": ["badge/badge.dart"],
  "shared": ["theme_tokens"],  // But uses shared utilities
  "pubspec": {
    "dependencies": {}    // No pubspec dependencies
  }
}
```

### Pattern 2: Component with Multiple Dependencies

```json
{
  "id": "menu",
  "name": "Menu",
  "dependsOn": ["popover", "overlay"],  // Depends on other components
  "shared": ["color_extensions", "theme_tokens"],
  "files": [
    "menu/menu.dart",
    "menu/menu_item.dart",
    "menu/menu_group.dart"
  ],
  "pubspec": {
    "dependencies": {
      "flutter_animate": "^4.0.0"
    }
  }
}
```

### Pattern 3: Component with Platform Config

```json
{
  "id": "camera",
  "name": "Camera Widget",
  "platform": {
    "ios": {
      "infoPlist": {
        "NSCameraUsageDescription": "Camera is needed for photos"
      },
      "permissions": ["camera"]
    },
    "android": {
      "gradle": ["implementation 'androidx.camera:camera-core:1.2.0'"],
      "permissions": ["android.permission.CAMERA"]
    }
  },
  "postInstall": [
    "1. Add camera permission to AndroidManifest.xml",
    "2. Update iOS Info.plist with usage description",
    "3. Run flutter pub get"
  ]
}
```

### Pattern 4: Shared Utilities with Dependencies

```json
{
  "id": "form_helpers",
  "name": "Form Helpers",
  "files": ["form_control.dart", "form_value_supplier.dart"],
  "pubspec": {
    "dependencies": {
      "data_widget": "^2.0.0"
    }
  },
  "dependsOnShared": ["color_extensions", "theme_tokens"]
}
```

---

## Reading Schemas Programmatically

### TypeScript Example

```typescript
interface Component {
  id: string;
  name: string;
  dependsOn: string[];
  files: string[];
  shared: string[];
  pubspec: Record<string, string>;
}

function validateComponent(comp: Component): boolean {
  // Check ID format
  if (!/^[a-z0-9_]+$/.test(comp.id)) return false;
  
  // Check dependencies exist
  // (in real code, check against registry)
  
  // Check files are relative
  if (comp.files.some(f => f.startsWith('/'))) return false;
  
  return true;
}
```

### Python Example

```python
import json

def load_registry(path: str) -> dict:
    with open(path) as f:
        return json.load(f)

def resolve_dependencies(comp_id: str, registry: dict) -> list:
    """Recursively resolve all dependencies for a component"""
    component = next((c for c in registry['components'] if c['id'] == comp_id), None)
    if not component:
        return []
    
    deps = []
    for dep_id in component.get('dependsOn', []):
        deps.append(dep_id)
        deps.extend(resolve_dependencies(dep_id, registry))
    
    return list(dict.fromkeys(deps))  # Remove duplicates, preserve order
```

---

## Best Practices

1. **Keep IDs immutable** - Once published, never change a component ID
2. **Validate before publishing** - Use `components.schema.json` for validation
3. **Version pubspec deps explicitly** - Use semantic versioning (e.g., `^2.0.0`)
4. **Document symbols** - Add `description` and `doc` to shared symbols
5. **Use relative paths** - All file paths relative to registry root
6. **Order dependencies** - List in dependency graph order (dependencies first)
7. **Test resolution** - Verify dependency graphs have no cycles
8. **Include post-install notes** - Help users understand what was installed
