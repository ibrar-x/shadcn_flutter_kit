part of '../../resizable.dart';

class _ResizablePanelData {
  final _ResizablePanelState state;
  final int index;

  _ResizablePanelData(this.state, this.index);

  Axis get direction => state.widget.direction;

  void attach(ResizablePaneController controller) {
    state.attachController(controller);
  }

  void detach(ResizablePaneController controller) {
    state.detachController(controller);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ResizablePanelData &&
        other.state == state &&
        other.index == index;
  }

  @override
  int get hashCode {
    return Object.hash(state, index);
  }
}
