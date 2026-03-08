import 'package:flutter/material.dart';
import '../basic/basic.dart';

/// BasicPreview defines a reusable type for this registry module.
class BasicPreview extends StatelessWidget {
  const BasicPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Basic(
          leading: Icon(Icons.person),
          title: Text('John Doe'),
          subtitle: Text('john@example.com'),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
