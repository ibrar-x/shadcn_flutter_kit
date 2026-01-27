import 'package:flutter/material.dart' hide Theme, TextField;
import 'package:flutter/services.dart';

import '../../../button/button.dart';
import '../../../../overlay/dialog/dialog.dart' as shadcn_dialog;
import '../../../../form/text_field/text_field.dart';
import '../../../../../shared/icons/lucide_icons.dart';
import '../../../../../shared/primitives/clickable.dart';
import '../../../../../shared/primitives/focus_outline.dart';
import '../../../../../shared/primitives/outlined_container.dart';
import '../../../../../shared/primitives/subfocus.dart';
import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/border_utils.dart';
import '../../../../../shared/utils/constants.dart';
import '../../../../../shared/utils/color_extensions.dart';
import '../../../../../shared/primitives/text.dart';
import '../../../../../shared/utils/util.dart';
import '../../../../../shared/primitives/icon_extensions.dart';
import '../../../../../shared/localizations/shadcn_localizations.dart';
import '../core/command_empty.dart';
import '../core/command_keyboard_display.dart';
import 'command_query.dart';
import '../core/command_widget.dart';
import '../utils/next_item_intent.dart';
import '../utils/previous_item_intent.dart';

class CommandState extends State<Command> {
  final TextEditingController _controller = TextEditingController();
  late CommandQuery _currentRequest;
  int requestCount = 0;

  Stream<List<Widget>> _request(BuildContext context, String? query) async* {
    int currentRequest = ++requestCount;
    yield [];
    await Future.delayed(widget.debounceDuration);
    if (!context.mounted || currentRequest != requestCount) return;
    List<Widget> resultItems = [];
    await for (final items in widget.builder(context, query)) {
      if (currentRequest != requestCount) continue;
      resultItems.addAll(items);
      yield resultItems;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentRequest = CommandQuery(stream: _request(context, null));
    _controller.addListener(() {
      String? newQuery = _controller.text;
      if (newQuery.isEmpty) newQuery = null;
      if (newQuery != _currentRequest.query) {
        setState(() {
          _currentRequest = CommandQuery(
            stream: _request(context, newQuery),
            query: newQuery,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canPop = Navigator.of(context).canPop();
    final localization = ShadcnLocalizations.of(context);
    return SubFocusScope(
      autofocus: true,
      builder: (context, state) {
        return Actions(
          actions: {
            NextItemIntent: CallbackAction<NextItemIntent>(
              onInvoke: (intent) {
                state.nextFocus();
                return null;
              },
            ),
            PreviousItemIntent: CallbackAction<PreviousItemIntent>(
              onInvoke: (intent) {
                state.nextFocus(TraversalDirection.up);
                return null;
              },
            ),
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) {
                state.invokeActionOnFocused(intent);
                return null;
              },
            ),
          },
          child: Shortcuts(
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.arrowUp):
                  const PreviousItemIntent(),
              LogicalKeySet(LogicalKeyboardKey.arrowDown):
                  const NextItemIntent(),
              LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
            },
            child: IntrinsicWidth(
              child: OutlinedContainer(
                clipBehavior: Clip.hardEdge,
                surfaceBlur: widget.surfaceBlur ?? theme.surfaceBlur,
                surfaceOpacity: widget.surfaceOpacity ?? theme.surfaceOpacity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ComponentTheme(
                      data: const FocusOutlineTheme(
                        border: Border.fromBorderSide(BorderSide.none),
                      ),
                      child: TextField(
                        autofocus: widget.autofocus,
                        border: const Border.fromBorderSide(BorderSide.none),
                        borderRadius: BorderRadius.zero,
                        controller: _controller,
                        placeholder: widget.searchPlaceholder ??
                            Text(localization.commandSearch),
                        features: [
                          InputFeature.leading(
                            const Icon(LucideIcons.search)
                                .iconSmall()
                                .iconMutedForeground(),
                          ),
                          if (canPop)
                            InputFeature.trailing(
                              GhostButton(
                                density: ButtonDensity.iconDense,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(LucideIcons.x).iconSmall(),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: StreamBuilder<List<Widget>>(
                        stream: _currentRequest.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Widget> items = List.of(snapshot.data!);
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              items.add(
                                IconTheme.merge(
                                  data: IconThemeData(
                                    color: theme.colorScheme.mutedForeground,
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ).withPadding(vertical: theme.scaling * 24),
                                ),
                              );
                            } else if (items.isEmpty) {
                              return widget.emptyBuilder?.call(context) ??
                                  const CommandEmpty();
                            }
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              padding: EdgeInsets.symmetric(
                                vertical: theme.scaling * 2,
                              ),
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index) => items[index],
                            );
                          }
                          return widget.loadingBuilder?.call(context) ??
                              const Center(
                                child: CircularProgressIndicator(),
                              ).withPadding(vertical: theme.scaling * 24);
                        },
                      ),
                    ),
                    const Divider(),
                    Container(
                      color: theme.colorScheme.card,
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.scaling * 12,
                        vertical: theme.scaling * 6,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          spacing: theme.scaling * 8,
                          children: [
                            CommandKeyboardDisplay.fromActivator(
                              activator: SingleActivator(
                                LogicalKeyboardKey.arrowUp,
                              ),
                            ).xSmall().muted(),
                            Text(localization.commandMoveUp).muted().small(),
                            const VerticalDivider(),
                            CommandKeyboardDisplay.fromActivator(
                              activator: SingleActivator(
                                LogicalKeyboardKey.arrowDown,
                              ),
                            ).xSmall().muted(),
                            Text(localization.commandMoveDown).muted().small(),
                            const VerticalDivider(),
                            CommandKeyboardDisplay.fromActivator(
                              activator: SingleActivator(
                                LogicalKeyboardKey.enter,
                              ),
                            ).xSmall().muted(),
                            Text(localization.commandActivate).muted().small(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
