part of '../avatar.dart';

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

class _AvatarState extends State<Avatar> {
  Widget _build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AvatarTheme>(context);
    final size = styleValue(
      widgetValue: widget.size,
      themeValue: compTheme?.size,
      defaultValue: theme.scaling * 40,
    );
    final borderRadius = styleValue(
      widgetValue: widget.borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: theme.radius * size,
    );
    if (widget.provider != null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image(
            image: widget.provider!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildInitials(context, borderRadius);
            },
          ),
        ),
      );
    }
    return SizedBox(
      width: size,
      height: size,
      child: _buildInitials(context, borderRadius),
    );
  }

  Widget _buildInitials(BuildContext context, double borderRadius) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AvatarTheme>(context);
    return Container(
      decoration: BoxDecoration(
        color: styleValue(
          widgetValue: widget.backgroundColor,
          themeValue: compTheme?.backgroundColor,
          defaultValue: theme.colorScheme.muted,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Padding(
          padding: EdgeInsets.all(theme.scaling * 8),
          child: DefaultTextStyle.merge(
            style: styleValue(
              themeValue: compTheme?.textStyle,
              defaultValue: TextStyle(
                color: theme.colorScheme.foreground,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Center(
              child: Text(widget.initials),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.badge == null) {
      return _build(context);
    }
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AvatarTheme>(context);
    final size = styleValue(
      widgetValue: widget.size,
      themeValue: compTheme?.size,
      defaultValue: theme.scaling * 40,
    );
    final borderRadius = styleValue(
      widgetValue: widget.borderRadius,
      themeValue: compTheme?.borderRadius,
      defaultValue: theme.radius * size,
    );
    final badgeSize = widget.badge!.size ?? theme.scaling * 12;
    var offset = size / 2 - badgeSize / 2;
    offset = offset / size;
    final alignment = styleValue(
      widgetValue: widget.badgeAlignment,
      themeValue: compTheme?.badgeAlignment,
      defaultValue: AlignmentDirectional(offset, offset),
    );
    final gap = styleValue(
      widgetValue: widget.badgeGap,
      themeValue: compTheme?.badgeGap,
      defaultValue: theme.scaling * 4,
    );
    return AvatarGroup(
      alignment: alignment,
      gap: gap,
      children: [
        _AvatarWidget(
          size: widget.badge!.size ?? theme.scaling * 12,
          borderRadius: widget.badge!.borderRadius,
          child: widget.badge!,
        ),
        _AvatarWidget(
          size: size,
          borderRadius: borderRadius,
          child: _build(context),
        ),
      ],
    );
  }
}
