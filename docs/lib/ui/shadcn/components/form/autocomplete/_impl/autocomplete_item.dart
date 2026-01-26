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

class _AutoCompleteItemState extends State<_AutoCompleteItem> {
  @override
  Widget build(BuildContext context) {
    return SelectedButton(
      value: widget.selected,
      alignment: AlignmentDirectional.centerStart,
      onChanged: (value) {
        widget.onSelected();
      },
      child: Text(widget.suggestion),
    );
  }

  @override
  void didUpdateWidget(covariant _AutoCompleteItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) {
          return;
        }
        if (widget.selected) {
          Scrollable.ensureVisible(context);
        }
      });
    }
  }
}
