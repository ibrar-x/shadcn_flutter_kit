part of '../../stepper.dart';

class _StepVariantCircleAlternative extends StepVariant {
  const _StepVariantCircleAlternative();
  @override
  Widget build(BuildContext context, StepProperties properties) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final steps = properties.steps;
    if (properties.direction == Axis.horizontal) {
      List<Widget> children = [];
      for (int i = 0; i < steps.length; i++) {
        children.add(
          Data.inherit(
              data: StepNumberData(stepIndex: i),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        i == 0
                            ? const Spacer()
                            : Expanded(
                                child: AnimatedBuilder(
                                    animation: properties.state,
                                    builder: (context, child) {
                                      return Divider(
                                        thickness: 2 * scaling,
                                        color: properties.hasFailure &&
                                                properties.state.value
                                                        .currentStep <=
                                                    i - 1
                                            ? theme.colorScheme.destructive
                                            : properties.state.value
                                                        .currentStep >=
                                                    i - 1
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.border,
                                      );
                                    }),
                              ),
                        Gap(4 * scaling),
                        steps[i].icon ?? const StepNumber(),
                        Gap(4 * scaling),
                        i == steps.length - 1
                            ? const Spacer()
                            : Expanded(
                                child: AnimatedBuilder(
                                    animation: properties.state,
                                    builder: (context, child) {
                                      return Divider(
                                        thickness: 2 * scaling,
                                        color: properties.hasFailure &&
                                                properties.state.value
                                                        .currentStep <=
                                                    i
                                            ? theme.colorScheme.destructive
                                            : properties.state.value
                                                        .currentStep >=
                                                    i
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.border,
                                      );
                                    }),
                              ),
                      ],
                    ),
                    Gap(4 * scaling),
                    Center(
                      child: DefaultTextStyle.merge(
                        textAlign: TextAlign.center,
                        child: properties.size.wrapper(
                          context,
                          steps[i].title,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
          AnimatedBuilder(
              animation: properties.state,
              builder: (context, child) {
                var current = properties.state.value.currentStep;
                return Flexible(
                    child: IndexedStack(
                  index: current < 0 || current >= properties.steps.length
                      ? properties.steps.length // will show the placeholder
                      : current,
                  children: [
                    for (int i = 0; i < properties.steps.length; i++)
                      properties[i]?.contentBuilder?.call(context) ??
                          const SizedBox(),
                    const SizedBox(), // for placeholder
                  ],
                ));
              }),
        ],
      );
    } else {
      // it's just the same as circle variant
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        children.add(
          Data.inherit(
            data: StepNumberData(stepIndex: i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    properties.steps[i].icon ?? const StepNumber(),
                    Gap(8 * scaling),
                    properties.size.wrapper(context, properties.steps[i].title),
                  ],
                ),
                Gap(8 * scaling),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 16 * scaling,
                  ),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: properties.size.size,
                          child: i == properties.steps.length - 1
                              ? null
                              : AnimatedBuilder(
                                  animation: properties.state,
                                  builder: (context, child) {
                                    return VerticalDivider(
                                      thickness: 2 * scaling,
                                      color: properties.hasFailure &&
                                              properties.state.value
                                                      .currentStep <=
                                                  i
                                          ? theme.colorScheme.destructive
                                          : properties.state.value
                                                      .currentStep >=
                                                  i
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.border,
                                    );
                                  }),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: properties.state,
                          child:
                              properties.steps[i].contentBuilder?.call(context),
                          builder: (context, child) {
                            return AnimatedCrossFade(
                              firstChild: Container(
                                height: 0,
                              ),
                              secondChild: Container(
                                margin: EdgeInsets.only(
                                  left: properties.size.size,
                                ),
                                child: child!,
                              ),
                              firstCurve: const Interval(0.0, 0.6,
                                  curve: Curves.fastOutSlowIn),
                              secondCurve: const Interval(0.4, 1.0,
                                  curve: Curves.fastOutSlowIn),
                              sizeCurve: Curves.fastOutSlowIn,
                              crossFadeState:
                                  properties.state.value.currentStep == i
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                              duration: kDefaultDuration,
                            );
                          }),
                    ],
                  ),
                ),
                AnimatedBuilder(
                    animation: properties.state,
                    builder: (context, child) {
                      if (i == properties.steps.length - 1) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: 8 * scaling,
                      );
                    }),
              ],
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}
