import 'package:flutter/material.dart';

import '../patch.dart';
import 'patch_preview.dart';

class PatchPreviewState extends State<PatchPreview> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClickDetector(
          onClick: (details) {
            setState(() {
              _clicks = details.clickCount;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('Clicks: $_clicks'),
          ),
        ),
      ),
    );
  }
}
