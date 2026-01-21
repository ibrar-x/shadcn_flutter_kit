import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../avatar/avatar.dart';
import '../skeleton/skeleton.dart';
import '../../shared/primitives/basic.dart';
import '../avatar/avatar.dart';
import '../skeleton/skeleton.dart';

class SkeletonPreview extends StatelessWidget {
  const SkeletonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Basic(
              title: Text('Skeleton Example 1'),
              content: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: Avatar(initials: ''),
              trailing: Icon(Icons.arrow_forward),
            ),
            const Gap(24),
            Basic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              leading: const Avatar(initials: '').asSkeleton(),
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
          ],
        ),
      ),
    );
  }
}
