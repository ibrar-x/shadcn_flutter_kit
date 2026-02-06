# Stepper (`stepper`)

Multi-step progress with interactive step indicators.

---

## When to use

- Use this when:
  - you need a guided multi-step flow.
- Avoid when:
  - a static list of steps is sufficient (use `steps`).

---

## Install

```bash
flutter_shadcn add stepper
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/stepper/stepper.dart';
```

---

## Minimal example

```dart
final controller = StepperController();

Stepper(
  controller: controller,
  steps: const [
    Step(title: Text('Step 1')),
    Step(title: Text('Step 2')),
  ],
)
```

---

## API

### Constructor

- `Stepper`
  - `steps` (`List<Step>`, required)
  - `controller` (`StepperController?`)
  - `direction`, `variant`, `size`
- `Step` — step definition with title and optional content.
- `StepperController` — controls current step.
- `StepVariant` — visual variants.
- `StepSize` — size presets.
- `StepState` — e.g. `failed`.

---

## Theming

- `StepperTheme` controls spacing, colors, and indicator sizing.

---

## Accessibility

- Provide clear step titles and focus behavior.

---

## Do / Don’t

**Do**
- ✅ Use `StepperController` to coordinate state.

**Don’t**
- ❌ Hide error states for invalid steps.

---

## Related components

- `steps`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
