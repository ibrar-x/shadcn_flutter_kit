part of '../autocomplete.dart';

class _AutoCompleteItem extends StatefulWidget {
  final String suggestion;
  final bool selected;
  final VoidCallback onSelected;

  const _AutoCompleteItem({
    required this.suggestion,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<_AutoCompleteItem> createState() => _AutoCompleteItemState();
}
