part of '../../text.dart';


class _TextThenWidget extends StatelessWidget {
  final Text text;
  final List<InlineSpan> then;

  const _TextThenWidget({required this.text, required this.then});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text.data ?? '',
        style: text.style ?? DefaultTextStyle.of(context).style,
        children: then,
      ),
      textAlign: text.textAlign ?? TextAlign.start,
      textDirection: text.textDirection,
      softWrap: text.softWrap ?? true,
      overflow: text.overflow ?? TextOverflow.clip,
      maxLines: text.maxLines,
      textScaler: text.textScaler ?? MediaQuery.textScalerOf(context),
      textWidthBasis: text.textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: text.textHeightBehavior,
    );
  }
}
