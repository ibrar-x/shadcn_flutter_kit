import 'package:flutter/material.dart';
import '../hover/hover.dart';

class HoverPreview extends StatefulWidget {
  const HoverPreview({super.key});

  @override
  State<HoverPreview> createState() => _HoverPreviewState();
}

class _HoverPreviewState extends State<HoverPreview> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hover(
          onHover: (value) {
            setState(() {
              _hovered = value;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _hovered ? Colors.blue.shade100 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_hovered ? 'Hovered' : 'Hover me'),
          ),
        ),
      ),
    );
  }
}
