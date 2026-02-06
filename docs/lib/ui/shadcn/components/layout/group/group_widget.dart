import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

part '_impl/core/group_parent_data.dart';
part '_impl/core/render_group.dart';
part '_impl/core/group_positioned.dart';

/// A manual layout surface for positioning children with explicit offsets.
class GroupWidget extends MultiChildRenderObjectWidget {
  /// Creates a [GroupWidget].
  const GroupWidget({super.key, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGroup();
  }

  @override
  void updateRenderObject(BuildContext context, RenderGroup renderObject) {}
}

/// Places a child inside a [GroupWidget] at precise coordinates.

