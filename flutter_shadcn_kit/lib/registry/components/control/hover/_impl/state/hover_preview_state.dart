import 'package:flutter/material.dart';

import '../../hover.dart';
import '../core/hover_preview.dart';

/// HoverPreviewState defines a reusable type for this registry module.
class HoverPreviewState extends State<HoverPreview> {
/// Stores `_hovered` state/configuration for this implementation.
  bool _hovered = false;

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hover(
          onHover: (value) {
/// Creates a `setState` instance.
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
