import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../autocomplete/autocomplete.dart';
import '../chip_input/chip_input.dart';

class ChipInputPreview extends StatefulWidget {
  const ChipInputPreview({super.key});

  @override
  State<ChipInputPreview> createState() => _ChipInputPreviewState();
}

class _ChipInputPreviewState extends State<ChipInputPreview> {
  List<String> _suggestions = [];
  final ChipEditingController<String> _controller = ChipEditingController();

  static const List<String> _availableSuggestions = [
    'hello world',
    'lorem ipsum',
    'do re mi',
    'foo bar',
    'flutter dart',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        final value = _controller.textAtCursor;
        if (value.isNotEmpty) {
          _suggestions = _availableSuggestions.where((element) {
            return element.startsWith(value);
          }).toList();
        } else {
          _suggestions = [];
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoComplete(
              suggestions: _suggestions,
              child: ChipInput<String>(
                controller: _controller,
                onChipSubmitted: (value) {
                  setState(() {
                    _suggestions = [];
                  });
                  return '@$value';
                },
                chipBuilder: (context, chip) {
                  return Text(chip);
                },
              ),
            ),
            const Gap(24),
            ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                return Text('Current chips: ${_controller.chips.join(', ')}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
