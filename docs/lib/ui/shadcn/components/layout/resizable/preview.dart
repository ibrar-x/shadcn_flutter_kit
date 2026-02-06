import 'package:flutter/material.dart';
import 'resizable.dart';

class ResizablePreview extends StatelessWidget {
  const ResizablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          height: 240,
          child: ResizablePanel.horizontal(
            draggerThickness: 16,
            children: [
              ResizablePane(
                initialSize: 180,
                minSize: 120,
                child: Container(
                  color: Colors.blueGrey.shade100,
                  alignment: Alignment.center,
                  child: const Text('Sidebar'),
                ),
              ),
              ResizablePane.flex(
                initialFlex: 1,
                child: Container(
                  color: Colors.blueGrey.shade50,
                  alignment: Alignment.center,
                  child: const Text('Main content'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
