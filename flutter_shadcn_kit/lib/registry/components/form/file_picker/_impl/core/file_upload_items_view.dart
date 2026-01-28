part of '../../file_picker.dart';

enum FileUploadItemsLayout { list, grid }

class FileUploadItemsView extends StatelessWidget {
  const FileUploadItemsView({
    super.key,
    required this.items,
    this.layout = FileUploadItemsLayout.list,
    this.columns = 2,
    this.gap,
    this.padding,
    this.showContainer = true,
    this.maxHeight,
    this.itemBuilder,
  });

  final List<FileUploadItem> items;
  final FileUploadItemsLayout layout;
  final int columns;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final bool showContainer;
  final double? maxHeight;
  final Widget Function(BuildContext context, FileUploadItem item)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final spacing = gap ?? 12 * scaling;
    Widget content = layout == FileUploadItemsLayout.grid
        ? _buildGrid(context, spacing)
        : _buildList(context, spacing);

    if (maxHeight != null) {
      content = SizedBox(
        height: maxHeight,
        child: SingleChildScrollView(
          child: content,
        ),
      );
    }

    if (!showContainer) {
      return content;
    }

    return OutlinedContainer(
      borderRadius: BorderRadius.circular(16 * scaling),
      borderWidth: 1,
      borderColor: theme.colorScheme.muted,
      backgroundColor: theme.colorScheme.background,
      child: Padding(
        padding: padding ?? EdgeInsets.all(16 * scaling),
        child: content,
      ),
    );
  }

  Widget _buildList(BuildContext context, double spacing) {
    return Column(
      children: [
        for (final item in items) ...[_buildItem(context, item), Gap(spacing)],
      ],
    );
  }

  Widget _buildGrid(BuildContext context, double spacing) {
    final columnCount = columns < 1 ? 1 : columns;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final tileWidth = (width - (columnCount - 1) * spacing) / columnCount;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final item in items)
              SizedBox(width: tileWidth, child: _buildItem(context, item)),
          ],
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, FileUploadItem item) {
    return itemBuilder?.call(context, item) ?? FileItem(item: item);
  }
}
