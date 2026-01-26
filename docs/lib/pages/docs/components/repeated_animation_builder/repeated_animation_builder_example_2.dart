import 'package:docs/ui/shadcn/shadcn_ui.dart';

class RepeatedAnimationBuilderExample2 extends StatelessWidget {
  const RepeatedAnimationBuilderExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      start: -100,
      end: 100,
      duration: const Duration(seconds: 1),
      // Apply a non-linear easing curve.
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
    );
  }
}
