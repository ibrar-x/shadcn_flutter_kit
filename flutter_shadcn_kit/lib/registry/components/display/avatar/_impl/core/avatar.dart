part of '../../avatar.dart';

class Avatar extends StatefulWidget implements AvatarWidget {
  const Avatar({
    super.key,
    required this.initials,
    this.backgroundColor,
    this.size,
    this.borderRadius,
    this.badge,
    this.badgeAlignment,
    this.badgeGap,
    this.provider,
  });

  Avatar.network({
    super.key,
    required this.initials,
    this.backgroundColor,
    this.size,
    this.borderRadius,
    this.badge,
    this.badgeAlignment,
    this.badgeGap,
    int? cacheWidth,
    int? cacheHeight,
    required String photoUrl,
  }) : provider = ResizeImage.resizeIfNeeded(
          cacheWidth,
          cacheHeight,
          NetworkImage(photoUrl),
        );

  static String getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return '';
    }
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      final chars = parts.first.characters.take(2).toList();
      return chars.join().toUpperCase();
    }
    final first = parts.first.characters.first;
    final second = parts[1].characters.first;
    return '$first$second'.toUpperCase();
  }

  final String initials;
  final Color? backgroundColor;
  @override
  final double? size;
  @override
  final double? borderRadius;
  final AvatarBadge? badge;
  final AlignmentGeometry? badgeAlignment;
  final double? badgeGap;
  final ImageProvider? provider;

  @override
  State<Avatar> createState() => _AvatarState();
}
