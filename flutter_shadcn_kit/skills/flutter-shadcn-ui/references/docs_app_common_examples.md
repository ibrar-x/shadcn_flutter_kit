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
- `docs/lib/pages/docs/components/select/select_example_1.dart`
- `docs/lib/pages/docs/components/text_field/text_field_features_example.dart`
- `docs/lib/pages/docs/components/dialog/dialog_example_1.dart`
- `docs/lib/pages/docs/components/popover/popover_example_1.dart`
- `docs/lib/pages/docs/components/drawer/drawer_example_1.dart`
- `docs/lib/pages/docs/components/table/table_example_1.dart`
- `docs/lib/pages/docs/components/navigation_menu/navigation_menu_example_1.dart`
- `docs/lib/pages/docs/components/command/command_example_1.dart`
- `docs/lib/pages/docs/components/toast/toast_example_1.dart`
- `docs/lib/pages/docs/components/tabs/tabs_example_1.dart`
- `docs/lib/pages/docs/components/date_picker/date_picker_popover_example.dart`
- `docs/lib/pages/docs/components/multiselect/multiselect_example_3.dart`
- `docs/lib/pages/docs/components/context_menu/context_menu_example_1.dart`
- `docs/lib/pages/docs/components/stepper/stepper_example_6.dart`
- `docs/lib/pages/docs/components/resizable/resizable_example_7.dart`
- `docs/lib/pages/docs/components/file_picker/file_picker_hot_drop_example.dart`

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

## 8) Common input: Select with popup constraints

Pattern: `Select<T>` + `SelectPopup` + controlled value state.

```dart
Select<String>(
  value: selectedValue,
  placeholder: const Text('Select a fruit'),
  itemBuilder: (context, item) => Text(item),
  popupConstraints: const BoxConstraints(maxHeight: 300, maxWidth: 200),
  onChanged: (value) => setState(() => selectedValue = value),
  popup: const SelectPopup(
    items: SelectItemList(
      children: [
        SelectItemButton(value: 'Apple', child: Text('Apple')),
        SelectItemButton(value: 'Banana', child: Text('Banana')),
        SelectItemButton(value: 'Cherry', child: Text('Cherry')),
      ],
    ),
  ),
);
```

## 9) Common input: TextField with features (leading + clear)

Pattern: `TextField` + `InputFeature.leading` + `InputFeature.clear`.

```dart
TextField(
  initialValue: 'Hello World!',
  placeholder: const Text('Search something...'),
  features: [
    InputFeature.leading(
      const Icon(Icons.search),
      visibility: InputFeatureVisibility.textEmpty,
    ),
    InputFeature.clear(
      visibility:
          (InputFeatureVisibility.textNotEmpty & InputFeatureVisibility.focused) |
          InputFeatureVisibility.hovered,
    ),
  ],
);
```

## 10) Common overlay: Dialog with embedded form

Pattern: open dialog, mount a small `Form`, return values on save.

```dart
final controller = FormController();

shadcn_dialog.showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Edit profile'),
    content: Form(
      controller: controller,
      child: const FormTableLayout(
        rows: [
          FormField<String>(key: FormKey(#name), label: Text('Name'), child: TextField()),
          FormField<String>(key: FormKey(#username), label: Text('Username'), child: TextField()),
        ],
      ),
    ),
    actions: [
      PrimaryButton(
        onPressed: () => Navigator.of(context).pop(controller.values),
        child: const Text('Save changes'),
      ),
    ],
  ),
);
```

## 11) Common overlay: Anchored popover with form content

Pattern: `showPopover` + `OverlayBarrier` + compact `FormTableLayout`.

```dart
showPopover(
  context: context,
  alignment: Alignment.topCenter,
  offset: const Offset(0, 8),
  overlayBarrier: OverlayBarrier(borderRadius: Theme.of(context).borderRadiusLg),
  builder: (context) => ModalContainer(
    child: Form(
      controller: FormController(),
      child: const FormTableLayout(
        rows: [
          FormField<double>(key: FormKey(#width), label: Text('Width'), child: TextField()),
          FormField<double>(key: FormKey(#height), label: Text('Height'), child: TextField()),
        ],
      ),
    ),
  ),
);
```

## 12) Complex overlay flow: Nested drawers

Pattern: recursive `openDrawer` calls + `closeOverlay`.

```dart
void open(BuildContext context, int depth) {
  openDrawer(
    context: context,
    expands: true,
    position: OverlayPosition.end,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Drawer ${depth + 1}'),
        PrimaryButton(onPressed: () => open(context, depth + 1), child: const Text('Open Another Drawer')),
        SecondaryButton(onPressed: () => closeOverlay(context), child: const Text('Close Drawer')),
      ],
    ),
  );
}
```

## 13) Common data display: Table with header/body/footer

Pattern: `TableRow` + aligned numeric cells + footer summary.

```dart
Table(
  rows: [
    TableRow(cells: [/* header cells */]),
    TableRow(cells: [/* body cells */]),
    TableFooter(
      cells: [
        TableCell(
          columnSpan: 4,
          child: Row(
            children: const [
              Text('Total'),
              Expanded(child: Align(alignment: Alignment.centerRight, child: Text('\$2,300.00'))),
            ],
          ),
        ),
      ],
    ),
  ],
);
```

## 14) Navigation composition: Rich NavigationMenu

Pattern: `NavigationMenu` + `NavigationMenuItem` + content lists.

```dart
NavigationMenu(
  children: [
    NavigationMenuItem(
      child: const Text('Getting started'),
      content: NavigationMenuContentList(
        children: [
          NavigationMenuContent(title: const Text('Introduction'), content: const Text('...'), onPressed: () {}),
          NavigationMenuContent(title: const Text('Installation'), content: const Text('...'), onPressed: () {}),
        ],
      ),
    ),
    NavigationMenuItem(onPressed: () {}, child: const Text('Documentation')),
  ],
);
```

## 15) Async search UX: Command palette

Pattern: `Command` async generator that yields categories as results arrive.

```dart
Command(
  builder: (context, query) async* {
    await Future.delayed(const Duration(milliseconds: 300));
    yield [
      CommandCategory(
        title: const Text('Suggestions'),
        children: [
          CommandItem(title: const Text('Calendar'), leading: const Icon(Icons.calendar_today), onTap: () {}),
          CommandItem(title: const Text('Settings'), leading: const Icon(Icons.settings_outlined), onTap: () {}),
        ],
      ),
    ];
  },
).sized(width: 300, height: 300);
```

## 16) Common feedback pattern: Toast with undo action

Pattern: `showToast` + custom surface + undo button closing overlay.

```dart
showToast(
  context: context,
  builder: (context, overlay) => SurfaceCard(
    child: Basic(
      title: const Text('Saved'),
      subtitle: const Text('Changes applied'),
      trailing: PrimaryButton(
        size: ButtonSize.small,
        onPressed: overlay.close,
        child: const Text('Undo'),
      ),
    ),
  ),
  duration: const Duration(seconds: 4),
);
```

## 17) Common navigation layout: Tabs header + IndexedStack body

Pattern: `Tabs` controls active index while body is rendered with `IndexedStack`.

```dart
int index = 0;

Column(
  children: [
    Tabs(
      index: index,
      children: const [
        TabItem(child: Text('Overview')),
        TabItem(child: Text('Billing')),
        TabItem(child: Text('Members')),
      ],
      onChanged: (value) => setState(() => index = value),
    ),
    const Gap(8),
    IndexedStack(
      index: index,
      children: const [
        SizedBox(height: 220, child: Center(child: Text('Overview content'))),
        SizedBox(height: 220, child: Center(child: Text('Billing content'))),
        SizedBox(height: 220, child: Center(child: Text('Members content'))),
      ],
    ),
  ],
);
```

## 18) Common form input: Date picker popover month view

Pattern: `ComponentTheme<DatePickerTheme>` + `PromptMode.popover`.

```dart
DateTime? value = DateTime.now();

ComponentTheme<DatePickerTheme>(
  data: const DatePickerTheme(mode: PromptMode.popover),
  child: DatePicker(
    value: value,
    initialViewType: CalendarViewType.month,
    onChanged: (next) => setState(() => value = next),
  ),
);
```

## 19) Complex selection: Async grouped MultiSelect popup

Pattern: `MultiSelect` + async `SelectPopup.builder` + grouped chips.

```dart
MultiSelect<String>(
  value: selectedValues,
  placeholder: const Text('Select tags'),
  onChanged: (value) => setState(() => selectedValues = value),
  itemBuilder: (context, item) => MultiSelectChip(
    value: item,
    child: Text(item),
  ),
  popup: SelectPopup.builder(
    searchPlaceholder: const Text('Search tags'),
    builder: (context, query) async {
      await Future.delayed(const Duration(milliseconds: 300));
      final items = getGroupedResults(query);
      return SelectItemBuilder(
        childCount: items.length,
        builder: (context, index) {
          final group = items[index];
          return SelectGroup(
            headers: [SelectLabel(child: Text(group.name))],
            children: [
              for (final value in group.values)
                SelectItemButton(value: value, child: Text(value)),
            ],
          );
        },
      );
    },
  ),
);
```

## 20) Complex action surface: Context menu with submenu + toggles

Pattern: `ContextMenu` + `MenuButton.subMenu` + `MenuCheckbox` + `MenuRadioGroup`.

```dart
ContextMenu(
  items: [
    const MenuButton(child: Text('Back')),
    const MenuButton(child: Text('Reload')),
    const MenuButton(
      child: Text('More Tools'),
      subMenu: [
        MenuButton(child: Text('Save Page As...')),
        MenuButton(child: Text('Developer Tools')),
      ],
    ),
    MenuDivider(),
    MenuCheckbox(
      value: showBookmarksBar,
      autoClose: false,
      onChanged: (context, value) => setState(() => showBookmarksBar = value),
      child: const Text('Show Bookmarks Bar'),
    ),
    MenuRadioGroup(
      value: selectedPerson,
      onChanged: (context, value) => setState(() => selectedPerson = value),
      children: const [
        MenuRadio(value: 0, child: Text('Pedro Duarte')),
        MenuRadio(value: 1, child: Text('Colm Tuite')),
      ],
    ),
  ],
  child: const SizedBox(
    width: 280,
    height: 160,
    child: Center(child: Text('Right click here')),
  ),
);
```

## 21) Complex workflow: Stepper with controller-driven navigation

Pattern: `StepperController` + `StepContainer` actions driving next/previous.

```dart
final controller = StepperController();

Stepper(
  controller: controller,
  steps: [
    Step(
      title: const Text('Account'),
      contentBuilder: (context) => StepContainer(
        actions: [
          const SecondaryButton(child: Text('Prev')),
          PrimaryButton(onPressed: controller.nextStep, child: const Text('Next')),
        ],
        child: const SizedBox(height: 180, child: Center(child: Text('Step 1 content'))),
      ),
    ),
    Step(
      title: const Text('Profile'),
      contentBuilder: (context) => StepContainer(
        actions: [
          SecondaryButton(onPressed: controller.previousStep, child: const Text('Prev')),
          PrimaryButton(onPressed: controller.nextStep, child: const Text('Next')),
        ],
        child: const SizedBox(height: 180, child: Center(child: Text('Step 2 content'))),
      ),
    ),
  ],
);
```

## 22) Complex layout: Dynamic resizable pane collection

Pattern: `ResizablePanel.vertical` + list-driven `ResizablePane` children.

```dart
ResizablePanel.vertical(
  children: [
    for (final pane in panes)
      ResizablePane(
        key: ValueKey(pane.id),
        initialSize: 200,
        minSize: 100,
        child: pane.child,
      ),
  ],
);
```

## 23) Common file flow: Drag-and-drop FileUpload

Pattern: `FileUpload` + drag-drop options + selected files callback.

```dart
FileUpload(
  pickFiles: pickFilesWithPackage,
  title: const Text('Drop files here'),
  subtitle: const Text('Drag files onto the dropzone'),
  options: const FileUploadDragDropOptions(
    enableDragDrop: true,
    icon: Icon(RadixIcons.upload),
    hint: Text('Drop files or click to browse'),
  ),
  itemsMaxHeight: 220,
  onFilesSelected: (files) => setState(() => selectedFiles = files),
);
```

## Usage rule for generated code

1. Start from one of these recipes.
2. Replace labels/fields/validators with app-specific requirements.
3. Keep shadcn components as primary building blocks.
4. Check `COMMON_PATCHED_WIDGETS_README.md` before introducing custom Material/Cupertino widgets.
