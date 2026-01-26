import 'package:flutter/material.dart' hide Theme, TextField;
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../button/button.dart';
import '../../overlay/dialog/dialog.dart' as shadcn_dialog;
import '../../form/text_field/text_field.dart';
import '../../../shared/icons/lucide_icons.dart';
import '../../../shared/primitives/clickable.dart';
import '../../../shared/primitives/focus_outline.dart';
import '../../../shared/primitives/outlined_container.dart';
import '../../../shared/primitives/subfocus.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/border_utils.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/primitives/text.dart';
import '../../../shared/utils/util.dart';
import '../../../shared/primitives/icon_extensions.dart';
import '../../../shared/localizations/shadcn_localizations.dart';

part '_impl/command_state.dart';
part '_impl/command_item.dart';
part '_impl/command_intents.dart';

/// Async builder that provides command palette rows.
typedef CommandBuilder = Stream<List<Widget>> Function(
    BuildContext context, String? query);

/// Builder for error states inside a command palette.
typedef ErrorWidgetBuilder = Widget Function(
    BuildContext context, Object error, StackTrace? stackTrace);

/// Default empty state shown when no command results match.
class CommandEmpty extends StatelessWidget {
  /// Creates a command empty state widget.
  const CommandEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Center(
      child: Text(localizations.commandEmpty).withPadding(vertical: 24).small(),
    );
  }
}

/// Shows a modal dialog with a [Command] palette.
Future<T?> showCommandDialog<T>({
  required BuildContext context,
  required CommandBuilder builder,
  BoxConstraints? constraints,
  bool autofocus = true,
  Duration debounceDuration = const Duration(milliseconds: 500),
  WidgetBuilder? emptyBuilder,
  ErrorWidgetBuilder? errorBuilder,
  WidgetBuilder? loadingBuilder,
  double? surfaceOpacity,
  double? surfaceBlur,
}) {
  return shadcn_dialog.showDialog<T>(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      final scaling = theme.scaling;
      surfaceOpacity ??= theme.surfaceOpacity;
      surfaceBlur ??= theme.surfaceBlur;
      return ConstrainedBox(
        constraints: constraints ??
            const BoxConstraints.tightFor(width: 510, height: 349) * scaling,
        child: shadcn_dialog.ModalBackdrop(
          borderRadius: subtractByBorder(theme.borderRadiusXxl, 1 * scaling),
          surfaceClip:
              shadcn_dialog.ModalBackdrop.shouldClipSurface(surfaceOpacity),
          child: Command(
            autofocus: autofocus,
            builder: builder,
            debounceDuration: debounceDuration,
            emptyBuilder: emptyBuilder,
            errorBuilder: errorBuilder,
            loadingBuilder: loadingBuilder,
            surfaceOpacity: surfaceOpacity,
            surfaceBlur: surfaceBlur,
          ),
        ),
      );
    },
  );
}

/// Command palette with search input, results, and keyboard handling.
class Command extends StatefulWidget {
  const Command({
    super.key,
    required this.builder,
    this.autofocus = true,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.searchPlaceholder,
  });

  /// Search results builder.
  final CommandBuilder builder;

  /// Auto-focus the search field.
  final bool autofocus;

  /// Debounce delay for search input.
  final Duration debounceDuration;

  /// Empty state builder override.
  final WidgetBuilder? emptyBuilder;

  /// Error builder override.
  final ErrorWidgetBuilder? errorBuilder;

  /// Loading state builder.
  final WidgetBuilder? loadingBuilder;

  /// Optional surface opacity override.
  final double? surfaceOpacity;

  /// Optional surface blur override.
  final double? surfaceBlur;

  /// Placeholder widget for the search input.
  final Widget? searchPlaceholder;

  @override
  State<Command> createState() => _CommandState();
}

/// Groups command items under an optional heading.
class CommandCategory extends StatelessWidget {
  /// Creates a command category.
  const CommandCategory({
    super.key,
    required this.children,
    this.title,
  });

  /// Items belonging to this category.
  final List<Widget> children;

  /// Optional header.
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          title!
              .withPadding(
                horizontal: theme.scaling * 8,
                vertical: theme.scaling * 6,
              )
              .medium()
              .xSmall()
              .muted(),
        ...children,
      ],
    ).withPadding(all: theme.scaling * 4);
  }
}

/// A single selectable command entry.
class CommandItem extends StatefulWidget {
  /// Optional leading widget (icon, etc.).
  final Widget? leading;

  /// Primary title for the command.
  final Widget title;

  /// Optional trailing widget (shortcut, badge).
  final Widget? trailing;

  /// Callback when the item is activated.
  final VoidCallback? onTap;

  /// Creates a command item.
  const CommandItem({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  State<CommandItem> createState() => _CommandItemState();
}
