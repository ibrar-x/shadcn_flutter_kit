import 'package:flutter/material.dart';
import '../group/group_widget.dart';

class GroupPreview extends StatelessWidget {
  const GroupPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 140,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GroupWidget(
              children: [
                const GroupPositioned(top: 8, left: 8, child: Text('Layered')),
                GroupPositioned.fromRect(
                  rect: const Rect.fromLTWH(24, 40, 90, 50),
                  child: Container(color: Colors.blue.shade300),
                ),
                const GroupPositioned(
                  right: 8,
                  bottom: 8,
                  child: Icon(Icons.layers),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
