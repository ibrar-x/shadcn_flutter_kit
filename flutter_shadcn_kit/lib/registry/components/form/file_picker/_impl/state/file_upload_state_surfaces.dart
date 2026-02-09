part of '../../file_picker.dart';

/// Surface rendering methods for drag-drop and tile layouts.
extension _FileUploadStateSurfaces on _FileUploadState {
  /// Builds drag-drop content; shows single item preview in single-file mode.
  Widget _buildDragDropContent(ThemeData theme, double scaling) {
    final singleItemContent =
        (!widget.allowMultiple && _effectiveItems.isNotEmpty)
        ? FileUploadItemsView(
            items: [_effectiveItems.first],
            layout: FileUploadItemsLayout.list,
            showContainer: false,
            statusLabels: widget.statusLabels,
            itemBuilder: widget.itemBuilder,
          )
        : null;

    if (singleItemContent != null) {
      return singleItemContent;
    }

    final icon =
        widget.icon ??
        Icon(
          RadixIcons.upload,
          size: 28 * scaling,
          color: widget.enabled
              ? theme.colorScheme.mutedForeground
              : theme.colorScheme.mutedForeground.withOpacity(0.5),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        DensityGap(gapMd),
        DefaultTextStyle.merge(
          style: theme.typography.small.copyWith(
            color: widget.enabled
                ? theme.colorScheme.mutedForeground
                : theme.colorScheme.mutedForeground.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
          child: Text(_dragDropLabel()),
        ),
        if (widget.hint != null) ...[
          DensityGap(gapSm),
          DefaultTextStyle.merge(
            style: theme.typography.xSmall.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
            child: widget.hint!,
          ),
        ],
      ],
    );
  }

  /// Returns contextual drag-drop helper text from current state.
  String _dragDropLabel() {
    if (!widget.enabled) return 'File uploads disabled';
    if (_dragActive || _state == FileUploadState.dragging) {
      return 'Drop files to upload';
    }
    switch (_state) {
      case FileUploadState.uploading:
        return 'Uploading files...';
      case FileUploadState.success:
        return 'Files ready';
      case FileUploadState.error:
        return 'Fix errors to continue';
      case FileUploadState.idle:
      case FileUploadState.disabled:
      case FileUploadState.dragging:
        return widget.enableDragDrop
            ? 'Drag files here or click to pick files.'
            : 'Click to pick files.';
    }
  }

  /// Builds full drag-drop surface and wraps native drop target handlers.
  Widget _buildDragDropSurface(
    ThemeData theme,
    FileUploadDropzoneTheme? dropzoneTheme,
  ) {
    final scaling = theme.scaling;
    final canDrop = widget.enableDragDrop && _adapter.supportsDragDrop;
    final isEnabled = widget.enabled;
    final dropzoneMinHeight =
        widget.minHeight ?? dropzoneTheme?.minHeight ?? 220 * scaling;

    final dropzone = FileDropzone(
      hotDropEnabled: canDrop,
      hotDropping: _dragActive,
      enabled: isEnabled,
      state: _mapDropzoneState(_state),
      isFocused: _focused,
      showDefaultContent: false,
      content: _buildDragDropContent(theme, scaling),
      backgroundColor: widget.backgroundColor ?? dropzoneTheme?.backgroundColor,
      borderRadius: widget.borderRadius ?? dropzoneTheme?.borderRadius,
      padding: widget.padding ?? dropzoneTheme?.padding,
      minHeight: dropzoneMinHeight,
    );

    final onTap = widget.enableDropzoneClick && widget.enabled
        ? _pickFiles
        : null;

    if (widget.dropTargetBuilder != null) {
      return widget.dropTargetBuilder!(
        child: dropzone,
        enabled: isEnabled && canDrop,
        withData: widget.withData,
        onDragActive: _setDragActive,
        onDrop: _handleDrop,
        onTap: onTap,
      );
    }

    return _adapter.buildDropTarget(
      enabled: isEnabled && canDrop,
      withData: widget.withData,
      onDragActive: _setDragActive,
      onDrop: _handleDrop,
      onTap: onTap,
      child: dropzone,
    );
  }

  /// Builds compact tile-style file picker surface.
  Widget _buildTileSurface(
    ThemeData theme,
    FileUploadDropzoneTheme? dropzoneTheme,
  ) {
    final scaling = theme.scaling;
    final minHeight = widget.minHeight ?? 48 * scaling;
    final canPick = widget.enabled && widget.pickFiles != null;
    final backgroundColor =
        widget.backgroundColor ??
        dropzoneTheme?.backgroundColor ??
        theme.colorScheme.background;

    final buttonLabel = widget.actionLabel ?? 'Choose File';
    final selectedLabel = _tileSelectionLabel();
    final hasSelection = _effectiveItems.isNotEmpty;
    final textColor = widget.enabled
        ? theme.colorScheme.foreground
        : theme.colorScheme.mutedForeground.withOpacity(0.7);
    final fileNameColor = hasSelection
        ? textColor
        : theme.colorScheme.mutedForeground.withOpacity(
            widget.enabled ? 1 : 0.7,
          );

    return OutlinedContainer(
      borderWidth: 1,
      borderRadius: widget.borderRadius,
      backgroundColor: backgroundColor,
      boxShadow: _focused
          ? [
              BoxShadow(
                color: theme.colorScheme.ring.withOpacity(0.45),
                blurRadius: 0,
                spreadRadius: 2 * scaling,
              ),
            ]
          : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: GestureDetector(
          onTap: canPick ? _pickFiles : null,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding:
                widget.padding ??
                EdgeInsets.symmetric(
                  horizontal: theme.density.baseContainerPadding * scaling,
                  vertical: theme.density.baseGap * scaling,
                ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.density.baseContainerPadding * scaling,
                    vertical: theme.density.baseGap * scaling,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(6 * scaling),
                  ),
                  child: DefaultTextStyle.merge(
                    style: theme.typography.small
                        .merge(theme.typography.semiBold)
                        .copyWith(color: textColor),
                    child: Text(buttonLabel),
                  ),
                ),
                DensityGap(0.75),
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: theme.typography.small.copyWith(
                      color: fileNameColor,
                    ),
                    child: Text(
                      selectedLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Resolves tile value text based on selected files.
  String _tileSelectionLabel() {
    final files = _effectiveItems
        .map((item) => item.file)
        .toList(growable: false);
    if (widget.tileSelectionTextBuilder != null) {
      final custom = widget.tileSelectionTextBuilder!.call(files);
      if (custom.trim().isNotEmpty) {
        return custom;
      }
    }
    if (files.isEmpty) {
      return widget.tileEmptySelectionLabel;
    }
    if (files.length == 1) {
      return files.first.name;
    }
    final firstName = files.first.name;
    final remaining = files.length - 1;
    return '$firstName +$remaining more';
  }
}
