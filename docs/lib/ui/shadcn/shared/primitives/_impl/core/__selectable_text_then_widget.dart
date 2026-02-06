part of '../../text.dart';


class _SelectableTextThenWidget extends StatelessWidget {
  final SelectableText text;
  final List<InlineSpan> then;

  const _SelectableTextThenWidget({required this.text, required this.then});

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: text.data ?? '',
        style: text.style ?? DefaultTextStyle.of(context).style,
        children: then,
      ),
      textAlign: text.textAlign ?? TextAlign.start,
      textDirection: text.textDirection,
      textScaler: text.textScaler ?? MediaQuery.textScalerOf(context),
      textHeightBehavior: text.textHeightBehavior,
      maxLines: text.maxLines,
      cursorWidth: text.cursorWidth,
      cursorHeight: text.cursorHeight,
      cursorRadius: text.cursorRadius,
      cursorColor: text.cursorColor,
      showCursor: text.showCursor,
      selectionControls: text.selectionControls,
      onTap: text.onTap,
      scrollPhysics: text.scrollPhysics,
    );
  }
}
