part of '../../stepper.dart';

class StepContainer extends StatefulWidget {
  /// The main content widget for the step.
  final Widget child;

  /// List of action widgets (typically buttons) displayed below content.
  final List<Widget> actions;

  /// Creates a [StepContainer].
  ///
  /// The [child] and [actions] parameters are required. Actions can be
  /// an empty list if no buttons are needed.
  ///
  /// Parameters:
  /// - [child] (Widget, required): main step content
  /// - [actions] (`List<Widget>`, required): action buttons or widgets
  ///
  /// Example:
  /// ```dart
  /// StepContainer(
  ///   child: FormFields(),
  ///   actions: [
  ///     Button(onPressed: previousStep, child: Text('Back')),
  ///     Button(onPressed: nextStep, child: Text('Continue')),
  ///   ],
  /// );
  /// ```
  const StepContainer({
    super.key,
    required this.child,
    required this.actions,
  });

  @override
  State<StepContainer> createState() => _StepContainerState();
}
