# Form

Form exposes reusable helpers for validation, state management, and submission around the Shadcn form primitives.

- `Form` wires together `FormController`, error builders, pending indicators and `FormField` children so you can validate groups of inputs with shared lifecycle hooks.
- `FormEntry`/`FormField` track validation state per field, optionally decorating each row with the active error and hint styles.
- `SubmitButton` auto-adjusts its content based on the current form result (`Valid`, `Waiting`, `Invalid`).
- Validators such as `RequiredValidator`, `EmailValidator`, and `MinLengthValidator` compose through `&`, `|`, and unary operators.

```dart
Form(
  children: [
    FormField(
      key: TextFieldKey('email'),
      label: const Text('Email'),
      validator: const EmailValidator(errorMessage: 'Enter a valid email'),
      child: TextField(
        controller: TextEditingController(),
        hintText: 'you@example.com',
      ),
    ),
    SubmitButton(
      child: const Text('Submit'),
      loading: const Text('Validating...'),
    ),
  ],
)
```

Theme overrides such as `ComponentTheme<FocusOutlineTheme>` or `ComponentTheme<TextFieldTheme>` wrap the form rows to highlight errors or adjust borders.
