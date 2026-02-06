# Docs Utils Usage (Examples Scope)

This file documents **where and how utils are used in the docs app examples** so the same patterns can be mirrored in the registry later.

> Note: This file is **local-only** and is not meant to be committed.

## Utils used in examples

### SeparatedIterable / join()
- **What it does:** `join()` builds a lazily separated iterable, inserting a separator widget between items without manual list plumbing.
- **Why in examples:** Keeps layout examples tidy and shows the recommended spacing pattern.
- **Used in:**
  - `lib/pages/docs/components/toggle/toggle_example_2.dart`
    - Replaces `.gap(4)` with `join([...], const Gap(4)).toList()` to separate toggle buttons.
  - `lib/pages/docs/components/switcher/switcher_example_1.dart`
    - Uses `join([...], const Gap(8))` to separate action buttons before the switcher.
  - `lib/pages/docs/components/phone_input/phone_input_example_1.dart`
    - Uses `join([...], const Gap(24))` to separate the input and output text.

### clearActiveTextInput()
- **What it does:** Clears the currently focused text input (if any) programmatically.
- **Why in examples:** Demonstrates a safe, global “clear focused field” action.
- **Used in:**
  - `lib/pages/docs/components/text_field/text_field_features_example.dart`
    - Adds a button to clear the focused text field.

## Available (but not used yet in examples)
Use these when there is a natural fit in future examples:

- **mutateSeparated()**
  - Efficient in-place update for lists that include separators.
  - Best for dynamic lists where items are inserted/removed frequently.

- **SeparatedIterable**
  - Base iterable type powering `join()`.
  - Use when you need lazy separator insertion without converting to a list.

- **Convert<F, T> typedef + BiDirectionalConvert**
  - Cleaner conversion signatures for bidirectional transforms.

- **TextFieldClearIntent**
  - Keyboard/action intent for clearing text fields. Use in examples with `Shortcuts/Actions`.

- **Axis utils (AxisInsets, AxisDirectional, etc.)**
  - Handy for orientation-aware layouts.

- **Utility helpers (degToRad, radToDeg, unlerpDouble, wrapDouble, etc.)**
  - Use when math/geometry examples appear.

- **Extensions (ListExtension, FutureOrExtension, ColorExtension, WidgetExtension, ColumnExtension, RowExtension, FlexExtension)**
  - Use sparingly to keep examples readable and explicit.

- **Core classes (SafeLerp, ConvertedController, CapturedWrapper, etc.)**
  - Use in advanced demos where type safety or controller bridging is the focus.
