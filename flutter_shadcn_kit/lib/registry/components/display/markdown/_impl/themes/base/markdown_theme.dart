part of '../../../markdown.dart';

class MarkdownTheme extends ComponentThemeData {
  const MarkdownTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.style,
    this.linkStyle,
    this.codeStyle,
    this.codeLanguageStyle,
    this.mathStyle,
    this.quoteStyle,
    this.tableHeaderStyle,
    this.tableCellStyle,
    this.footnoteLabelStyle,
    this.imageCaptionStyle,
    this.detailsSummaryStyle,
    this.heading1Style,
    this.heading2Style,
    this.heading3Style,
    this.heading4Style,
    this.heading5Style,
    this.heading6Style,
    this.horizontalRuleColor,
    this.codeBackgroundColor,
    this.quoteBorderColor,
    this.quoteBackgroundColor,
    this.tableBorderColor,
    this.tableHeaderBackgroundColor,
    this.detailsBorderColor,
    this.detailsBackgroundColor,
    this.blockSpacing,
    this.listIndent,
    this.quoteBorderWidth,
    this.imageMaxHeight,
    this.tableCellMinWidth,
    this.codePadding,
    this.quotePadding,
    this.tableCellPadding,
    this.detailsHeaderPadding,
    this.detailsBodyPadding,
    this.codeRadius,
    this.tableRadius,
    this.detailsRadius,
  });

  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextStyle? codeStyle;
  final TextStyle? codeLanguageStyle;
  final TextStyle? mathStyle;
  final TextStyle? quoteStyle;
  final TextStyle? tableHeaderStyle;
  final TextStyle? tableCellStyle;
  final TextStyle? footnoteLabelStyle;
  final TextStyle? imageCaptionStyle;
  final TextStyle? detailsSummaryStyle;
  final TextStyle? heading1Style;
  final TextStyle? heading2Style;
  final TextStyle? heading3Style;
  final TextStyle? heading4Style;
  final TextStyle? heading5Style;
  final TextStyle? heading6Style;

  final Color? horizontalRuleColor;
  final Color? codeBackgroundColor;
  final Color? quoteBorderColor;
  final Color? quoteBackgroundColor;
  final Color? tableBorderColor;
  final Color? tableHeaderBackgroundColor;
  final Color? detailsBorderColor;
  final Color? detailsBackgroundColor;

  final double? blockSpacing;
  final double? listIndent;
  final double? quoteBorderWidth;
  final double? imageMaxHeight;
  final double? tableCellMinWidth;

  final EdgeInsetsGeometry? codePadding;
  final EdgeInsetsGeometry? quotePadding;
  final EdgeInsetsGeometry? tableCellPadding;
  final EdgeInsetsGeometry? detailsHeaderPadding;
  final EdgeInsetsGeometry? detailsBodyPadding;

  final BorderRadiusGeometry? codeRadius;
  final BorderRadiusGeometry? tableRadius;
  final BorderRadiusGeometry? detailsRadius;

  MarkdownTheme copyWith({
    ValueGetter<TextStyle?>? style,
    ValueGetter<TextStyle?>? linkStyle,
    ValueGetter<TextStyle?>? codeStyle,
    ValueGetter<TextStyle?>? codeLanguageStyle,
    ValueGetter<TextStyle?>? mathStyle,
    ValueGetter<TextStyle?>? quoteStyle,
    ValueGetter<TextStyle?>? tableHeaderStyle,
    ValueGetter<TextStyle?>? tableCellStyle,
    ValueGetter<TextStyle?>? footnoteLabelStyle,
    ValueGetter<TextStyle?>? imageCaptionStyle,
    ValueGetter<TextStyle?>? detailsSummaryStyle,
    ValueGetter<TextStyle?>? heading1Style,
    ValueGetter<TextStyle?>? heading2Style,
    ValueGetter<TextStyle?>? heading3Style,
    ValueGetter<TextStyle?>? heading4Style,
    ValueGetter<TextStyle?>? heading5Style,
    ValueGetter<TextStyle?>? heading6Style,
    ValueGetter<Color?>? horizontalRuleColor,
    ValueGetter<Color?>? codeBackgroundColor,
    ValueGetter<Color?>? quoteBorderColor,
    ValueGetter<Color?>? quoteBackgroundColor,
    ValueGetter<Color?>? tableBorderColor,
    ValueGetter<Color?>? tableHeaderBackgroundColor,
    ValueGetter<Color?>? detailsBorderColor,
    ValueGetter<Color?>? detailsBackgroundColor,
    ValueGetter<double?>? blockSpacing,
    ValueGetter<double?>? listIndent,
    ValueGetter<double?>? quoteBorderWidth,
    ValueGetter<double?>? imageMaxHeight,
    ValueGetter<double?>? tableCellMinWidth,
    ValueGetter<EdgeInsetsGeometry?>? codePadding,
    ValueGetter<EdgeInsetsGeometry?>? quotePadding,
    ValueGetter<EdgeInsetsGeometry?>? tableCellPadding,
    ValueGetter<EdgeInsetsGeometry?>? detailsHeaderPadding,
    ValueGetter<EdgeInsetsGeometry?>? detailsBodyPadding,
    ValueGetter<BorderRadiusGeometry?>? codeRadius,
    ValueGetter<BorderRadiusGeometry?>? tableRadius,
    ValueGetter<BorderRadiusGeometry?>? detailsRadius,
  }) {
    return MarkdownTheme(
      style: style == null ? this.style : style(),
      linkStyle: linkStyle == null ? this.linkStyle : linkStyle(),
      codeStyle: codeStyle == null ? this.codeStyle : codeStyle(),
      codeLanguageStyle: codeLanguageStyle == null
          ? this.codeLanguageStyle
          : codeLanguageStyle(),
      mathStyle: mathStyle == null ? this.mathStyle : mathStyle(),
      quoteStyle: quoteStyle == null ? this.quoteStyle : quoteStyle(),
      tableHeaderStyle: tableHeaderStyle == null
          ? this.tableHeaderStyle
          : tableHeaderStyle(),
      tableCellStyle: tableCellStyle == null
          ? this.tableCellStyle
          : tableCellStyle(),
      footnoteLabelStyle: footnoteLabelStyle == null
          ? this.footnoteLabelStyle
          : footnoteLabelStyle(),
      imageCaptionStyle: imageCaptionStyle == null
          ? this.imageCaptionStyle
          : imageCaptionStyle(),
      detailsSummaryStyle: detailsSummaryStyle == null
          ? this.detailsSummaryStyle
          : detailsSummaryStyle(),
      heading1Style: heading1Style == null
          ? this.heading1Style
          : heading1Style(),
      heading2Style: heading2Style == null
          ? this.heading2Style
          : heading2Style(),
      heading3Style: heading3Style == null
          ? this.heading3Style
          : heading3Style(),
      heading4Style: heading4Style == null
          ? this.heading4Style
          : heading4Style(),
      heading5Style: heading5Style == null
          ? this.heading5Style
          : heading5Style(),
      heading6Style: heading6Style == null
          ? this.heading6Style
          : heading6Style(),
      horizontalRuleColor: horizontalRuleColor == null
          ? this.horizontalRuleColor
          : horizontalRuleColor(),
      codeBackgroundColor: codeBackgroundColor == null
          ? this.codeBackgroundColor
          : codeBackgroundColor(),
      quoteBorderColor: quoteBorderColor == null
          ? this.quoteBorderColor
          : quoteBorderColor(),
      quoteBackgroundColor: quoteBackgroundColor == null
          ? this.quoteBackgroundColor
          : quoteBackgroundColor(),
      tableBorderColor: tableBorderColor == null
          ? this.tableBorderColor
          : tableBorderColor(),
      tableHeaderBackgroundColor: tableHeaderBackgroundColor == null
          ? this.tableHeaderBackgroundColor
          : tableHeaderBackgroundColor(),
      detailsBorderColor: detailsBorderColor == null
          ? this.detailsBorderColor
          : detailsBorderColor(),
      detailsBackgroundColor: detailsBackgroundColor == null
          ? this.detailsBackgroundColor
          : detailsBackgroundColor(),
      blockSpacing: blockSpacing == null ? this.blockSpacing : blockSpacing(),
      listIndent: listIndent == null ? this.listIndent : listIndent(),
      quoteBorderWidth: quoteBorderWidth == null
          ? this.quoteBorderWidth
          : quoteBorderWidth(),
      imageMaxHeight: imageMaxHeight == null
          ? this.imageMaxHeight
          : imageMaxHeight(),
      tableCellMinWidth: tableCellMinWidth == null
          ? this.tableCellMinWidth
          : tableCellMinWidth(),
      codePadding: codePadding == null ? this.codePadding : codePadding(),
      quotePadding: quotePadding == null ? this.quotePadding : quotePadding(),
      tableCellPadding: tableCellPadding == null
          ? this.tableCellPadding
          : tableCellPadding(),
      detailsHeaderPadding: detailsHeaderPadding == null
          ? this.detailsHeaderPadding
          : detailsHeaderPadding(),
      detailsBodyPadding: detailsBodyPadding == null
          ? this.detailsBodyPadding
          : detailsBodyPadding(),
      codeRadius: codeRadius == null ? this.codeRadius : codeRadius(),
      tableRadius: tableRadius == null ? this.tableRadius : tableRadius(),
      detailsRadius: detailsRadius == null
          ? this.detailsRadius
          : detailsRadius(),
    );
  }
}
