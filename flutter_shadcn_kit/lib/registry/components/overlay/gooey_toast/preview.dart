import 'dart:async';

import 'package:flutter/material.dart';

import '../toast/toast.dart';
import 'gooey_toast.dart';

/// GooeyToastPreview defines a reusable type for this registry module.
class GooeyToastPreview extends StatefulWidget {
  const GooeyToastPreview({super.key});

  @override
  State<GooeyToastPreview> createState() => _GooeyToastPreviewState();
}

class _GooeyToastPreviewState extends State<GooeyToastPreview> {
  final GooeyToastController _controller = GooeyToastController();
  Timer? _promiseTimer;
  final List<Timer> _flowTimers = [];

  int _selectedPresetIndex = 2;
  _DemoAction? _selectedAction;
  GooeyToastAnimationStyle _animationStyle = GooeyToastAnimationStyle.sileo;
  GooeyToastShapeStyle _shapeStyle = GooeyToastShapeStyle.defaultShape;
  bool _autopilotEnabled = true;
  bool _pauseOnHover = true;
  _DismissBehavior _dismissBehavior = _DismissBehavior.auto;
  final Set<ToastSwipeDirection> _customDismissDirections = {
    ToastSwipeDirection.up,
    ToastSwipeDirection.right,
  };
  final TextEditingController _customFlowIdController = TextEditingController(
    text: 'custom-flow-demo',
  );
  final TextEditingController _customTitleController = TextEditingController(
    text: 'Booking In Progress',
  );
  final TextEditingController _customDescriptionController =
      TextEditingController(
        text: 'Preparing your itinerary and verifying payment.',
      );
  final TextEditingController _customDurationController = TextEditingController(
    text: '1800',
  );
  GooeyToastState _customState = GooeyToastState.loading;
  bool _customStepExpanded = true;
  bool _customStepPersistent = false;
  final List<_CustomStateStep> _customSteps = [];

  static const List<_ViewportPreset> _presets = [
    _ViewportPreset(
      label: 'top-left',
      position: GooeyToastPosition.left,
      expandDirection: GooeyToastExpandDirection.bottom,
    ),
    _ViewportPreset(
      label: 'top-center',
      position: GooeyToastPosition.center,
      expandDirection: GooeyToastExpandDirection.bottom,
    ),
    _ViewportPreset(
      label: 'top-right',
      position: GooeyToastPosition.right,
      expandDirection: GooeyToastExpandDirection.bottom,
    ),
    _ViewportPreset(
      label: 'bottom-left',
      position: GooeyToastPosition.left,
      expandDirection: GooeyToastExpandDirection.top,
    ),
    _ViewportPreset(
      label: 'bottom-center',
      position: GooeyToastPosition.center,
      expandDirection: GooeyToastExpandDirection.top,
    ),
    _ViewportPreset(
      label: 'bottom-right',
      position: GooeyToastPosition.right,
      expandDirection: GooeyToastExpandDirection.top,
    ),
  ];

  static const List<_DemoAction> _actions = [
    _DemoAction.success,
    _DemoAction.error,
    _DemoAction.warning,
    _DemoAction.info,
    _DemoAction.action,
    _DemoAction.icon,
    _DemoAction.promise,
    _DemoAction.customCompact,
    _DemoAction.customExpanded,
    _DemoAction.customBoth,
    _DemoAction.flightPath,
    _DemoAction.interactiveReply,
    _DemoAction.flightPromise,
    _DemoAction.customStateFlow,
  ];

  @override
  void dispose() {
    _promiseTimer?.cancel();
    for (final timer in _flowTimers) {
      timer.cancel();
    }
    _customFlowIdController.dispose();
    _customTitleController.dispose();
    _customDescriptionController.dispose();
    _customDurationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _triggerDemo(_DemoAction action) {
    setState(() => _selectedAction = action);
    _promiseTimer?.cancel();
    for (final timer in _flowTimers) {
      timer.cancel();
    }
    _flowTimers.clear();

    final preset = _presets[_selectedPresetIndex];
    final defaultToastId = 'demo-${action.name}';
    final swipeToDismiss = _dismissBehavior != _DismissBehavior.off;
    final customDirections = _customDismissDirections.isEmpty
        ? <ToastSwipeDirection>{ToastSwipeDirection.up}
        : Set<ToastSwipeDirection>.from(_customDismissDirections);
    final dismissDirections = switch (_dismissBehavior) {
      _DismissBehavior.auto => null,
      _DismissBehavior.off => <ToastSwipeDirection>{},
      _DismissBehavior.custom => customDirections,
    };

    void show({
      required String title,
      String? id,
      Object? stateTag,
      String? description,
      GooeyToastState state = GooeyToastState.success,
      Widget? icon,
      GooeyToastAction? action,
      Widget? compactChild,
      Widget? expandedChild,
      Duration? duration,
      GooeyAutopilot? autopilot,
      bool? persistUntilDismissed,
    }) {
      _controller.show(
        context: context,
        id: id ?? defaultToastId,
        stateTag: stateTag,
        title: title,
        description: description,
        state: state,
        position: preset.position,
        expandDirection: preset.expandDirection,
        animationStyle: _animationStyle,
        shapeStyle: _shapeStyle,
        pauseOnHover: _pauseOnHover,
        swipeToDismiss: swipeToDismiss,
        dismissDirections: dismissDirections,
        dismissDragThreshold: 68,
        autopilot:
            autopilot ?? (_autopilotEnabled ? const GooeyAutopilot() : null),
        icon: icon,
        action: action,
        compactChild: compactChild,
        expandedChild: expandedChild,
        duration: duration,
        persistUntilDismissed: persistUntilDismissed ?? false,
      );
    }

    void transitionToState({
      required String id,
      required Object stateTag,
      required String title,
      required GooeyToastState state,
      String? description,
      Widget? compactChild,
      Widget? expandedChild,
      Duration? duration,
      Duration compactGap = const Duration(milliseconds: 260),
      GooeyAutopilot expandedAutopilot = const GooeyAutopilot(
        expandDelay: Duration.zero,
        collapseDelay: Duration(milliseconds: 2200),
      ),
      bool persistUntilDismissed = false,
    }) {
      show(
        id: id,
        stateTag: '$stateTag:compact',
        title: title,
        state: state,
        description: null,
        compactChild: compactChild,
        expandedChild: null,
        duration: duration,
        autopilot: null,
        persistUntilDismissed: persistUntilDismissed,
      );
      if (description == null && expandedChild == null) {
        return;
      }
      _flowTimers.add(
        Timer(compactGap, () {
          if (!mounted) return;
          show(
            id: id,
            stateTag: '$stateTag:expanded',
            title: title,
            state: state,
            description: description,
            compactChild: compactChild,
            expandedChild: expandedChild,
            duration: duration,
            autopilot: expandedAutopilot,
            persistUntilDismissed: persistUntilDismissed,
          );
        }),
      );
    }

    switch (action) {
      case _DemoAction.success:
        show(
          title: 'Changes Saved',
          description:
              'Changes saved successfully to the database.\nPlease refresh the page to see the changes.',
          state: GooeyToastState.success,
        );
      case _DemoAction.error:
        show(
          title: 'Upload Failed',
          description: 'Please check your connection and try again.',
          state: GooeyToastState.error,
        );
      case _DemoAction.warning:
        show(
          title: 'Storage Warning',
          description: 'You are running out of storage space.',
          state: GooeyToastState.warning,
        );
      case _DemoAction.info:
        show(
          title: 'Heads up',
          description: 'A new update is available for your workspace.',
          state: GooeyToastState.info,
        );
      case _DemoAction.action:
        show(
          title: 'New Message',
          description: 'Click reply to respond from this thread.',
          state: GooeyToastState.action,
          action: GooeyToastAction(label: 'Reply', onPressed: () {}),
        );
      case _DemoAction.icon:
        show(
          title: 'Custom Icon',
          description: 'Toasts can render a custom leading icon widget.',
          state: GooeyToastState.success,
          icon: const Icon(Icons.auto_awesome_rounded),
        );
      case _DemoAction.promise:
        show(
          id: defaultToastId,
          stateTag: 'promise:loading',
          title: 'Saving Changes',
          description: 'Waiting for server response...',
          state: GooeyToastState.loading,
          duration: const Duration(milliseconds: 2600),
          autopilot: const GooeyAutopilot(
            expandDelay: Duration.zero,
            collapseDelay: Duration(milliseconds: 1400),
          ),
        );
        _promiseTimer = Timer(const Duration(milliseconds: 1700), () {
          if (!mounted) return;
          show(
            id: defaultToastId,
            stateTag: 'promise:loading:compact-before-next',
            title: 'Saving Changes',
            state: GooeyToastState.loading,
            compactChild: null,
            expandedChild: null,
            autopilot: null,
            duration: const Duration(milliseconds: 2800),
          );
          _flowTimers.add(
            Timer(const Duration(milliseconds: 220), () {
              if (!mounted) return;
              transitionToState(
                id: defaultToastId,
                stateTag: 'promise:success',
                title: 'Changes Saved',
                state: GooeyToastState.success,
                description:
                    'Operation completed successfully and synced to the database.',
                duration: const Duration(milliseconds: 2800),
              );
            }),
          );
        });
      case _DemoAction.customCompact:
        show(
          title: 'Deploy Complete',
          description:
              'Changes are live. Expanded body uses the default layout for this variant.',
          state: GooeyToastState.success,
          compactChild: Row(
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  color: Color(0x1A63C65E),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  size: 14,
                  color: Color(0xFF63C65E),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Deploy Complete',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF63C65E),
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      case _DemoAction.customExpanded:
        show(
          title: 'Workspace Notice',
          state: GooeyToastState.info,
          expandedChild: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Release 4.12.0',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF77A8FF),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Project-level schema checks completed. All migrations applied and indexed successfully. No conflicts detected.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Color(0xFFC0C5CB),
                ),
              ),
            ],
          ),
        );
      case _DemoAction.customBoth:
        show(
          title: 'Deployment',
          description: 'Build #441 is now live in production.',
          state: GooeyToastState.success,
          compactChild: Row(
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  color: Color(0x1A63C65E),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  size: 14,
                  color: Color(0xFF63C65E),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Deploy Complete',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF63C65E),
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          expandedChild: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Production / us-east-1',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF63C65E),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All checks passed. Latency is within baseline and traffic is stable.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Color(0xFFC0C5CB),
                ),
              ),
            ],
          ),
        );
      case _DemoAction.flightPath:
        show(
          title: 'Booking Confirmed',
          state: GooeyToastState.success,
          compactChild: Row(
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  color: Color(0x1A63C65E),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: Color(0xFF42C853),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Booking Confirmed',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF42C853),
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          expandedChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Text(
                    'UNITED',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 3.2,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE8E8E8),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'PNR EC2QW4',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8C8C8C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 62,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 8,
                      bottom: 0,
                      child: Text(
                        'DEL',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 8,
                      bottom: 0,
                      child: Text(
                        'SFO',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEDEDED),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 2,
                      child: Text(
                        '------------------------------',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(
                            0xFF42C853,
                          ).withValues(alpha: 0.55),
                          fontSize: 16,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                    Positioned(left: 56, bottom: 6, child: _flightDot()),
                    Positioned(right: 56, bottom: 6, child: _flightDot()),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF123E1C), Color(0xFF1E5F29)],
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4DDE5D),
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      case _DemoAction.interactiveReply:
        const toastId = 'interactive-reply-toast';
        const idleTone = Color(0xFF8EA3FF);
        const successTone = Color(0xFF63C65E);
        const cancelTone = Color(0xFF9AA7BD);

        void showReplyComposer() {
          show(
            id: toastId,
            stateTag: 'reply:compose',
            title: 'Thread Reply',
            state: GooeyToastState.action,
            compactChild: _replyCompact(
              title: 'Thread Reply',
              tone: idleTone,
              icon: Icons.forum_rounded,
            ),
            expandedChild: _InteractiveReplyExpanded(
              onSend: (message) {
                show(
                  id: toastId,
                  stateTag: 'reply:compose:compact-before-sent',
                  title: 'Thread Reply',
                  state: GooeyToastState.action,
                  compactChild: _replyCompact(
                    title: 'Thread Reply',
                    tone: idleTone,
                    icon: Icons.forum_rounded,
                  ),
                  expandedChild: null,
                  autopilot: null,
                );
                _flowTimers.add(
                  Timer(const Duration(milliseconds: 220), () {
                    if (!mounted) return;
                    transitionToState(
                      id: toastId,
                      stateTag: 'reply:sent:$message',
                      title: 'Message Sent',
                      state: GooeyToastState.success,
                      duration: const Duration(milliseconds: 2600),
                      compactChild: _replyCompact(
                        title: 'Message Sent',
                        tone: successTone,
                        icon: Icons.check_rounded,
                      ),
                      expandedChild: _ReplyResultExpanded(
                        title: 'Delivered to thread',
                        body: 'Your reply was sent successfully.\n"$message"',
                        tone: successTone,
                      ),
                    );
                  }),
                );
              },
              onCancel: () {
                show(
                  id: toastId,
                  stateTag: 'reply:compose:compact-before-cancel',
                  title: 'Thread Reply',
                  state: GooeyToastState.action,
                  compactChild: _replyCompact(
                    title: 'Thread Reply',
                    tone: idleTone,
                    icon: Icons.forum_rounded,
                  ),
                  expandedChild: null,
                  autopilot: null,
                );
                _flowTimers.add(
                  Timer(const Duration(milliseconds: 220), () {
                    if (!mounted) return;
                    transitionToState(
                      id: toastId,
                      stateTag: 'reply:cancelled',
                      title: 'Reply Cancelled',
                      state: GooeyToastState.info,
                      duration: const Duration(milliseconds: 2000),
                      compactChild: _replyCompact(
                        title: 'Reply Cancelled',
                        tone: cancelTone,
                        icon: Icons.close_rounded,
                      ),
                      expandedChild: const _ReplyResultExpanded(
                        title: 'Draft discarded',
                        body:
                            'No message was sent. You can open the composer again any time.',
                        tone: cancelTone,
                      ),
                    );
                  }),
                );
              },
            ),
          );
        }

        showReplyComposer();
      case _DemoAction.flightPromise:
        _showFlightPromiseFlow(show);
      case _DemoAction.customStateFlow:
        final id = _customFlowIdController.text.trim().isEmpty
            ? 'custom-flow-demo'
            : _customFlowIdController.text.trim();
        if (_customSteps.isEmpty) {
          final step = _buildStepFromInputs();
          transitionToState(
            id: id,
            stateTag: 'custom:${DateTime.now().millisecondsSinceEpoch}',
            title: step.title,
            state: step.state,
            description: step.expanded ? step.description : null,
            duration: step.duration,
            persistUntilDismissed: step.persistUntilDismissed,
          );
          return;
        }
        final steps = List<_CustomStateStep>.from(_customSteps);
        var offsetMs = 0;
        _flowTimers.add(
          Timer(Duration(milliseconds: offsetMs), () {
            if (!mounted) return;
            transitionToState(
              id: id,
              stateTag: 'custom:0:${steps[0].state.name}',
              title: steps[0].title,
              state: steps[0].state,
              description: steps[0].expanded ? steps[0].description : null,
              duration: steps[0].duration,
              persistUntilDismissed: steps[0].persistUntilDismissed,
            );
          }),
        );
        for (var i = 1; i < steps.length; i++) {
          offsetMs += steps[i - 1].duration.inMilliseconds;
          _flowTimers.add(
            Timer(Duration(milliseconds: offsetMs), () {
              if (!mounted) return;
              transitionToState(
                id: id,
                stateTag: 'custom:$i:${steps[i].state.name}',
                title: steps[i].title,
                state: steps[i].state,
                description: steps[i].expanded ? steps[i].description : null,
                duration: steps[i].duration,
                persistUntilDismissed: steps[i].persistUntilDismissed,
              );
            }),
          );
        }
    }
  }

  void _showFlightPromiseFlow(
    void Function({
      required String title,
      String? id,
      Object? stateTag,
      String? description,
      GooeyToastState state,
      Widget? icon,
      GooeyToastAction? action,
      Widget? compactChild,
      Widget? expandedChild,
      Duration? duration,
      GooeyAutopilot? autopilot,
      bool? persistUntilDismissed,
    })
    show,
  ) {
    for (final timer in _flowTimers) {
      timer.cancel();
    }
    _flowTimers.clear();

    void showState(_FlightToastModel model) {
      show(
        id: 'flight-booking-flow',
        stateTag: model.stateTag,
        title: model.title,
        state: model.state,
        duration: model.duration,
        autopilot: model.autopilot,
        compactChild: _flightCompact(
          title: model.title,
          tone: model.tone,
          icon: model.icon,
        ),
        expandedChild: model.showExpanded ? _flightExpanded(model) : null,
      );
    }

    void showCompact(_FlightToastModel model, {required String stateTag}) {
      show(
        id: 'flight-booking-flow',
        stateTag: stateTag,
        title: model.title,
        state: model.state,
        duration: model.duration,
        autopilot: null,
        compactChild: _flightCompact(
          title: model.title,
          tone: model.tone,
          icon: model.icon,
        ),
        expandedChild: null,
      );
    }

    const loadingState = _FlightToastModel(
      stateTag: 'flight-booking-pending',
      title: 'Booking In Progress',
      subtitle: 'Reserving seat and confirming fare class...',
      state: GooeyToastState.loading,
      icon: Icons.sync,
      tone: Color(0xFF77A8FF),
      fromCode: 'DEL',
      toCode: 'SFO',
      pnr: 'PNR -',
      cta: 'Preparing',
      duration: Duration(milliseconds: 2800),
      autopilot: null,
      showExpanded: false,
    );
    const successState = _FlightToastModel(
      stateTag: 'flight-booking-confirmed',
      title: 'Booking Confirmed',
      subtitle: 'Your itinerary is issued and synced to your account.',
      state: GooeyToastState.success,
      icon: Icons.check,
      tone: Color(0xFF42C853),
      fromCode: 'DEL',
      toCode: 'SFO',
      pnr: 'PNR EC2QW4',
      cta: 'View Details',
      duration: Duration(milliseconds: 3200),
      autopilot: GooeyAutopilot(
        expandDelay: Duration.zero,
        collapseDelay: Duration(milliseconds: 2200),
      ),
      showExpanded: true,
    );
    const gateCompactState = _FlightToastModel(
      stateTag: 'flight-gate-updated-compact',
      title: 'Gate Updated',
      subtitle: 'Departure gate changed to A12. Boarding starts in 35 min.',
      state: GooeyToastState.info,
      icon: Icons.info_outline,
      tone: Color(0xFF8EA3FF),
      fromCode: 'DEL',
      toCode: 'SFO',
      pnr: 'PNR EC2QW4',
      cta: 'Open Pass',
      duration: Duration(milliseconds: 3600),
      autopilot: null,
      showExpanded: false,
    );
    const gateExpandedState = _FlightToastModel(
      stateTag: 'flight-gate-updated-expanded',
      title: 'Gate Updated',
      subtitle: 'Departure gate changed to A12. Boarding starts in 35 min.',
      state: GooeyToastState.info,
      icon: Icons.info_outline,
      tone: Color(0xFF8EA3FF),
      fromCode: 'DEL',
      toCode: 'SFO',
      pnr: 'PNR EC2QW4',
      cta: 'Open Pass',
      duration: Duration(milliseconds: 3600),
      autopilot: GooeyAutopilot(
        expandDelay: Duration.zero,
        collapseDelay: Duration(milliseconds: 2600),
      ),
      showExpanded: true,
    );

    showCompact(loadingState, stateTag: 'flight-booking-pending:compact');
    _flowTimers.add(
      Timer(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        showCompact(
          loadingState,
          stateTag: 'flight-booking-pending:compact-before-next',
        );
      }),
    );
    _flowTimers.add(
      Timer(const Duration(milliseconds: 1420), () {
        if (!mounted) return;
        showCompact(successState, stateTag: 'flight-booking-confirmed:compact');
      }),
    );
    _flowTimers.add(
      Timer(const Duration(milliseconds: 1700), () {
        if (!mounted) return;
        showState(successState);
      }),
    );
    _flowTimers.add(
      Timer(const Duration(milliseconds: 3200), () {
        if (!mounted) return;
        showCompact(
          successState,
          stateTag: 'flight-booking-confirmed:compact-before-next',
        );
      }),
    );
    _flowTimers.add(
      Timer(const Duration(milliseconds: 3420), () {
        if (!mounted) return;
        showCompact(gateCompactState, stateTag: 'flight-gate-updated:compact');
      }),
    );
    _flowTimers.add(
      Timer(const Duration(milliseconds: 3700), () {
        if (!mounted) return;
        showState(gateExpandedState);
      }),
    );
  }

  Widget _flightCompact({
    required String title,
    required Color tone,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 15, color: tone),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tone,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _flightExpanded(_FlightToastModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text(
              'UNITED',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 3.2,
                fontWeight: FontWeight.w700,
                color: Color(0xFFE8E8E8),
              ),
            ),
            const Spacer(),
            Text(
              model.pnr,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8C8C8C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 58,
          child: Stack(
            children: [
              Positioned(
                left: 8,
                bottom: 0,
                child: Text(
                  model.fromCode,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEDEDED),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 0,
                child: Text(
                  model.toCode,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEDEDED),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 1,
                child: Text(
                  '------------------------------',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: model.tone.withValues(alpha: 0.55),
                    fontSize: 16,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          model.subtitle,
          style: const TextStyle(
            fontSize: 14,
            height: 1.35,
            color: Color(0xFFC0C5CB),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 38,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: LinearGradient(
              colors: [
                model.tone.withValues(alpha: 0.22),
                model.tone.withValues(alpha: 0.34),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            model.cta,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: model.tone,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _flightDot() {
    return Container(
      height: 34,
      width: 34,
      decoration: const BoxDecoration(
        color: Color(0x1F42C853),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.arrow_outward_rounded,
        size: 18,
        color: Color(0xFF42C853),
      ),
    );
  }

  Widget _replyCompact({
    required String title,
    required Color tone,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 15, color: tone),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: tone,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  _CustomStateStep _buildStepFromInputs() {
    final title = _customTitleController.text.trim().isEmpty
        ? 'Untitled State'
        : _customTitleController.text.trim();
    final description = _customDescriptionController.text.trim();
    final rawMs = int.tryParse(_customDurationController.text.trim()) ?? 1800;
    final durationMs = rawMs.clamp(250, 15000);
    return _CustomStateStep(
      title: title,
      description: description,
      state: _customState,
      duration: Duration(milliseconds: durationMs),
      expanded: _customStepExpanded && description.isNotEmpty,
      persistUntilDismissed: _customStepPersistent,
    );
  }

  void _addCustomStep() {
    setState(() {
      _customSteps.add(_buildStepFromInputs());
    });
  }

  void _clearCustomSteps() {
    setState(_customSteps.clear);
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFE9E9E9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Color(0xFFD8D8D8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Color(0xFFD8D8D8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Color(0xFFB5B5B5)),
      ),
      hintStyle: const TextStyle(
        fontSize: 12.5,
        color: Color(0xFF9A9A9A),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final compact = width < 1120;
            final ultra = width < 760;
            final chipHeight = ultra ? 34.0 : (compact ? 36.0 : 40.0);
            final chipFont = ultra ? 12.5 : (compact ? 13.5 : 14.5);
            final chipRadius = ultra ? 11.0 : 12.0;
            final chipSpacing = ultra ? 6.0 : 8.0;
            final sectionSpacing = ultra ? 12.0 : 14.0;
            final panelWidth = ultra ? width : (compact ? 980.0 : 1120.0);

            return Padding(
              padding: EdgeInsets.fromLTRB(
                ultra ? 12 : 18,
                ultra ? 12 : 18,
                ultra ? 12 : 18,
                ultra ? 10 : 14,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ultra ? 8 : 0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _PlaygroundTitle(size: ultra ? 56 : 74),
                            SizedBox(height: ultra ? 8 : 12),
                            Text(
                              'Pick a position, set options, click any type to fire it live.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ultra ? 18 : 19,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFA3A3A3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: panelWidth,
                      maxHeight: constraints.maxHeight * (ultra ? 0.64 : 0.56),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ControlSection(
                            title: 'Position',
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: chipSpacing,
                              runSpacing: chipSpacing,
                              children: [
                                for (var i = 0; i < _presets.length; i++)
                                  _PlaygroundChip(
                                    label: _presets[i].label,
                                    selected: i == _selectedPresetIndex,
                                    onTap: () => setState(
                                      () => _selectedPresetIndex = i,
                                    ),
                                    minWidth: ultra ? 92 : 112,
                                    minHeight: chipHeight,
                                    fontSize: chipFont,
                                    radius: chipRadius,
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          const _PlaygroundDivider(),
                          SizedBox(height: sectionSpacing),
                          _ControlSection(
                            title: 'Type',
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: chipSpacing,
                              runSpacing: chipSpacing,
                              children: [
                                for (final action in _actions)
                                  _PlaygroundChip(
                                    label: action.label,
                                    selected: _selectedAction == action,
                                    onTap: () => _triggerDemo(action),
                                    minWidth: ultra ? 82 : 94,
                                    minHeight: chipHeight,
                                    fontSize: chipFont,
                                    radius: chipRadius,
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          _ControlSection(
                            title: 'Animation',
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: chipSpacing,
                              runSpacing: chipSpacing,
                              children: [
                                for (final style
                                    in GooeyToastAnimationStyle.values)
                                  _PlaygroundChip(
                                    label: style.label,
                                    selected: _animationStyle == style,
                                    onTap: () =>
                                        setState(() => _animationStyle = style),
                                    minWidth: ultra ? 80 : 88,
                                    minHeight: chipHeight,
                                    fontSize: chipFont,
                                    radius: chipRadius,
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          _ControlSection(
                            title: 'Shape',
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: chipSpacing,
                              runSpacing: chipSpacing,
                              children: [
                                for (final style in GooeyToastShapeStyle.values)
                                  _PlaygroundChip(
                                    label: style.label,
                                    selected: _shapeStyle == style,
                                    onTap: () =>
                                        setState(() => _shapeStyle = style),
                                    minWidth: ultra ? 82 : 96,
                                    minHeight: chipHeight,
                                    fontSize: chipFont,
                                    radius: chipRadius,
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          _ControlSection(
                            title: 'Behavior',
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: chipSpacing,
                              runSpacing: chipSpacing,
                              children: [
                                _PlaygroundChip(
                                  label: _autopilotEnabled
                                      ? 'on · autopilot'
                                      : 'off · autopilot',
                                  selected: _autopilotEnabled,
                                  onTap: () => setState(
                                    () =>
                                        _autopilotEnabled = !_autopilotEnabled,
                                  ),
                                  minWidth: ultra ? 130 : 154,
                                  minHeight: chipHeight,
                                  fontSize: chipFont,
                                  radius: chipRadius,
                                ),
                                _PlaygroundChip(
                                  label: _pauseOnHover
                                      ? 'on · pause-on-hover'
                                      : 'off · pause-on-hover',
                                  selected: _pauseOnHover,
                                  onTap: () => setState(
                                    () => _pauseOnHover = !_pauseOnHover,
                                  ),
                                  minWidth: ultra ? 150 : 182,
                                  minHeight: chipHeight,
                                  fontSize: chipFont,
                                  radius: chipRadius,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          _ControlSection(
                            title: 'Dismiss',
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: chipSpacing,
                                  runSpacing: chipSpacing,
                                  children: [
                                    for (final behavior
                                        in _DismissBehavior.values)
                                      _PlaygroundChip(
                                        label: behavior.label,
                                        selected: _dismissBehavior == behavior,
                                        onTap: () => setState(
                                          () => _dismissBehavior = behavior,
                                        ),
                                        minWidth: ultra ? 80 : 94,
                                        minHeight: chipHeight,
                                        fontSize: chipFont,
                                        radius: chipRadius,
                                      ),
                                  ],
                                ),
                                if (_dismissBehavior == _DismissBehavior.custom)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: chipSpacing,
                                      runSpacing: chipSpacing,
                                      children: [
                                        for (final direction
                                            in ToastSwipeDirection.values)
                                          _PlaygroundChip(
                                            label: direction.label,
                                            selected: _customDismissDirections
                                                .contains(direction),
                                            onTap: () => setState(() {
                                              if (_customDismissDirections
                                                  .contains(direction)) {
                                                _customDismissDirections.remove(
                                                  direction,
                                                );
                                              } else {
                                                _customDismissDirections.add(
                                                  direction,
                                                );
                                              }
                                            }),
                                            minWidth: ultra ? 66 : 74,
                                            minHeight: chipHeight,
                                            fontSize: chipFont,
                                            radius: chipRadius,
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          const _PlaygroundDivider(),
                          SizedBox(height: sectionSpacing),
                          _ControlSection(
                            title: 'Custom State Machine',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: chipSpacing,
                                  runSpacing: chipSpacing,
                                  children: [
                                    SizedBox(
                                      width: ultra ? 176 : 220,
                                      child: TextField(
                                        controller: _customFlowIdController,
                                        decoration: _fieldDecoration('flow id'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ultra ? 176 : 220,
                                      child: TextField(
                                        controller: _customTitleController,
                                        decoration: _fieldDecoration('title'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ultra ? 176 : 280,
                                      child: TextField(
                                        controller:
                                            _customDescriptionController,
                                        decoration: _fieldDecoration(
                                          'description',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ultra ? 128 : 150,
                                      child: TextField(
                                        controller: _customDurationController,
                                        keyboardType: TextInputType.number,
                                        decoration: _fieldDecoration('ms'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: chipSpacing,
                                  runSpacing: chipSpacing,
                                  children: [
                                    for (final state in GooeyToastState.values)
                                      _PlaygroundChip(
                                        label: state.name,
                                        selected: _customState == state,
                                        onTap: () => setState(
                                          () => _customState = state,
                                        ),
                                        minWidth: ultra ? 72 : 84,
                                        minHeight: chipHeight,
                                        fontSize: chipFont,
                                        radius: chipRadius,
                                      ),
                                    _PlaygroundChip(
                                      label: _customStepExpanded
                                          ? 'expanded'
                                          : 'compact',
                                      selected: _customStepExpanded,
                                      onTap: () => setState(
                                        () => _customStepExpanded =
                                            !_customStepExpanded,
                                      ),
                                      minWidth: ultra ? 88 : 108,
                                      minHeight: chipHeight,
                                      fontSize: chipFont,
                                      radius: chipRadius,
                                    ),
                                    _PlaygroundChip(
                                      label: _customStepPersistent
                                          ? 'persist'
                                          : 'auto dismiss',
                                      selected: _customStepPersistent,
                                      onTap: () => setState(
                                        () => _customStepPersistent =
                                            !_customStepPersistent,
                                      ),
                                      minWidth: ultra ? 108 : 132,
                                      minHeight: chipHeight,
                                      fontSize: chipFont,
                                      radius: chipRadius,
                                    ),
                                    _PlaygroundChip(
                                      label: 'Add Step',
                                      selected: false,
                                      onTap: _addCustomStep,
                                      minWidth: ultra ? 92 : 108,
                                      minHeight: chipHeight,
                                      fontSize: chipFont,
                                      radius: chipRadius,
                                    ),
                                    _PlaygroundChip(
                                      label: 'Run Flow',
                                      selected:
                                          _selectedAction ==
                                          _DemoAction.customStateFlow,
                                      onTap: () => _triggerDemo(
                                        _DemoAction.customStateFlow,
                                      ),
                                      minWidth: ultra ? 92 : 108,
                                      minHeight: chipHeight,
                                      fontSize: chipFont,
                                      radius: chipRadius,
                                    ),
                                    _PlaygroundChip(
                                      label: 'Clear Steps',
                                      selected: false,
                                      onTap: _clearCustomSteps,
                                      minWidth: ultra ? 98 : 116,
                                      minHeight: chipHeight,
                                      fontSize: chipFont,
                                      radius: chipRadius,
                                    ),
                                  ],
                                ),
                                if (_customSteps.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEDEDED),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFFD9D9D9),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (
                                          var i = 0;
                                          i < _customSteps.length;
                                          i++
                                        )
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom:
                                                  i == _customSteps.length - 1
                                                  ? 0
                                                  : 6,
                                            ),
                                            child: Text(
                                              '${i + 1}. ${_customSteps[i].state.name} · ${_customSteps[i].title} · ${_customSteps[i].duration.inMilliseconds}ms'
                                              '${_customSteps[i].expanded ? ' · expanded' : ' · compact'}'
                                              '${_customSteps[i].persistUntilDismissed ? ' · persist' : ''}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF6F6F6F),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: sectionSpacing),
                          _ControlSection(
                            title: 'Active Toasts',
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, _) {
                                final active = _controller.activeToasts;
                                if (active.isEmpty) {
                                  return const Text(
                                    'No active toasts.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9B9B9B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                                return Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: chipSpacing,
                                  runSpacing: chipSpacing,
                                  children: [
                                    for (final toast in active)
                                      _PlaygroundChip(
                                        label:
                                            '${toast.id} · ${toast.state.name}${toast.persistUntilDismissed ? ' · persist' : ''}',
                                        selected: false,
                                        onTap: () =>
                                            _controller.dismiss(toast.id),
                                        minWidth: ultra ? 180 : 240,
                                        minHeight: chipHeight,
                                        fontSize: chipFont - 1,
                                        radius: chipRadius,
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ControlSection extends StatelessWidget {
  const _ControlSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8F8F8F),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }
}

class _PlaygroundTitle extends StatelessWidget {
  const _PlaygroundTitle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Playground',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w700,
              height: 1,
              color: const Color(0xFF0A0A0A),
            ),
          ),
          TextSpan(
            text: '.',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w700,
              height: 1,
              color: const Color(0xFFC9C9C9),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaygroundChip extends StatelessWidget {
  const _PlaygroundChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.minWidth,
    required this.minHeight,
    required this.fontSize,
    required this.radius,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double minWidth;
  final double minHeight;
  final double fontSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
        side: BorderSide(
          color: selected ? const Color(0xFF06080B) : const Color(0xFFE3E3E3),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor: const Color(0xFFE9E9E9),
        selectedColor: const Color(0xFF06080B),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        labelStyle: TextStyle(
          color: selected ? const Color(0xFFF2F2F2) : const Color(0xFFA1A1A1),
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
    );
  }
}

class _PlaygroundDivider extends StatelessWidget {
  const _PlaygroundDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFDCDCDC),
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}

class _ViewportPreset {
  const _ViewportPreset({
    required this.label,
    required this.position,
    required this.expandDirection,
  });

  final String label;
  final GooeyToastPosition position;
  final GooeyToastExpandDirection expandDirection;
}

enum _DismissBehavior { auto, custom, off }

extension on _DismissBehavior {
  String get label {
    return switch (this) {
      _DismissBehavior.auto => 'auto',
      _DismissBehavior.custom => 'custom',
      _DismissBehavior.off => 'off',
    };
  }
}

enum _DemoAction {
  success,
  error,
  warning,
  info,
  action,
  icon,
  promise,
  customCompact,
  customExpanded,
  customBoth,
  flightPath,
  interactiveReply,
  flightPromise,
  customStateFlow,
}

extension on _DemoAction {
  String get label {
    return switch (this) {
      _DemoAction.success => 'Success',
      _DemoAction.error => 'Error',
      _DemoAction.warning => 'Warning',
      _DemoAction.info => 'Info',
      _DemoAction.action => 'Action',
      _DemoAction.icon => 'Icon',
      _DemoAction.promise => 'Promise',
      _DemoAction.customCompact => 'Custom Compact',
      _DemoAction.customExpanded => 'Custom Expanded',
      _DemoAction.customBoth => 'Custom Both',
      _DemoAction.flightPath => 'Flight Path',
      _DemoAction.interactiveReply => 'Interactive Reply',
      _DemoAction.flightPromise => 'Flight Promise',
      _DemoAction.customStateFlow => 'Custom States',
    };
  }
}

class _FlightToastModel {
  const _FlightToastModel({
    required this.stateTag,
    required this.title,
    required this.subtitle,
    required this.state,
    required this.icon,
    required this.tone,
    required this.fromCode,
    required this.toCode,
    required this.pnr,
    required this.cta,
    this.showExpanded = true,
    this.duration,
    this.autopilot = const GooeyAutopilot(),
  });

  final Object stateTag;
  final String title;
  final String subtitle;
  final GooeyToastState state;
  final IconData icon;
  final Color tone;
  final String fromCode;
  final String toCode;
  final String pnr;
  final String cta;
  final bool showExpanded;
  final Duration? duration;
  final GooeyAutopilot? autopilot;
}

class _CustomStateStep {
  const _CustomStateStep({
    required this.title,
    required this.description,
    required this.state,
    required this.duration,
    required this.expanded,
    required this.persistUntilDismissed,
  });

  final String title;
  final String description;
  final GooeyToastState state;
  final Duration duration;
  final bool expanded;
  final bool persistUntilDismissed;
}

class _InteractiveReplyExpanded extends StatefulWidget {
  const _InteractiveReplyExpanded({
    required this.onSend,
    required this.onCancel,
  });

  final ValueChanged<String> onSend;
  final VoidCallback onCancel;

  @override
  State<_InteractiveReplyExpanded> createState() =>
      _InteractiveReplyExpandedState();
}

class _InteractiveReplyExpandedState extends State<_InteractiveReplyExpanded> {
  bool _composing = false;
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 14,
      height: 1.35,
      color: Color(0xFFC0C5CB),
    );
    final tone = const Color(0xFF8EA3FF);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Click reply to respond from this thread.',
          style: bodyStyle,
        ),
        const SizedBox(height: 10),
        if (_composing)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  autofocus: true,
                  minLines: 2,
                  maxLines: 3,
                  style: const TextStyle(
                    color: Color(0xFFE8ECFF),
                    fontSize: 13,
                  ),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (text.isEmpty) {
                      return 'Reply cannot be empty.';
                    }
                    if (text.length < 3) {
                      return 'Reply must be at least 3 characters.';
                    }
                    if (text.length > 160) {
                      return 'Reply must be 160 characters or less.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Type your reply...',
                    hintStyle: TextStyle(
                      color: tone.withValues(alpha: 0.55),
                      fontSize: 12.5,
                    ),
                    errorStyle: TextStyle(
                      color: const Color(0xFFFF8C8C).withValues(alpha: 0.95),
                      fontSize: 11,
                    ),
                    filled: true,
                    fillColor: const Color(0x26182446),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: tone.withValues(alpha: 0.35),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: tone.withValues(alpha: 0.26),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: tone.withValues(alpha: 0.6),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFFF8C8C)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFFF8C8C)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() => _composing = false);
                      widget.onCancel();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: tone.withValues(alpha: 0.9)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      final isValid =
                          _formKey.currentState?.validate() ?? false;
                      if (!isValid) return;
                      final message = _controller.text.trim();
                      _controller.clear();
                      setState(() => _composing = false);
                      widget.onSend(message);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: tone.withValues(alpha: 0.28),
                      foregroundColor: tone,
                    ),
                    child: const Text('Send'),
                  ),
                ],
              ),
            ],
          )
        else
          TextButton(
            onPressed: () => setState(() => _composing = true),
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 28),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shape: const StadiumBorder(),
              foregroundColor: tone,
              backgroundColor: tone.withValues(alpha: 0.15),
            ),
            child: const Text(
              'Reply',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}

class _ReplyResultExpanded extends StatelessWidget {
  const _ReplyResultExpanded({
    required this.title,
    required this.body,
    required this.tone,
  });

  final String title;
  final String body;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: tone,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: const TextStyle(
            fontSize: 14,
            height: 1.35,
            color: Color(0xFFC0C5CB),
          ),
        ),
      ],
    );
  }
}

extension on GooeyToastAnimationStyle {
  String get label {
    return switch (this) {
      GooeyToastAnimationStyle.sileo => 'sileo',
      GooeyToastAnimationStyle.smooth => 'smooth',
      GooeyToastAnimationStyle.snappy => 'snappy',
      GooeyToastAnimationStyle.bouncy => 'bouncy',
    };
  }
}

extension on GooeyToastShapeStyle {
  String get label {
    return switch (this) {
      GooeyToastShapeStyle.defaultShape => 'default',
      GooeyToastShapeStyle.soft => 'soft',
      GooeyToastShapeStyle.sharp => 'sharp',
      GooeyToastShapeStyle.capsule => 'capsule',
    };
  }
}

extension on ToastSwipeDirection {
  String get label {
    return switch (this) {
      ToastSwipeDirection.up => 'up',
      ToastSwipeDirection.down => 'down',
      ToastSwipeDirection.left => 'left',
      ToastSwipeDirection.right => 'right',
    };
  }
}
