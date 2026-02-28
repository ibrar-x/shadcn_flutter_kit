part of '../../avatar.dart';

/// Core class used by the avatar component.
abstract class AvatarWidget extends Widget {
  const AvatarWidget({super.key});

  double? get size;

  double? get borderRadius;
}
