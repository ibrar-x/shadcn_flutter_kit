import 'package:docs/ui/shadcn/shadcn_ui.dart';

class RepeatedAnimationBuilderExample1 extends StatelessWidget {
  const RepeatedAnimationBuilderExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      // Animate a value from 'start' to 'end' and repeat.
      // The builder below receives the animated double each tick.
      start: -100,
      end: 100,
      // One second per run from start to end.
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Transform.translate(
          // Move a square horizontally based on the current animated value.
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
