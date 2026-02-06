part of '../../form_field.dart';

/// State class for [ObjectFormField] managing form value and user interactions.
///
/// Handles value updates, popover/dialog display, and integrates with the
/// form validation system. This state also determines whether the field is
/// enabled based on the presence of an `onChanged` callback.
class ObjectFormFieldState<T> extends State<ObjectFormField<T>>
    with FormValueSupplier<T, ObjectFormField<T>> {
  final PopoverController _popoverController = PopoverController();

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  /// Gets the current form value.
  ///
  /// Returns: The current value of type `T?`.
  T? get value => formValue;

  /// Sets a new form value and notifies listeners.
  ///
  /// Parameters:
  /// - [value] (`T?`, required): The new value to set.
  set value(T? value) {
    widget.onChanged?.call(value);
    formValue = value;
  }

  @override
  void didReplaceFormValue(T value) {
    widget.onChanged?.call(value);
  }

  @override
  void didUpdateWidget(covariant ObjectFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  /// Whether this field is enabled.
  ///
  /// Returns true if explicitly enabled or if an `onChanged` callback exists.
  bool get enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  void _showDialog([T? value]) {
    value ??= formValue;
    showDialog(
      context: context,
      builder: (context) {
        return _ObjectFormFieldDialog<T>(
          dialogTitle: widget.dialogTitle,
          value: value,
          editorBuilder: widget.editorBuilder,
          dialogActions: widget.dialogActions,
          prompt: prompt,
          decorate: widget.decorate,
          onChanged: (value) {
            // by default, dialog will not immediately inform if value is changed
            // but if its explicitly set to true, then we should inform
            if (widget.immediateValueChange == true) {
              this.value = value;
            }
          },
        );
      },
    ).then((value) {
      if (mounted &&
          value is ObjectFormFieldDialogResult<T> &&
          // in dialog, by default we do not inform immediate change
          // so after dialog close, we should inform the final value
          widget.immediateValueChange != true) {
        this.value = value.value;
      }
    });
  }

  void _showPopover([T? value]) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    value ??= formValue;
    T? delayedResult = value;
    _popoverController
        .show(
      context: context,
      alignment: widget.popoverAlignment ?? Alignment.topLeft,
      anchorAlignment: widget.popoverAnchorAlignment ?? Alignment.bottomLeft,
      overlayBarrier: OverlayBarrier(
        borderRadius: BorderRadius.circular(theme.radiusLg),
      ),
      modal: true,
      offset: Offset(0, 8 * scaling),
      builder: (context) {
        return _ObjectFormFieldPopup<T>(
          value: value,
          editorBuilder: widget.editorBuilder,
          popoverPadding: widget.popoverPadding,
          prompt: prompt,
          decorate: widget.decorate,
          onChanged: (value) {
            // by default, popover will immediately inform any changes
            // but if its explicitly set to false, then we should not inform
            if (mounted && widget.immediateValueChange != false) {
              this.value = value;
            } else {
              delayedResult = value;
            }
          },
        );
      },
    )
        .then(
      (_) {
        if (mounted && widget.immediateValueChange == false) {
          this.value = delayedResult;
        }
      },
    );
  }

  /// Prompts the user to select or edit a value via dialog or popover.
  ///
  /// Displays the appropriate UI based on the configured [PromptMode].
  ///
  /// Parameters:
  /// - [value] (`T?`, optional): An initial value to display in the prompt.
  ///
  /// Example:
  /// ```dart
  /// fieldState.prompt(initialValue);
  /// ```
  void prompt([T? value]) {
    if (widget.mode == PromptMode.dialog) {
      _showDialog(value);
    } else {
      _showPopover(value);
    }
  }

  Widget? _decorateIcon(Widget? icon) {
    if (icon == null) {
      return null;
    }
    final theme = Theme.of(context);
    return IconTheme(
      data: IconThemeData(color: theme.colorScheme.mutedForeground),
      child: IconTheme(
        data: theme.iconTheme.small,
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? ButtonSize.normal;
    final density = widget.density ?? ButtonDensity.normal;
    final shape = widget.shape ?? ButtonShape.rectangle;
    return OutlineButton(
      trailing: _decorateIcon(widget.trailing),
      leading: _decorateIcon(widget.leading),
      size: size,
      density: density,
      shape: shape,
      onPressed: enabled && widget.onChanged != null ? prompt : null,
      enabled: enabled,
      child: value == null
          ? widget.placeholder.muted()
          : widget.builder(context, value as T),
    );
  }
}
