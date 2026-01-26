part of '../text_field.dart';

/// Abstract factory for creating input field feature components.
///
/// Provides factory constructors for common text field features like password
/// toggles, clear buttons, hints, autocomplete, and spinners. Features can be
/// conditionally shown based on field state using [InputFeatureVisibility].
///
/// Example:
/// ```dart
/// TextField(
///   leading: [
///     InputFeature.hint(
///       popupBuilder: (context) => Text('Enter email'),
///     ),
///   ],
///   trailing: [
///     InputFeature.clear(),
///     InputFeature.passwordToggle(),
///   ],
/// )
/// ```
abstract class InputFeature {
  /// Creates a hint/tooltip feature for the input field.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show hint.
  /// - [popupBuilder] (`WidgetBuilder`, required): Builds the hint popup content.
  /// - [icon] (`Widget?`, optional): Icon to display for the hint trigger.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place the hint.
  /// - [enableShortcuts] (`bool`, default: true): Enable keyboard shortcuts.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.hint({
    InputFeatureVisibility visibility,
    required WidgetBuilder popupBuilder,
    Widget? icon,
    InputFeaturePosition position,
    bool enableShortcuts,
    bool skipFocusTraversal,
  }) = InputHintFeature;

  /// Creates a password visibility toggle feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show toggle.
  /// - [mode] (`PasswordPeekMode`, default: toggle): Toggle or peek mode.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place toggle.
  /// - [icon] (`Widget?`, optional): Icon when password is hidden.
  /// - [iconShow] (`Widget?`, optional): Icon when password is visible.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.passwordToggle({
    InputFeatureVisibility visibility,
    PasswordPeekMode mode,
    InputFeaturePosition position,
    Widget? icon,
    Widget? iconShow,
    bool skipFocusTraversal,
  }) = InputPasswordToggleFeature;

  /// Creates a clear text button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: textNotEmpty): When to show clear button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom clear icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.clear({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputClearFeature;

  /// Creates a revalidate button feature.
  ///
  /// Triggers form validation when clicked.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom revalidate icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.revalidate({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputRevalidateFeature;

  /// Creates an autocomplete feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: focused): When to show autocomplete.
  /// - [querySuggestions] (`SuggestionBuilder`, required): Builds suggestion list.
  /// - [child] (`Widget`, required): Child widget in the autocomplete popup.
  /// - [popoverConstraints] (`BoxConstraints?`, optional): Size constraints for popup.
  /// - [popoverWidthConstraint] (`PopoverConstraint?`, optional): Width constraint mode.
  /// - [popoverAnchorAlignment] (`AlignmentDirectional?`, optional): Anchor alignment.
  /// - [popoverAlignment] (`AlignmentDirectional?`, optional): Popup alignment.
  /// - [mode] (`AutoCompleteMode`, default: popup): Display mode.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.autoComplete({
    InputFeatureVisibility visibility,
    required SuggestionBuilder querySuggestions,
    required Widget child,
    BoxConstraints? popoverConstraints,
    PopoverConstraint? popoverWidthConstraint,
    AlignmentDirectional? popoverAnchorAlignment,
    AlignmentDirectional? popoverAlignment,
    AutoCompleteMode mode,
    bool skipFocusTraversal,
  }) = InputAutoCompleteFeature;

  /// Creates a numeric spinner feature for incrementing/decrementing values.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show spinner.
  /// - [step] (`double`, default: 1): Increment/decrement step size.
  /// - [enableGesture] (`bool`, default: true): Enable drag gestures.
  /// - [invalidValue] (`double?`, optional): Value to use when input is invalid.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.spinner({
    InputFeatureVisibility visibility,
    double step,
    bool enableGesture,
    double? invalidValue,
    bool skipFocusTraversal,
  }) = InputSpinnerFeature;

  /// Creates a copy to clipboard button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: textNotEmpty): When to show copy button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom copy icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.copy({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputCopyFeature;

  /// Creates a paste from clipboard button feature.
  ///
  /// Parameters:
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show paste button.
  /// - [position] (`InputFeaturePosition`, default: trailing): Where to place button.
  /// - [icon] (`Widget?`, optional): Custom paste icon.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.paste({
    InputFeatureVisibility visibility,
    InputFeaturePosition position,
    Widget? icon,
    bool skipFocusTraversal,
  }) = InputPasteFeature;

  /// Creates a custom leading widget feature.
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Widget to display.
  /// - [visibility] (`InputFeatureVisibility`, default: always): When to show widget.
  /// - [skipFocusTraversal] (`bool`, default: false): Skip in focus order.
  const factory InputFeature.leading(
    Widget child, {
    InputFeatureVisibility visibility,
    bool skipFocusTraversal,
  }) = InputLeadingFeature;

  /// Creates a custom trailing widget feature.
  const factory InputFeature.trailing(
    Widget child, {
    InputFeatureVisibility visibility,
    bool skipFocusTraversal,
  }) = InputTrailingFeature;

  /// Visibility mode for this input feature.
  final InputFeatureVisibility visibility;

  /// Whether to skip this feature in focus traversal.
  final bool skipFocusTraversal;

  /// Creates an input feature.
  const InputFeature(
      {this.visibility = InputFeatureVisibility.always,
      this.skipFocusTraversal = true});

  /// Creates the state for this input feature.
  InputFeatureState createState();

  /// Checks if an old feature can be updated to a new feature.
  static bool canUpdate(InputFeature oldFeature, InputFeature newFeature) {
    return oldFeature.runtimeType == newFeature.runtimeType;
  }
}

/// Abstract base state class for input features.
///
/// Manages the lifecycle and state of features that extend text field
/// functionality, such as clear buttons, counters, or custom decorations.
abstract class InputFeatureState<T extends InputFeature> {
  _AttachedInputFeature? _attached;
  TextFieldState? _inputState;

  /// The input feature associated with this state.
  T get feature {
    assert(
        _attached != null && _attached!.feature is T, 'Feature not attached');
    return _attached!.feature as T;
  }

  /// The ticker provider for animations.
  TickerProvider get tickerProvider {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!;
  }

  /// The build context for this feature.
  BuildContext get context {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    final context = inputState!.editableTextKey.currentContext;
    if (context == null) {
      throw FlutterError(
          'InputFeatureState.context was accessed but editableTextKey.currentContext is null.\n'
          'This usually means the widget is not mounted. Ensure the widget is mounted before accessing context.');
    }
    return context;
  }

  /// The parent text field widget.
  TextField get input {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!.widget;
  }

  /// Whether this feature is currently attached to a text field.
  bool get attached => _attached != null;

  /// The text editing controller for the text field.
  TextEditingController get controller {
    var inputState = _inputState;
    assert(inputState != null, 'Feature not attached');
    return inputState!.effectiveController;
  }

  late AnimationController _visibilityController;

  Iterable<Widget> _internalBuildLeading() sync* {
    if (_visibilityController.value == 0) {
      return;
    }
    for (final widget in buildLeading()) {
      yield Hidden(
        hidden: _visibilityController.value < 1,
        duration: kDefaultDuration,
        child: widget,
      );
    }
  }

  Iterable<Widget> _internalBuildTrailing() sync* {
    if (_visibilityController.value == 0) {
      return;
    }
    for (final widget in buildTrailing()) {
      yield Hidden(
        hidden: _visibilityController.value < 1,
        duration: kDefaultDuration,
        child: widget,
      );
    }
  }

  /// Initializes this feature state.
  ///
  /// Called when the feature is first attached to a text field.
  void initState() {
    _visibilityController = AnimationController(
      vsync: tickerProvider,
      duration: kDefaultDuration,
    );
    _visibilityController.value =
        feature.visibility.canShow(_inputState!) ? 1 : 0;
    _visibilityController.addListener(_updateAnimation);
    for (var dependency in feature.visibility.getDependencies(_inputState!)) {
      dependency.addListener(_updateVisibility);
    }
  }

  /// Called when dependencies change.
  ///
  /// Override to respond to dependency changes in the widget tree.
  void didChangeDependencies() {}

  void _updateAnimation() {
    setState(() {});
  }

  void _updateVisibility() {
    bool canShow = feature.visibility.canShow(_inputState!);
    if (canShow && _visibilityController.value == 1) return;
    if (!canShow && _visibilityController.value == 0) return;
    if (canShow) {
      _visibilityController.forward();
    } else {
      _visibilityController.reverse();
    }
  }

  /// Disposes resources used by this feature state.
  ///
  /// Called when the feature is detached from the text field.
  void dispose() {
    _visibilityController.dispose();
    for (var dependency in feature.visibility.getDependencies(_inputState!)) {
      dependency.removeListener(_updateVisibility);
    }
  }

  /// Called when the feature is updated.
  ///
  /// Override to respond to feature configuration changes.
  void didFeatureUpdate(InputFeature oldFeature) {
    if (oldFeature.visibility != feature.visibility) {
      for (var oldDependency
          in oldFeature.visibility.getDependencies(_inputState!)) {
        oldDependency.removeListener(_updateVisibility);
      }
      for (var newDependency
          in feature.visibility.getDependencies(_inputState!)) {
        newDependency.addListener(_updateVisibility);
      }
    }
  }

  /// Called when the text field's text changes.
  ///
  /// Override to respond to text changes.
  void onTextChanged(String text) {}

  /// Called when the text field's selection changes.
  ///
  /// Override to respond to selection changes.
  void onSelectionChanged(TextSelection selection) {}

  /// Builds leading widgets for the text field.
  ///
  /// Override to provide widgets shown before the input.
  Iterable<Widget> buildLeading() sync* {}

  /// Builds trailing widgets for the text field.
  ///
  /// Override to provide widgets shown after the input.
  Iterable<Widget> buildTrailing() sync* {}

  /// Builds actions for keyboard shortcuts.
  ///
  /// Override to provide custom actions.
  Iterable<MapEntry<Type, Action<Intent>>> buildActions() sync* {}

  /// Builds keyboard shortcuts.
  ///
  /// Override to provide custom keyboard shortcuts.
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts() sync* {}

  /// Wraps the text field widget.
  ///
  /// Override to wrap the field with additional widgets.
  Widget wrap(Widget child) => child;

  /// Intercepts and modifies the text field configuration.
  ///
  /// Override to modify the text field before rendering.
  TextField interceptInput(TextField input) => input;

  /// Triggers a state update for the attached text field.
  ///
  /// Parameters:
  /// - [fn] (`VoidCallback`, required): State update callback.
  ///
  /// Throws: AssertionError if feature is not attached.
  void setState(VoidCallback fn) {
    assert(attached, 'Feature not attached');
    _inputState!._setStateFeature(fn);
  }
}
