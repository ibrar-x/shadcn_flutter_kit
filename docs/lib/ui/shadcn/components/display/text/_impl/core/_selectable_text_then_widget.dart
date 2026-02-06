part of '../../text.dart';

class _SelectableTextThenWidget extends StatelessWidget {
  final SelectableText text;
  final List<InlineSpan> then;

  const _SelectableTextThenWidget({
    required this.text,
    required this.then,
  });

  @override
  Widget build(BuildContext context) {
    String? stringData = text.data;
    TextSpan? textData = text.textSpan;
    return SelectableText.rich(
      TextSpan(
        text: stringData,
        children: [
          if (textData != null) textData,
          ...then,
        ],
      ),
      style: text.style,
      useNativeContextMenu: text.useNativeContextMenu,
      contextMenuBuilder: text.contextMenuBuilder,
      minLines: text.minLines,
      semanticsLabel: text.semanticsLabel,
      textScaler: text.textScaler,
      magnifierConfiguration: text.magnifierConfiguration,
      selectionHeightStyle: text.selectionHeightStyle,
      selectionWidthStyle: text.selectionWidthStyle,
      textAlign: text.textAlign,
      textDirection: text.textDirection,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
      maxLines: text.maxLines,
      strutStyle: text.strutStyle,
      selectionControls: text.selectionControls,
      onTap: text.onTap,
      scrollPhysics: text.scrollPhysics,
      showCursor: text.showCursor,
      cursorWidth: text.cursorWidth,
      cursorHeight: text.cursorHeight,
      cursorRadius: text.cursorRadius,
      cursorColor: text.cursorColor,
      dragStartBehavior: text.dragStartBehavior,
      enableInteractiveSelection: text.enableInteractiveSelection,
      autofocus: text.autofocus,
      focusNode: text.focusNode,
      onSelectionChanged: text.onSelectionChanged,
    );
  }
}
