# Stepper

Multi-step navigation with visual progress indicators.

## Usage
```dart
final controller = StepperController();

Stepper(
  controller: controller,
  direction: Axis.vertical,
  steps: const [
    Step(title: Text('Details')),
    Step(title: Text('Payment')),
    Step(title: Text('Confirm')),
  ],
)
```
