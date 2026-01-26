import 'package:docs/ui/shadcn/shadcn_ui.dart';

class RepeatedAnimationBuilderExample3 extends StatefulWidget {
  const RepeatedAnimationBuilderExample3({super.key});

  @override
  State<RepeatedAnimationBuilderExample3> createState() =>
      _RepeatedAnimationBuilderExample3State();
}

class _RepeatedAnimationBuilderExample3State
    extends State<RepeatedAnimationBuilderExample3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RepeatedAnimationBuilder(
          start: -100,
          end: 100,
          duration: const Duration(seconds: 1),
          // Use a smooth curve to keep the motion gentle.
          curve: Curves.easeInOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(value, 0),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            );
          },
        ),
      ],
    );
  }
}
