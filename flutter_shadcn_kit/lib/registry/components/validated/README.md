# Validated

Wrap a widget with form validation and render custom error UI.

## Usage
```dart
Validated<String>(
  validator: ValidatorBuilder(
    (value) => value == null || value.isEmpty
        ? InvalidResult('Required')
        : null,
  ),
  builder: (context, error, child) {
    return Column(
      children: [
        child!,
        if (error != null) Text((error as InvalidResult).message),
      ],
    );
  },
  child: TextField(),
)
```
