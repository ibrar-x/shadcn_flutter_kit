part of '../../util.dart';


class FormPendingBuilder extends StatelessWidget {
  final Widget? child;
  final FormPendingWidgetBuilder builder;

  const FormPendingBuilder({super.key, required this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    return builder(context, const {}, child);
  }
}

typedef RepeatedAnimationWidgetBuilder = Widget Function(
  BuildContext context,
  double value,
  Widget? child,
);
