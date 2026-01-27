part of 'preview.dart';

class _AutocompletePreviewState extends State<AutocompletePreview> {
  final List<String> suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  List<String> _currentSuggestions = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 400,
              child: shadcn.AutoComplete(
                suggestions: _currentSuggestions,
                child: TextField(
                  controller: _controller,
                  placeholder: const Text('Type to search...'),
                  onChanged: (value) {
                    final query = value.trim().toLowerCase();
                    setState(() {
                      if (query.isEmpty) {
                        _currentSuggestions = [];
                      } else {
                        _currentSuggestions = suggestions
                            .where((item) =>
                                item.toLowerCase().contains(query))
                            .toList();
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
