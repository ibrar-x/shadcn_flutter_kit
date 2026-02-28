import 'dart:async';

import 'package:docs/shadcn_ui.dart';
import 'package:docs/ui/shadcn/components/navigation/tabs/tabs.dart'
    as shadcn_tabs;

const Color _kGooeySurface = Color(0xFF0D1117);
const Color _kGooeyBodyText = Color(0xFFE8EDF5);

final ValueNotifier<_GooeyGlobalSettings> _gooeyDocsSettings =
    ValueNotifier<_GooeyGlobalSettings>(
  const _GooeyGlobalSettings(
    preset: _EdgePreset.topLeft,
    width: 420,
    roundness: 16,
    duration: Duration(seconds: 5),
    autopilot: GooeyAutopilot(
      expandDelay: Duration(milliseconds: 180),
      collapseDelay: Duration(milliseconds: 3200),
    ),
    compactMorph: GooeyCompactMorph(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubicEmphasized,
      slideOffset: Offset(0, 0.10),
      scaleFrom: 0.80,
    ),
  ),
);

/// Playground: only variants + position controls.
class GooeyToastExample1 extends StatefulWidget {
  const GooeyToastExample1({super.key});

  @override
  State<GooeyToastExample1> createState() => _GooeyToastExample1State();
}

class _GooeyToastExample1State extends State<GooeyToastExample1> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_GooeyGlobalSettings>(
      valueListenable: _gooeyDocsSettings,
      builder: (context, settings, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preview Variants',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final variant in _PreviewVariant.values)
                  OutlineButton(
                    onPressed: () => _showVariant(context, settings, variant),
                    child: Text(variant.label),
                  ),
              ],
            ),
            const Gap(12),
            const Text(
              'Position',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final preset in _EdgePreset.values)
                  SelectedButton(
                    value: settings.preset == preset,
                    onChanged: (value) {
                      if (!value) return;
                      _gooeyDocsSettings.value =
                          settings.copyWith(preset: preset);
                    },
                    style: const ButtonStyle.outline(),
                    selectedStyle: const ButtonStyle.primary(),
                    child: Text(preset.label),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showVariant(
    BuildContext context,
    _GooeyGlobalSettings settings,
    _PreviewVariant variant,
  ) {
    switch (variant) {
      case _PreviewVariant.success:
        _show(
          context,
          settings,
          id: 'docs-gooey-success',
          title: 'Success',
          description: 'Workspace settings were saved.',
          state: GooeyToastState.success,
        );
      case _PreviewVariant.error:
        _show(
          context,
          settings,
          id: 'docs-gooey-error',
          title: 'Error',
          description: 'Failed to sync your workspace.',
          state: GooeyToastState.error,
        );
      case _PreviewVariant.warning:
        _show(
          context,
          settings,
          id: 'docs-gooey-warning',
          title: 'Storage Warning',
          description: 'You are running out of storage space.',
          state: GooeyToastState.warning,
        );
      case _PreviewVariant.info:
        _show(
          context,
          settings,
          id: 'docs-gooey-info',
          title: 'Heads up',
          description: 'A new update is available.',
          state: GooeyToastState.info,
        );
      case _PreviewVariant.action:
        _show(
          context,
          settings,
          id: 'docs-gooey-action',
          title: 'Action Required',
          description: 'Review and confirm this request.',
          state: GooeyToastState.action,
          action: GooeyToastAction(
            label: 'Confirm',
            onPressed: () {
              _show(
                context,
                settings,
                id: 'docs-gooey-action',
                title: 'Confirmed',
                description: 'Request has been approved.',
                state: GooeyToastState.success,
              );
            },
          ),
        );
      case _PreviewVariant.loading:
        _show(
          context,
          settings,
          id: 'docs-gooey-loading',
          title: 'Processing',
          description: 'Please wait while we process your request.',
          state: GooeyToastState.loading,
        );
      case _PreviewVariant.promise:
        _show(
          context,
          settings,
          id: 'docs-gooey-promise',
          title: 'Uploading',
          description: 'Sending file to workspace...',
          state: GooeyToastState.loading,
        );
        Timer(const Duration(milliseconds: 1300), () {
          if (!mounted) return;
          _show(
            context,
            settings,
            id: 'docs-gooey-promise',
            title: 'Upload Complete',
            description: 'Your file is ready.',
            state: GooeyToastState.success,
          );
        });
      case _PreviewVariant.custom:
        _show(
          context,
          settings,
          id: 'docs-gooey-custom',
          title: 'Interactive Workspace',
          description: null,
          state: GooeyToastState.info,
          expandedChild: _TabsListExpanded(
            onTrigger: () {
              _show(
                context,
                settings.copyWith(preset: settings.preset.alternate),
                id: 'docs-gooey-custom-next',
                title: 'Triggered',
                description: 'Opened from custom content.',
                state: GooeyToastState.success,
              );
            },
          ),
        );
    }
  }

  void _show(
    BuildContext context,
    _GooeyGlobalSettings settings, {
    required String id,
    required String title,
    required GooeyToastState state,
    String? description,
    GooeyToastAction? action,
    Widget? expandedChild,
  }) {
    _controller.show(
      context: context,
      id: id,
      stateTag: '$id-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      description: description,
      state: state,
      position: settings.preset.position,
      expandDirection: settings.preset.expandDirection,
      width: settings.width,
      fill: _kGooeySurface,
      roundness: settings.roundness,
      duration: settings.duration,
      autopilot: settings.autopilot,
      animationStyle: GooeyToastAnimationStyle.smooth,
      shapeStyle: GooeyToastShapeStyle.sharp,
      enableGooeyBlur: true,
      pauseOnHover: true,
      swipeToDismiss: true,
      persistUntilDismissed: false,
      newToastBehavior: GooeyToastNewToastBehavior.dismissPrevious,
      compactMorph: settings.compactMorph,
      action: action,
      expandedChild: expandedChild,
    );
  }
}

/// Interactive reply demo (uses global position + defaults).
class GooeyToastExample2 extends StatefulWidget {
  const GooeyToastExample2({super.key});

  @override
  State<GooeyToastExample2> createState() => _GooeyToastExample2State();
}

class _GooeyToastExample2State extends State<GooeyToastExample2> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        final settings = _gooeyDocsSettings.value;
        _controller.show(
          context: context,
          id: 'docs-gooey-reply',
          stateTag: 'reply-compose',
          title: 'Thread Reply',
          state: GooeyToastState.action,
          position: settings.preset.position,
          expandDirection: settings.preset.expandDirection,
          width: settings.width,
          fill: _kGooeySurface,
          roundness: settings.roundness,
          duration: settings.duration,
          autopilot: settings.autopilot,
          animationStyle: GooeyToastAnimationStyle.smooth,
          shapeStyle: GooeyToastShapeStyle.sharp,
          enableGooeyBlur: true,
          pauseOnHover: true,
          swipeToDismiss: true,
          persistUntilDismissed: false,
          newToastBehavior: GooeyToastNewToastBehavior.dismissPrevious,
          compactMorph: settings.compactMorph,
          expandedChild: _InteractiveReplyExpanded(
            onSend: (message) {
              _controller.show(
                context: context,
                id: 'docs-gooey-reply',
                stateTag: 'reply-sent-${DateTime.now().millisecondsSinceEpoch}',
                title: 'Message Sent',
                description: 'Your reply was sent: "$message"',
                state: GooeyToastState.success,
                position: settings.preset.position,
                expandDirection: settings.preset.expandDirection,
                fill: _kGooeySurface,
                animationStyle: GooeyToastAnimationStyle.smooth,
                shapeStyle: GooeyToastShapeStyle.sharp,
                enableGooeyBlur: true,
                pauseOnHover: true,
                swipeToDismiss: true,
                persistUntilDismissed: false,
                newToastBehavior: GooeyToastNewToastBehavior.dismissPrevious,
              );
            },
          ),
        );
      },
      child: const Text('Interactive Reply Demo'),
    );
  }
}

/// Booking flow demo: 3 states transition in the same slot.
class GooeyToastExample3 extends StatefulWidget {
  const GooeyToastExample3({super.key});

  @override
  State<GooeyToastExample3> createState() => _GooeyToastExample3State();
}

class _GooeyToastExample3State extends State<GooeyToastExample3> {
  final GooeyToastController _controller = GooeyToastController();
  final List<Timer> _timers = <Timer>[];

  @override
  void dispose() {
    for (final timer in _timers) {
      timer.cancel();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        for (final timer in _timers) {
          timer.cancel();
        }
        _timers.clear();
        final settings = _gooeyDocsSettings.value;

        void showState({
          required String stateTag,
          required String title,
          required String description,
          required GooeyToastState state,
        }) {
          _controller.show(
            context: context,
            id: 'docs-gooey-booking-flow',
            stateTag: stateTag,
            title: title,
            description: description,
            state: state,
            position: settings.preset.position,
            expandDirection: settings.preset.expandDirection,
            width: settings.width,
            fill: _kGooeySurface,
            roundness: settings.roundness,
            duration: settings.duration,
            autopilot: settings.autopilot,
            animationStyle: GooeyToastAnimationStyle.smooth,
            shapeStyle: GooeyToastShapeStyle.sharp,
            enableGooeyBlur: true,
            pauseOnHover: true,
            swipeToDismiss: true,
            persistUntilDismissed: false,
            newToastBehavior: GooeyToastNewToastBehavior.dismissPrevious,
            compactMorph: settings.compactMorph,
          );
        }

        showState(
          stateTag: 'booking-loading',
          title: 'Booking In Progress',
          description: 'Reserving seat and confirming fare class...',
          state: GooeyToastState.loading,
        );
        _timers.add(
          Timer(const Duration(milliseconds: 1200), () {
            if (!mounted) return;
            showState(
              stateTag: 'booking-confirmed',
              title: 'Booking Confirmed',
              description: 'Ticket issued and synced to your account.',
              state: GooeyToastState.success,
            );
          }),
        );
        _timers.add(
          Timer(const Duration(milliseconds: 2600), () {
            if (!mounted) return;
            showState(
              stateTag: 'booking-gate-updated',
              title: 'Gate Updated',
              description: 'Departure gate changed to A12.',
              state: GooeyToastState.info,
            );
          }),
        );
      },
      child: const Text('Booking Multi-State Demo'),
    );
  }
}

/// Extra custom content demo (same global defaults).
class GooeyToastExample4 extends StatelessWidget {
  const GooeyToastExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return _TabsListDemoButton();
  }
}

class _TabsListDemoButton extends StatefulWidget {
  @override
  State<_TabsListDemoButton> createState() => _TabsListDemoButtonState();
}

class _TabsListDemoButtonState extends State<_TabsListDemoButton> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        final settings = _gooeyDocsSettings.value;
        _controller.show(
          context: context,
          id: 'docs-gooey-tabs-list',
          stateTag: 'tabs-list-${DateTime.now().millisecondsSinceEpoch}',
          title: 'Interactive Workspace',
          state: GooeyToastState.info,
          position: settings.preset.position,
          expandDirection: settings.preset.expandDirection,
          width: settings.width,
          fill: _kGooeySurface,
          roundness: settings.roundness,
          duration: settings.duration,
          autopilot: settings.autopilot,
          animationStyle: GooeyToastAnimationStyle.smooth,
          shapeStyle: GooeyToastShapeStyle.sharp,
          enableGooeyBlur: true,
          pauseOnHover: true,
          swipeToDismiss: true,
          persistUntilDismissed: false,
          newToastBehavior: GooeyToastNewToastBehavior.dismissPrevious,
          compactMorph: settings.compactMorph,
          expandedChild: _TabsListExpanded(
            onTrigger: () {
              _controller.show(
                context: context,
                id: 'docs-gooey-tabs-list-next',
                title: 'Triggered',
                description: 'Opened from tabs/list content.',
                state: GooeyToastState.success,
                position: settings.preset.alternate.position,
                expandDirection: settings.preset.alternate.expandDirection,
                fill: _kGooeySurface,
                animationStyle: GooeyToastAnimationStyle.smooth,
                shapeStyle: GooeyToastShapeStyle.sharp,
                newToastBehavior: GooeyToastNewToastBehavior.dismissPrevious,
                persistUntilDismissed: false,
              );
            },
          ),
        );
      },
      child: const Text('Tabs + ListView Demo'),
    );
  }
}

class _TabsListExpanded extends StatefulWidget {
  const _TabsListExpanded({required this.onTrigger});

  final VoidCallback onTrigger;

  @override
  State<_TabsListExpanded> createState() => _TabsListExpandedState();
}

class _TabsListExpandedState extends State<_TabsListExpanded> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(color: _kGooeyBodyText),
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            shadcn_tabs.Tabs(
              index: _tabIndex,
              onChanged: (next) => setState(() => _tabIndex = next),
              children: const [
                shadcn_tabs.TabItem(child: Text('Tasks')),
                shadcn_tabs.TabItem(child: Text('Actions')),
              ],
            ),
            const Gap(8),
            Expanded(
              child: IndexedStack(
                index: _tabIndex,
                children: [
                  ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        Text('Pending task #${index + 1}'),
                    separatorBuilder: (context, index) =>
                        const Divider(color: Color(0x44E8EDF5)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: PrimaryButton(
                      onPressed: widget.onTrigger,
                      child: const Text('Trigger Another Position'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractiveReplyExpanded extends StatefulWidget {
  const _InteractiveReplyExpanded({required this.onSend});

  final ValueChanged<String> onSend;

  @override
  State<_InteractiveReplyExpanded> createState() =>
      _InteractiveReplyExpandedState();
}

class _InteractiveReplyExpandedState extends State<_InteractiveReplyExpanded> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(color: _kGooeyBodyText),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Click reply to respond from this thread.'),
          const Gap(8),
          TextField(
            controller: _controller,
            placeholder: const Text('Type your reply...'),
          ),
          const Gap(8),
          PrimaryButton(
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isEmpty) return;
              widget.onSend(text);
            },
            child: const Text('Send Reply'),
          ),
        ],
      ),
    );
  }
}

enum _PreviewVariant {
  success('success'),
  error('error'),
  warning('warning'),
  info('info'),
  action('action'),
  loading('loading'),
  promise('promise'),
  custom('custom');

  const _PreviewVariant(this.label);

  final String label;
}

enum _EdgePreset {
  topLeft(
    label: 'top-left',
    position: GooeyToastPosition.left,
    expandDirection: GooeyToastExpandDirection.bottom,
  ),
  topCenter(
    label: 'top-center',
    position: GooeyToastPosition.center,
    expandDirection: GooeyToastExpandDirection.bottom,
  ),
  topRight(
    label: 'top-right',
    position: GooeyToastPosition.right,
    expandDirection: GooeyToastExpandDirection.bottom,
  ),
  bottomLeft(
    label: 'bottom-left',
    position: GooeyToastPosition.left,
    expandDirection: GooeyToastExpandDirection.top,
  ),
  bottomCenter(
    label: 'bottom-center',
    position: GooeyToastPosition.center,
    expandDirection: GooeyToastExpandDirection.top,
  ),
  bottomRight(
    label: 'bottom-right',
    position: GooeyToastPosition.right,
    expandDirection: GooeyToastExpandDirection.top,
  );

  const _EdgePreset({
    required this.label,
    required this.position,
    required this.expandDirection,
  });

  final String label;
  final GooeyToastPosition position;
  final GooeyToastExpandDirection expandDirection;

  _EdgePreset get alternate {
    switch (this) {
      case _EdgePreset.topLeft:
        return _EdgePreset.topRight;
      case _EdgePreset.topCenter:
        return _EdgePreset.bottomCenter;
      case _EdgePreset.topRight:
        return _EdgePreset.bottomRight;
      case _EdgePreset.bottomLeft:
        return _EdgePreset.topLeft;
      case _EdgePreset.bottomCenter:
        return _EdgePreset.topCenter;
      case _EdgePreset.bottomRight:
        return _EdgePreset.bottomLeft;
    }
  }
}

class _GooeyGlobalSettings {
  const _GooeyGlobalSettings({
    required this.preset,
    required this.width,
    required this.roundness,
    required this.duration,
    required this.autopilot,
    required this.compactMorph,
  });

  final _EdgePreset preset;
  final double width;
  final double roundness;
  final Duration duration;
  final GooeyAutopilot autopilot;
  final GooeyCompactMorph compactMorph;

  _GooeyGlobalSettings copyWith({_EdgePreset? preset}) {
    return _GooeyGlobalSettings(
      preset: preset ?? this.preset,
      width: width,
      roundness: roundness,
      duration: duration,
      autopilot: autopilot,
      compactMorph: compactMorph,
    );
  }
}
