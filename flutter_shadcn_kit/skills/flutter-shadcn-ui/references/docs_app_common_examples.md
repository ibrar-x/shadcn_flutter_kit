# Docs App Common Examples

Use these examples as canonical composition patterns before inventing custom widgets.
All examples are derived from the docs app and grouped from easy to complex.

## Source files

- `docs/lib/pages/docs/components/form/form_basic_example.dart`
- `docs/lib/pages/docs/components/form/form_validation_example.dart`
- `docs/lib/pages/docs/components/form/form_example_3.dart`
- `docs/lib/pages/docs/components/sheet/sheet_example_1.dart`
- `docs/lib/pages/docs/components/switcher/switcher_example_2.dart`
- `docs/lib/pages/docs/components/filter_bar/filter_bar_basic_example.dart`
- `docs/lib/pages/docs/components/item_picker/item_picker_example_3.dart`

## 1) Easy: Basic form with submit

Pattern: `Form` + `FormField` + `TextField` + `SubmitButton`.

```dart
Form(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      FormField<String>(
        key: InputKey(#name),
        label: Text('Name'),
        validator: NotEmptyValidator(),
        child: TextField(
          placeholder: Text('Your name'),
        ),
      ),
      Gap(16),
      SubmitButton(child: Text('Save')),
    ],
  ),
);
```

Use this for single-section forms and settings rows.

## 2) Easy-to-medium: Validation states with multiple fields

Pattern: field-level validators + submit loading/error text.

```dart
Form(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      FormField<String>(
        key: InputKey(#email),
        label: Text('Email'),
        validator: EmailValidator(),
        child: TextField(placeholder: Text('name@acme.com')),
      ),
      Gap(12),
      FormField<String>(
        key: InputKey(#password),
        label: Text('Password'),
        validator: LengthValidator(min: 6),
        child: TextField(
          placeholder: Text('At least 6 characters'),
          obscureText: true,
        ),
      ),
      Gap(16),
      SubmitButton(
        loading: Text('Validating...'),
        error: Text('Fix errors'),
        child: Text('Create account'),
      ),
    ],
  ),
);
```

## 3) Complex: Registration form with async + cross-field validation

Pattern: composed validators, conditional async checks, compare-to-password validation.

```dart
Form(
  onSubmit: (context, values) { /* handle values */ },
  child: Column(
    children: [
      FormTableLayout(
        rows: [
          FormField(
            key: const TextFieldKey('username'),
            label: const Text('Username'),
            validator: const LengthValidator(min: 4) &
                ValidationMode(
                  ConditionalValidator((value) async {
                    await Future.delayed(const Duration(seconds: 1));
                    return true; // replace with availability check
                  }, message: 'Username already taken'),
                  mode: {FormValidationMode.submitted},
                ),
            child: const TextField(initialValue: 'M Ibrar'),
          ),
          FormField(
            key: const TextFieldKey('password'),
            label: const Text('Password'),
            validator: const LengthValidator(min: 8),
            showErrors: const {
              FormValidationMode.submitted,
              FormValidationMode.changed,
            },
            child: const TextField(obscureText: true),
          ),
          FormField<String>(
            key: const TextFieldKey('confirmPassword'),
            label: const Text('Confirm Password'),
            validator: CompareWith.equal(
              const TextFieldKey('password'),
              message: 'Passwords do not match',
            ),
            showErrors: const {
              FormValidationMode.submitted,
              FormValidationMode.changed,
            },
            child: const TextField(obscureText: true),
          ),
        ],
      ),
      const Gap(24),
      const SubmitButton(child: Text('Register')),
    ],
  ),
);
```

## 4) Complex: Overlay sheet containing validated form

Pattern: `openSheet` + `FormController` + `FormErrorBuilder` + `closeSheet`.

```dart
final controller = FormController();

openSheet(
  context: context,
  position: OverlayPosition.end,
  builder: (context) {
    return Form(
      controller: controller,
      child: Column(
        children: [
          FormTableLayout(
            rows: const [
              FormField<String>(
                key: FormKey(#name),
                label: Text('Name'),
                validator: NotEmptyValidator() & LengthValidator(min: 4),
                child: TextField(initialValue: 'M Ibrar'),
              ),
            ],
          ),
          FormErrorBuilder(
            builder: (context, errors, _) => PrimaryButton(
              onPressed: errors.isNotEmpty
                  ? null
                  : () async {
                      final result = await context.submitForm();
                      if (result.errors.isEmpty) {
                        closeSheet(context);
                      }
                    },
              child: const Text('Save changes'),
            ),
          ),
        ],
      ),
    );
  },
);
```

## 5) App composition: Filter bar + chips + local filtering

Pattern: stateful list filtering with `FilterBar` and `Chip`.

```dart
FilterState state = const FilterState(sortId: 'newest');

Column(
  children: [
    FilterBar(
      state: state,
      presentation: FilterBarPresentation.inline,
      sortOptions: const [
        FilterSortOption(id: 'newest', label: 'Newest'),
        FilterSortOption(id: 'oldest', label: 'Oldest'),
      ],
      enableDateRange: true,
      onStateChanged: (next) => setState(() => state = next),
    ),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: visibleOrders.map((o) => Chip(child: Text(o))).toList(),
    ),
  ],
);
```

## 6) App composition: Item picker dialog + toast feedback

Pattern: dialog-like picker flow and success/cancel feedback toast.

```dart
PrimaryButton(
  onPressed: () {
    showItemPickerDialog<ColorItem>(
      context,
      items: ItemList(colors),
      initialValue: colors[selectedIndex],
      title: const Text('Pick a color'),
      builder: (context, item) => ItemPickerOption(
        value: item,
        label: Text(item.name),
        child: Container(width: 80, height: 80, color: item.color),
      ),
    ).then((value) {
      if (!context.mounted) return;
      showToast(
        context: context,
        builder: (context, overlay) =>
            SurfaceCard(child: Text(value == null ? 'No selection' : 'Picked ${value.name}')),
      );
    });
  },
  child: const Text('Show Item Picker'),
);
```

## 7) Complex app flow: Login/Register switcher

Pattern: `Switcher` with two forms and retained controllers.

```dart
Switcher(
  index: isRegister ? 1 : 0,
  onIndexChanged: (index) => setState(() => isRegister = index == 1),
  direction: AxisDirection.left,
  children: [
    Form(controller: loginController, child: /* login fields */),
    Form(controller: registerController, child: /* register fields */),
  ],
);
```

## Usage rule for generated code

1. Start from one of these recipes.
2. Replace labels/fields/validators with app-specific requirements.
3. Keep shadcn components as primary building blocks.
4. Check `COMMON_PATCHED_WIDGETS_README.md` before introducing custom Material/Cupertino widgets.
