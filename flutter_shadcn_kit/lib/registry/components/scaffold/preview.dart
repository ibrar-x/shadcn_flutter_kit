import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import '../scaffold/scaffold.dart';

class ScaffoldPreview extends StatelessWidget {
  const ScaffoldPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      loadingProgress: 0.45,
      headers: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blueGrey.shade50,
          child: const Text('Header'),
        ),
      ],
      footers: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blueGrey.shade50,
          child: const Text('Footer'),
        ),
      ],
      child: const Center(
        child: Text('Body content'),
      ),
    );
  }
}
