part of 'item_picker.dart';

class _InternalItemPicker<T> extends StatelessWidget {
  final ItemChildDelegate<T> items;
  final ItemPickerBuilder<T> builder;
  final T? initialValue;
  final ItemPickerLayout layout;
  final Widget? title;
  final BoxConstraints? constraints;
  final ValueChanged<T?> onChanged;
  const _InternalItemPicker({
    super.key,
    required this.items,
    required this.builder,
    required this.initialValue,
    required this.layout,
    this.title,
    this.constraints,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = MediaQuery.paddingOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.all(16.0 * theme.scaling) +
                EdgeInsets.only(top: padding.top),
            child: title?.large.semiBold,
          ),
        ConstrainedBox(
          constraints: constraints ??
              BoxConstraints(
                maxWidth: 320 * theme.scaling,
                maxHeight: 320 * theme.scaling,
              ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: title != null
                  ? padding.copyWith(top: 0) +
                      const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0) *
                          theme.scaling
                  : padding + const EdgeInsets.all(8) * theme.scaling,
            ),
            child: ItemPickerDialog<T>(
              items: items,
              builder: builder,
              layout: layout,
              value: initialValue,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
