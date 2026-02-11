import 'package:flutter/widgets.dart';

import '../../../components/display/avatar/avatar.dart' as avatar;

/// Type alias for `Avatar` used by public or internal APIs.
typedef Avatar = avatar.Avatar;

/// Type alias for `AvatarBadge` used by public or internal APIs.
typedef AvatarBadge = avatar.AvatarBadge;

/// Type alias for `AvatarGroup` used by public or internal APIs.
typedef AvatarGroup = avatar.AvatarGroup;

/// Descriptor for avatar entries used by [CompositeAvatarGroup].
class AvatarEntry {
  /// Creates a `AvatarEntry` instance.
  const AvatarEntry({
    required this.name,
    this.provider,
    this.backgroundColor,
    this.size,
    this.borderRadius,
    this.badge,
  });

  /// Stores `name` state/configuration for this implementation.
  final String name;

  /// Stores `provider` state/configuration for this implementation.
  final ImageProvider<Object>? provider;

  /// Stores `backgroundColor` state/configuration for this implementation.
  final Color? backgroundColor;

  /// Stores `size` state/configuration for this implementation.
  final double? size;

  /// Stores `borderRadius` state/configuration for this implementation.
  final double? borderRadius;

  /// Stores `badge` state/configuration for this implementation.
  final AvatarBadge? badge;
}

/// Overlap direction for [CompositeAvatarGroup].
enum AvatarGroupDirection { start, end, left, right, top, bottom }

/// Standalone composite avatar group with data-driven entries.
class CompositeAvatarGroup extends StatelessWidget {
  /// Creates a `CompositeAvatarGroup` instance.
  const CompositeAvatarGroup({
    super.key,
    required this.entries,
    this.direction = AvatarGroupDirection.start,
    this.gap,
    this.offset = 0.5,
    this.clipBehavior,
  }) : assert(entries.length > 0, 'entries cannot be empty.');

  /// Stores `entries` state/configuration for this implementation.
  final List<AvatarEntry> entries;

  /// Stores `direction` state/configuration for this implementation.
  final AvatarGroupDirection direction;

  /// Stores `gap` state/configuration for this implementation.
  final double? gap;

  /// Stores `offset` state/configuration for this implementation.
  final double offset;

  /// Stores `clipBehavior` state/configuration for this implementation.
  final Clip? clipBehavior;

  /// Executes `_buildChildren` behavior for this component/composite.
  List<Avatar> _buildChildren() {
    return [
      for (final entry in entries)
        Avatar(
          initials: Avatar.getInitials(entry.name),
          provider: entry.provider,
          backgroundColor: entry.backgroundColor,
          size: entry.size,
          borderRadius: entry.borderRadius,
          badge: entry.badge,
        ),
    ];
  }

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final children = _buildChildren();
    final alignment = switch (direction) {
      AvatarGroupDirection.start => AlignmentDirectional(offset, 0),
      AvatarGroupDirection.end => AlignmentDirectional(-offset, 0),
      AvatarGroupDirection.left => Alignment(offset, 0),
      AvatarGroupDirection.right => Alignment(-offset, 0),
      AvatarGroupDirection.top => Alignment(0, offset),
      AvatarGroupDirection.bottom => Alignment(0, -offset),
    };
    return AvatarGroup(
      alignment: alignment,
      children: children,
      gap: gap,
      clipBehavior: clipBehavior,
    );
  }
}
