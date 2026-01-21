import 'package:flutter/material.dart' hide TextButton;

import '../breadcrumb/breadcrumb.dart';
import '../button/button.dart';
import '../triple_dots/triple_dots.dart';

class BreadcrumbPreview extends StatelessWidget {
  const BreadcrumbPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 24,
              children: [
                // Breadcrumb with arrow separator
                Breadcrumb(
                  separator: Breadcrumb.arrowSeparator,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Home'),
                    ),
                    const MoreDots(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Components'),
                    ),
                    const Text('Breadcrumb'),
                  ],
                ),
                // Breadcrumb with slash separator
                Breadcrumb(
                  separator: Breadcrumb.slashSeparator,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Docs'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('UI Components'),
                    ),
                    const Text('Navigation'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
