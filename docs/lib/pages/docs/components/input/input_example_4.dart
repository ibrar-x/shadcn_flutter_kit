import 'package:docs/shadcn_ui.dart';

class InputExample4 extends StatelessWidget {
  const InputExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: FormField(
        // Use a stable key for form state lookups and debugging.
        key: const InputKey(#test),
        label: const Text('Username'),
        // Async validator simulating server-side availability check.
        // Returns `false` (invalid) when the username is taken.
        validator: ConditionalValidator((value) async {
          // Simulate a network delay for demonstration purposes
          await Future.delayed(const Duration(seconds: 1));
          return !['M Ibrar', 'septogeddon', 'admin'].contains(value);
        }, message: 'Username already taken'),
        child: const TextField(
          placeholder: Text('Enter your username'),
          initialValue: 'M Ibrar',
          features: [
            // Manually triggers the validator again (useful after edits or on demand).
            InputFeature.revalidate(),
          ],
        ),
      ),
    );
  }
}
