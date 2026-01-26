import 'package:docs/ui/shadcn/shadcn_ui.dart';

/// Avatar with image and initials fallback.
///
/// If the image fails to load, the [initials] will be shown over the
/// [backgroundColor]. This example uses a remote GitHub avatar URL.
class AvatarExample1 extends StatelessWidget {
  const AvatarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      backgroundColor: Colors.red,
      // Helper to derive initials from a username or full name.
      initials: Avatar.getInitials('M Ibrar'),
      provider: const NetworkImage(
          'https://avatars.githubusercontent.com/u/64018564?v=4'),
    );
  }
}
