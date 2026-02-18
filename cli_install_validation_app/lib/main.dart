import 'package:flutter/material.dart';

void main() {
  runApp(const ValidationApp());
}

class ValidationApp extends StatelessWidget {
  const ValidationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLI Install Validation App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const ValidationHome(),
    );
  }
}

class ValidationHome extends StatelessWidget {
  const ValidationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('shadcn CLI Validation')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Use tool/install_and_check.sh from this project directory to '
          'install a component with the local CLI, verify byte parity '
          'against the registry, and run flutter analyze.',
        ),
      ),
    );
  }
}
