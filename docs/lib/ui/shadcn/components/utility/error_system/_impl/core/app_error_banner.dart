// AppErrorBanner: top-of-app banner for app-level errors published in AppErrorHub.
// Intended for "global" problems (session expired / network down) that should remain visible across navigation until dismissed.

import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../../shared/icons/radix_icons.dart';
import '../../../../../shared/primitives/outlined_container.dart';
import '../../../../../shared/theme/theme.dart';
import '../../../../control/button/button.dart';
import '../themes/error_system_theme.dart';
import 'app_error.dart';
import 'app_error_hub.dart';
import 'error_code.dart';

class AppErrorBanner extends StatelessWidget {
  const AppErrorBanner({
    super.key,
    this.watchScopes = const [
      AppErrorHub.sessionExpired,
      AppErrorHub.maintenanceMode,
      AppErrorHub.networkUnavailable,
      AppErrorHub.criticalUpdate,
      AppErrorHub.permissionDenied,
    ],
  });

  /// App-level channels to render (in order).
  final List<String> watchScopes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final scope in watchScopes)
          ValueListenableBuilder<AppError?>(
            valueListenable: AppErrorHub.I.app(scope),
            builder: (context, error, _) {
              if (error == null) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.only(bottom: 8 * scaling),
                child: _buildBanner(
                  context,
                  error,
                  onDismiss: () {
                    AppErrorHub.I.clearApp(scope);
                  },
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildBanner(
    BuildContext context,
    AppError error, {
    required VoidCallback onDismiss,
  }) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ErrorSystemTheme>(context);

    final borderColor =
        compTheme?.bannerBorderColor?.call(theme, error) ??
        _borderForCode(theme, error.code);

    final backgroundColor =
        compTheme?.bannerBackgroundColor ?? theme.colorScheme.card;

    final titleStyle =
        compTheme?.bannerTitleStyle ??
        theme.typography.small.merge(theme.typography.semiBold);
    final messageStyle =
        compTheme?.bannerMessageStyle ??
        theme.typography.xSmall.copyWith(
          color: theme.colorScheme.mutedForeground,
        );

    final padding =
        compTheme?.bannerPadding ??
        EdgeInsets.symmetric(horizontal: 16 * scaling, vertical: 12 * scaling);

    final action = error.actions.isNotEmpty ? error.actions.first : null;
    final Widget? actionButton = action == null
        ? null
        : (action.primary
              ? PrimaryButton(
                  onPressed: action.onPressed,
                  size: ButtonSize.small,
                  density: ButtonDensity.dense,
                  child: Text(action.label),
                )
              : SecondaryButton(
                  onPressed: action.onPressed,
                  size: ButtonSize.small,
                  density: ButtonDensity.dense,
                  child: Text(action.label),
                ));

    return OutlinedContainer(
      width: double.infinity,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: compTheme?.bannerBorderRadius ?? theme.borderRadiusLg,
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 520 * scaling;
          final dismissButton = GhostButton(
            onPressed: onDismiss,
            size: ButtonSize.small,
            density: ButtonDensity.iconDense,
            child: Icon(RadixIcons.cross2, size: 16 * scaling),
          );

          final icon = Icon(
            compTheme?.bannerIcon ?? RadixIcons.exclamationTriangle,
            size: 18 * scaling,
            color: borderColor,
          );

          final textBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle.merge(
                style: titleStyle,
                child: Text(error.title),
              ),
              Gap(4 * scaling),
              DefaultTextStyle.merge(
                style: messageStyle,
                child: Text(error.message),
              ),
            ],
          );

          if (!isNarrow) {
            return Row(
              children: [
                icon,
                Gap(12 * scaling),
                Expanded(child: textBlock),
                if (actionButton != null) ...[
                  Gap(12 * scaling),
                  actionButton,
                ],
                Gap(8 * scaling),
                dismissButton,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon,
                  Gap(12 * scaling),
                  Expanded(child: textBlock),
                  Gap(8 * scaling),
                  dismissButton,
                ],
              ),
              if (actionButton != null) ...[
                Gap(12 * scaling),
                Wrap(
                  spacing: 8 * scaling,
                  runSpacing: 8 * scaling,
                  children: [actionButton],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

Color _borderForCode(ThemeData theme, AppErrorCode code) {
  switch (code) {
    case AppErrorCode.validation:
    case AppErrorCode.invalidInput:
      return theme.colorScheme.accent;
    case AppErrorCode.rateLimited:
    case AppErrorCode.timeout:
      return theme.colorScheme.primary;
    case AppErrorCode.cancelled:
      return theme.colorScheme.mutedForeground;
    case AppErrorCode.platformError:
    case AppErrorCode.unknown:
      return theme.colorScheme.mutedForeground;
    case AppErrorCode.unauthorized:
    case AppErrorCode.forbidden:
    case AppErrorCode.sessionExpired:
    case AppErrorCode.invalidCredentials:
    case AppErrorCode.permissionDenied:
    case AppErrorCode.network:
    case AppErrorCode.noInternet:
    case AppErrorCode.sslError:
    case AppErrorCode.server:
    case AppErrorCode.badRequest:
    case AppErrorCode.notFound:
    case AppErrorCode.conflict:
      return theme.colorScheme.destructive;
  }
}
