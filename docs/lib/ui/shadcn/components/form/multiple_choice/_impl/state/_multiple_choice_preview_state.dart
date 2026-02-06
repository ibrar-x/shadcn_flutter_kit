part of '../../preview.dart';

class _MultipleChoicePreviewState extends State<MultipleChoicePreview> {
  String? _singleValue;
  Iterable<String>? _multiValue = const [];

  Widget _buildChoice(String value) {
    return Builder(
      builder: (context) {
        final selected =
            Choice.getValue<String>(context)?.contains(value) ?? false;
        return GestureDetector(
          onTap: () => Choice.choose<String>(context, value),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? Colors.blue.shade100 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? Colors.blue : Colors.grey.shade400,
              ),
            ),
            child: Text(value),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MultipleChoice<String>(
              value: _singleValue,
              onChanged: (value) {
                setState(() {
                  _singleValue = value;
                });
              },
              child: Wrap(
                spacing: 8,
                children: [
                  _buildChoice('Option A'),
                  _buildChoice('Option B'),
                  _buildChoice('Option C'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            MultipleAnswer<String>(
              value: _multiValue,
              onChanged: (value) {
                setState(() {
                  _multiValue = value;
                });
              },
              child: Wrap(
                spacing: 8,
                children: [
                  _buildChoice('Apple'),
                  _buildChoice('Banana'),
                  _buildChoice('Orange'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
