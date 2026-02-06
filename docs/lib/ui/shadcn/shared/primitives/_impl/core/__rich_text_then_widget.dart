part of '../../text.dart';


class _RichTextThenWidget extends StatelessWidget {
  final RichText text;
  final List<InlineSpan> then;

  const _RichTextThenWidget({required this.text, required this.then});

  @override
  Widget build(BuildContext context) {
    final TextSpan span = text.text as TextSpan;
    return RichText(
      text: TextSpan(
        text: span.text,
        style: span.style,
        children: [...(span.children ?? []), ...then],
      ),
      textAlign: text.textAlign,
      textDirection: text.textDirection,
      softWrap: text.softWrap,
      overflow: text.overflow,
      maxLines: text.maxLines,
      textScaler: text.textScaler,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
    );
  }
}
