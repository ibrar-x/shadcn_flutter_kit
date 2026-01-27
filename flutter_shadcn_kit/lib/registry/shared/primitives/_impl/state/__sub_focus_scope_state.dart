part of '../../subfocus.dart';


class _SubFocusScopeState extends State<SubFocusScope> with SubFocusScopeState {
  final List<SubFocusState> _attachedStates = [];
  SubFocusState? _currentState;
  bool _active = true;

  @override
  bool unfocus(SubFocusState child) {
    if (_currentState == child) {
      _currentState?.markFocused(false);
      _currentState = null;
      return true;
    }
    return false;
  }

  @override
  void activate() {
    super.activate();
    _active = true;
  }

  @override
  void deactivate() {
    _active = false;
    super.deactivate();
  }

  @override
  Object? invokeActionOnFocused(Intent intent) {
    return _currentState?.invokeAction(intent);
  }

  @override
  bool attach(SubFocusState state) {
    assert(
      !_attachedStates.contains(state),
      'SubFocusState is already attached to this SubFocusScope.',
    );
    _attachedStates.add(state);
    if (widget.autofocus) {
      _currentState ??= state;
    }
    return _currentState == state;
  }

  @override
  void detach(SubFocusState state) {
    _attachedStates.remove(state);
    if (_currentState == state) {
      _currentState = null;
      if (widget.autofocus) findFirstFocus(); // Find new focus
    }
  }

  void _setCurrentItem(SubFocusState item, bool? forward) {
    if (!mounted || !_active) {
      return;
    }
    final currentItem = _currentState;
    if (!mounted || !_active) {
      return;
    }
    currentItem?.markFocused(false);
    item.markFocused(true);
    item.ensureVisible(
      alignmentPolicy: forward == null
          ? ScrollPositionAlignmentPolicy.explicit
          : forward
              ? ScrollPositionAlignmentPolicy.keepVisibleAtEnd
              : ScrollPositionAlignmentPolicy.keepVisibleAtStart,
    );
    _currentState = item;
  }

  RenderBox? findRenderObject() {
    if (!mounted || !_active) {
      return null;
    }
    return context.findRenderObject() as RenderBox?;
  }

  @override
  bool nextFocus([TraversalDirection direction = TraversalDirection.down]) {
    if (!mounted || !_active) return false;
    if (_currentState != null) {
      final RenderBox? currentBox = _currentState!.findRenderObject();
      final RenderBox? parentBox = findRenderObject();
      if (currentBox == null || parentBox == null) {
        return false;
      }
      final Offset currentOffset =
          currentBox.localToGlobal(Offset.zero, ancestor: parentBox);

      late final bool horizontal;
      late final bool forward;
      switch (direction) {
        case TraversalDirection.down:
          horizontal = false;
          forward = true;
          break;
        case TraversalDirection.up:
          horizontal = false;
          forward = false;
          break;
        case TraversalDirection.right:
          horizontal = true;
          forward = true;
          break;
        case TraversalDirection.left:
          horizontal = true;
          forward = false;
          break;
      }

      (SubFocusState, double)? nearestNextItem;
      for (final attached in _attachedStates) {
        if (attached == _currentState) continue;
        final RenderBox? box = attached.findRenderObject();
        if (box == null) continue;
        final Offset offset =
            box.localToGlobal(Offset.zero, ancestor: parentBox);
        final double delta = horizontal
            ? (forward
                ? (offset.dx - currentOffset.dx)
                : (currentOffset.dx - offset.dx))
            : (forward
                ? (offset.dy - currentOffset.dy)
                : (currentOffset.dy - offset.dy));
        if (delta <= 0) continue;
        if (nearestNextItem == null || delta < nearestNextItem.$2) {
          nearestNextItem = (attached, delta);
        }
      }
      if (nearestNextItem != null) {
        _setCurrentItem(nearestNextItem.$1, forward);
        return true;
      }
    } else if (!widget.autofocus) {
      findFirstFocus();
      return true;
    }
    return false;
  }

  void findFirstFocus() {
    if (!mounted || !_active) return;
    (SubFocusState, int)? mostItem;
    for (final attached in _attachedStates) {
      if (attached.focusCount > 0 &&
          attached.focusCount > (mostItem?.$2 ?? 0)) {
        mostItem = (attached, attached.focusCount);
      }
    }
    if (mostItem != null) {
      _setCurrentItem(mostItem.$1, null);
    } else {
      // find very first focus based on top left or top right (based on directionality)
      (SubFocusState, double)? nearestItem;
      final direction = Directionality.of(context);
      RenderBox? parentBox = findRenderObject();
      if (parentBox == null) return;
      Offset anchor = direction == TextDirection.ltr
          ? Offset.zero
          : Offset(parentBox.size.width, 0);
      for (final attached in _attachedStates) {
        if (attached == mostItem?.$1) continue;
        final box = attached.findRenderObject();
        if (box == null) continue;
        final offset = box.localToGlobal(Offset.zero);
        final distance = (offset - anchor).distance;
        if (nearestItem == null || distance < nearestItem.$2) {
          nearestItem = (attached, distance);
        }
      }
      if (nearestItem != null) {
        _setCurrentItem(nearestItem.$1, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<SubFocusScopeState>.inherit(
      data: this,
      child: widget.builder?.call(context, this),
    );
  }

  @override
  bool requestFocus(SubFocusState child) {
    if (!mounted || !_active) return false;
    _currentState?.markFocused(false);
    _currentState = child;
    _currentState!.markFocused(true);
    return true;
  }
}

/// Callback function type for building SubFocus widgets.
///
/// Receives the build context and focus state for creating widgets that
/// respond to focus changes and user interactions.
/// Callback function type for building SubFocus widgets.
///
/// Receives the build context and the focus state for managing focus
/// presentation and behavior within the widget.
///
/// Parameters:
/// - [context]: The build context
/// - [state]: The focus state providing focus information and control methods
///
/// Returns the widget tree for this focusable element.
typedef SubFocusBuilder = Widget Function(
  BuildContext context,
  SubFocusState state,
);

/// Individual focusable widget within a SubFocusScope hierarchy.
///
/// Creates a single focusable element that can receive keyboard focus and respond
/// to user interactions within a [SubFocusScope]. Provides focus state information
/// and handles focus-related behaviors like visibility scrolling and action routing.
///
/// Key Features:
/// - **Focus State**: Tracks and reports whether this widget currently has focus
/// - **Focus Request**: Can programmatically request focus from its parent scope
/// - **Action Handling**: Receives and processes keyboard actions when focused
/// - **Scroll Integration**: Automatically scrolls to ensure visibility when focused
/// - **State Tracking**: Maintains focus count and state across widget lifecycle
/// - **Enable/Disable**: Can be temporarily disabled to prevent focus acquisition
///
/// The widget uses a builder pattern to provide focus state to child widgets,
/// allowing them to update their appearance and behavior based on focus status.
/// This enables rich visual feedback for focused states.
///
/// Common Use Cases:
/// - List items in navigable lists
/// - Form fields in keyboard-navigable forms
/// - Menu items in dropdown menus
/// - Tree nodes in tree views
/// - Tab headers in tab panels
///
/// Example:
/// ```dart
/// SubFocus(
///   enabled: true,
///   builder: (context, state) => GestureDetector(
///     onTap: () => state.requestFocus(),
///     child: Container(
///       padding: EdgeInsets.all(8),
///       decoration: BoxDecoration(
///         color: state.isFocused ? Colors.blue : Colors.transparent,
///         border: Border.all(
///           color: state.isFocused ? Colors.blue : Colors.grey,
///         ),
///       ),
///       child: Text(
///         'Focusable Item',
///         style: TextStyle(
///           color: state.isFocused ? Colors.white : Colors.black,
///         ),
///       ),
///     ),
///   ),
/// )
/// ```
