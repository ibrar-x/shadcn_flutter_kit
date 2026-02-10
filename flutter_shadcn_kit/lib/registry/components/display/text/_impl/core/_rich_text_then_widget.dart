part of '../../text.dart';

class _RichTextThenWidget extends StatelessWidget {
  final RichText text;
  final List<InlineSpan> then;

  const _RichTextThenWidget({required this.text, required this.then});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: text.textAlign,
      textDirection: text.textDirection,
      locale: text.locale,
      softWrap: text.softWrap,
      overflow: text.overflow,
      textWidthBasis: text.textWidthBasis,
      textHeightBehavior: text.textHeightBehavior,
      maxLines: text.maxLines,
      strutStyle: text.strutStyle,
      selectionColor: text.selectionColor,
      selectionRegistrar: text.selectionRegistrar,
      textScaler: text.textScaler,
      text: TextSpan(children: [text.text, ...then]),
    );
  }
}
