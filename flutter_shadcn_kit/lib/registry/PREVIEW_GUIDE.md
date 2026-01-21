# Preview Generation Guide

When adding a new component preview or updating an existing one, **always read the component code first** to understand its actual API before writing previews.

## Workflow

1. **Read Component Code** - Examine the component's main file and implementation files
   - Look for the main widget classes (e.g., `PrimaryButton`, `SecondaryButton`)
   - Check constructor parameters and their types
   - Understand available enums/constants (e.g., `ButtonSize.normal`, `ButtonSize.small`)
   - Note any parameters that don't exist (e.g., `loading` parameter in Button)

2. **Write Accurate Previews** - Create `preview.dart` using only the actual API
   - Use only parameters that actually exist in the component
   - Use correct enum values found in the code
   - Test all variants to ensure they compile

3. **Structure** - Follow the preview structure for registry use

## Preview Template

Each component should have a `preview.dart` file in its directory:

```dart
import 'package:flutter/material.dart';
import 'package:__APP_PACKAGE__/ui/shadcn/components/[component]/[component].dart';
import '../preview_types.dart';

final PreviewEntry componentPreview = PreviewEntry(
  id: 'component',
  title: 'Component Title',
  description: 'Component description.',
  category: 'Category',
  tags: ['tag1', 'tag2'],
  usageCode: '''
// Example usage
Component(
  child: Text('Example'),
)
''',
  variants: [
    PreviewVariant(
      id: 'default',
      title: 'Default',
      builder: (context) => Component(
        child: const Text('Default'),
      ),
    ),
    // Add more variants...
  ],
);
```

## Key Points

- **`__APP_PACKAGE__`** - Placeholder replaced during sync (use for your component imports)
- **`PreviewEntry`** - Main preview container with metadata
- **`PreviewVariant`** - Individual preview instances for different states/configurations
- **Enum Values** - Always verify enum names against the source code
  - ✅ `ButtonSize.normal`, `ButtonSize.small`, `ButtonSize.large`
  - ❌ `ButtonSize.sm`, `ButtonSize.md`, `ButtonSize.lg` (wrong values)
- **Parameters** - Only use parameters that exist in constructor
  - ✅ `size`, `density`, `shape`
  - ❌ `loading` (doesn't exist in button variants)

## Example: Button Preview

```dart
// ✅ CORRECT: Uses actual API
PrimaryButton(
  size: ButtonSize.small,  // Correct enum value
  onPressed: () {},
  child: const Text('Small'),
)

// ❌ WRONG: Uses non-existent parameter
PrimaryButton(
  loading: true,  // This parameter doesn't exist!
  onPressed: () {},
)

// ❌ WRONG: Uses incorrect enum value
PrimaryButton(
  size: ButtonSize.sm,  // Should be ButtonSize.small
)
```

## Verification

Before syncing:
1. Run `flutter analyze` in the registry directory
2. Check that all component imports resolve
3. Verify enum values match the source code
4. Test previews compile without errors

During sync:
- Run `flutter_shadcn studio --sync`
- Check for compilation errors in the generated studio
- If errors occur, review the preview code against the component API

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Using `loading: true` on buttons | Button doesn't have loading param - use different visual pattern |
| Using `ButtonSize.sm` | Should be `ButtonSize.small` |
| Using `ButtonSize.md` | Should be `ButtonSize.normal` |
| Using `ButtonSize.lg` | Should be `ButtonSize.large` |
| Importing wrong component file | Check import path matches actual structure |

## Testing Your Preview

1. Create/update `registry/components/[name]/preview.dart`
2. Update the registry's template to include the new variant
3. Run `flutter_shadcn studio --sync` from your project
4. Launch studio: `flutter_shadcn studio --launch`
5. Check the sidebar - your component should appear with all variants

## Need Help?

- Check existing component previews in `registry/components/*/preview.dart`
- Read the component's `_impl/` files to understand all available options
- Look at the `button` preview as a reference example

