part of '../../file_picker.dart';

enum FileUploadItemsLayout { list, grid }

class FileUploadItemsView extends StatelessWidget {
  const FileUploadItemsView({
    super.key,
    required this.items,
    this.layout = FileUploadItemsLayout.list,
    this.groupByStatus = false,
    this.statusLabels = const FileUploadStatusLabels(),
    this.columns = 2,
    this.gap,
    this.padding,
    this.showContainer = true,
    this.maxHeight,
    this.itemBuilder,
  });

  final List<FileUploadItem> items;
  final FileUploadItemsLayout layout;
  final bool groupByStatus;
  final FileUploadStatusLabels statusLabels;
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
    final spacing = gap ?? theme.density.baseGap * scaling * 1.5;
    Widget content = layout == FileUploadItemsLayout.grid
        ? _buildGrid(context, spacing)
        : groupByStatus
        ? _buildGroupedList(context, spacing, theme)
        : _buildList(context, spacing);

    if (maxHeight != null) {
      content = SizedBox(
        height: maxHeight,
        child: SingleChildScrollView(child: content),
      );
    }

    if (!showContainer) {
      return content;
    }

    return OutlinedContainer(
      borderWidth: 1,
      child: Padding(
        padding:
            padding ??
            EdgeInsets.all(theme.density.baseContentPadding * scaling),
        child: content,
      ),
    );
  }

  Widget _buildList(BuildContext context, double spacing) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          _buildItem(context, items[i]),
          if (i != items.length - 1) Gap(spacing),
        ],
      ],
    );
  }

  Widget _buildGroupedList(
    BuildContext context,
    double spacing,
    ThemeData theme,
  ) {
    final waiting = items
        .where((item) => item.status == FileUploadItemStatus.idle)
        .toList();
    final uploading = items
        .where((item) => item.status == FileUploadItemStatus.uploading)
        .toList();
    final completed = items
        .where((item) => item.status == FileUploadItemStatus.success)
        .toList();
    final failed = items
        .where((item) => item.status == FileUploadItemStatus.error)
        .toList();

    final sections = <Widget>[];
    void addSection(String label, List<FileUploadItem> group) {
      if (group.isEmpty) return;
      sections.add(
        DefaultTextStyle.merge(
          style: theme.typography.xSmall.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
          child: Text('$label (${group.length})'),
        ),
      );
      sections.add(Gap(spacing * 0.5));
      for (var i = 0; i < group.length; i++) {
        sections.add(_buildItem(context, group[i]));
        if (i != group.length - 1) {
          sections.add(Gap(spacing));
        }
      }
    }

    addSection(statusLabels.uploading, uploading);
    addSection(statusLabels.completed, completed);
    addSection(statusLabels.waiting, waiting);
    addSection(statusLabels.failed, failed);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < sections.length; i++) ...[
          sections[i],
          if (i != sections.length - 1) Gap(spacing),
        ],
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
    return itemBuilder?.call(context, item) ??
        FileItem(item: item, statusLabels: statusLabels);
  }
}
