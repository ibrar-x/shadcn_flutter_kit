import 'package:flutter/material.dart';
import '../async/async.dart';

class AsyncPreview extends StatelessWidget {
  const AsyncPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureOrBuilder<String>(
          future: Future<String>.delayed(
            const Duration(milliseconds: 800),
            () => 'Loaded value',
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
