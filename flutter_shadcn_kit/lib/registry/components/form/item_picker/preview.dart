import 'package:flutter/material.dart';

import '../item_picker/item_picker.dart';

class ItemPickerPreview extends StatefulWidget {
  const ItemPickerPreview({super.key});

  @override
  State<ItemPickerPreview> createState() => _ItemPickerPreviewState();
}

class _ItemPickerPreviewState extends State<ItemPickerPreview> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ItemPicker<String>(
          items: const ItemList(['Alpha', 'Beta', 'Gamma', 'Delta']),
          value: _value,
          placeholder: const Text('Pick item'),
          builder: (context, value) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(value),
            );
          },
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ),
    );
  }
}
