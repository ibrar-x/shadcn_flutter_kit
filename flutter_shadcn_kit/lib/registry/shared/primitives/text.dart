import 'package:data_widget/data_widget.dart';
import 'package:flutter/material.dart' show SelectableText;
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// Abstract base class for text modifier widgets.
///
/// Text modifiers provide a fluent API for applying text styles and
/// transformations. They extend [Widget] and can be called as functions
/// to apply additional style properties.
///
/// Use the [TextExtension] methods to create and chain text modifiers.
abstract class TextModifier extends StatelessWidget {
  /// Creates a [TextModifier].
  const TextModifier({super.key});

  /// Applies additional text style properties to this modifier.
  ///
  /// All parameters are optional and can be used to override or extend
  /// the current text styling.
  ///
  /// Parameters:
  /// - [color] (`Color?`, optional): Text color.
  /// - [backgroundColor] (`Color?`, optional): Background color for text.
  /// - [fontSize] (`double?`, optional): Font size in logical pixels.
  /// - [fontWeight] (`FontWeight?`, optional): Font weight (e.g., bold, normal).
  /// - [fontStyle] (`FontStyle?`, optional): Font style (e.g., italic, normal).
  /// - [letterSpacing] (`double?`, optional): Space between letters.
  /// - [wordSpacing] (`double?`, optional): Space between words.
  /// - [textBaseline] (`TextBaseline?`, optional): Text baseline alignment.
  /// - [height] (`double?`, optional): Line height multiplier.
  /// - [leadingDistribution] (`TextLeadingDistribution?`, optional): How to distribute line height.
  /// - [locale] (`Locale?`, optional): Locale for font selection.
  /// - [foreground] (`Paint?`, optional): Custom foreground paint.
  /// - [background] (`Paint?`, optional): Custom background paint.
  /// - [shadows] (`List<Shadow>?`, optional): Text shadows.
  /// - [fontFeatures] (`List<FontFeature>?`, optional): OpenType font features.
  /// - [fontVariations] (`List<FontVariation>?`, optional): Font variations.
  /// - [decoration] (`TextDecoration?`, optional): Text decoration (underline, etc.).
  /// - [decorationColor] (`Color?`, optional): Decoration color.
  /// - [decorationStyle] (`TextDecorationStyle?`, optional): Decoration style.
  /// - [decorationThickness] (`double?`, optional): Decoration thickness.
  /// - [debugLabel] (`String?`, optional): Debug label for text style.
  /// - [fontFamily] (`String?`, optional): Font family name.
  /// - [fontFamilyFallback] (`List<String>?`, optional): Fallback font families.
  /// - [package] (`String?`, optional): Package containing the font.
  /// - [overflow] (`TextOverflow?`, optional): How to handle text overflow.
  ///
  /// Returns: `Widget` — the modified text widget.
  Widget call({
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  });
}

/// Extension providing text styling modifiers for widgets.
///
/// This extension adds a fluent API for applying text styles to widgets.
/// Each property returns a [TextModifier] that can be further chained.
///
/// Example:
/// ```dart
/// Text('Hello').sans.large.bold.muted
/// ```
extension TextExtension on Widget {
  /// Applies sans-serif font family.
  TextModifier get sans => WrappedText(
        style: (context, theme) => theme.typography.sans,
        child: this,
      );

  /// Applies monospace font family.
  TextModifier get mono => WrappedText(
        style: (context, theme) => theme.typography.mono,
        child: this,
      );

  /// Applies extra-small font size.
  TextModifier get xSmall => WrappedText(
        style: (context, theme) => theme.typography.xSmall,
        child: this,
      );

  /// Applies small font size.
  TextModifier get small => WrappedText(
        style: (context, theme) => theme.typography.small,
        child: this,
      );

  /// Applies base (default) font size.
  TextModifier get base => WrappedText(
        style: (context, theme) => theme.typography.base,
        child: this,
      );

  /// Applies large font size.
  TextModifier get large => WrappedText(
        style: (context, theme) => theme.typography.large,
        child: this,
      );

  /// Applies extra-large font size.
  TextModifier get xLarge => WrappedText(
        style: (context, theme) => theme.typography.xLarge,
        child: this,
      );

  /// Applies 2x large font size.
  TextModifier get x2Large => WrappedText(
        style: (context, theme) => theme.typography.x2Large,
        child: this,
      );

  /// Applies 3x large font size.
  TextModifier get x3Large => WrappedText(
        style: (context, theme) => theme.typography.x3Large,
        child: this,
      );

  /// Applies 4x large font size.
  TextModifier get x4Large => WrappedText(
        style: (context, theme) => theme.typography.x4Large,
        child: this,
      );

  /// Applies 5x large font size.
  TextModifier get x5Large => WrappedText(
        style: (context, theme) => theme.typography.x5Large,
        child: this,
      );

  /// Applies 6x large font size.
  TextModifier get x6Large => WrappedText(
        style: (context, theme) => theme.typography.x6Large,
        child: this,
      );

  /// Applies 7x large font size.
  TextModifier get x7Large => WrappedText(
        style: (context, theme) => theme.typography.x7Large,
        child: this,
      );

  /// Applies 8x large font size.
  TextModifier get x8Large => WrappedText(
        style: (context, theme) => theme.typography.x8Large,
        child: this,
      );

  /// Applies 9x large font size.
  TextModifier get x9Large => WrappedText(
        style: (context, theme) => theme.typography.x9Large,
        child: this,
      );

  /// Applies thin font weight (100).
  TextModifier get thin => WrappedText(
        style: (context, theme) => theme.typography.thin,
        child: this,
      );

  /// Applies extra-light font weight (200).
  TextModifier get extraLight => WrappedText(
        style: (context, theme) => theme.typography.extraLight,
        child: this,
      );

  /// Applies light font weight (300).
  TextModifier get light => WrappedText(
        style: (context, theme) => theme.typography.light,
        child: this,
      );

  /// Applies normal font weight (400).
  TextModifier get normal => WrappedText(
        style: (context, theme) => theme.typography.normal,
        child: this,
      );

  /// Applies medium font weight (500).
  TextModifier get medium => WrappedText(
        style: (context, theme) => theme.typography.medium,
        child: this,
      );

  /// Applies semi-bold font weight (600).
  TextModifier get semiBold => WrappedText(
        style: (context, theme) => theme.typography.semiBold,
        child: this,
      );

  /// Applies bold font weight (700).
  TextModifier get bold => WrappedText(
        style: (context, theme) => theme.typography.bold,
        child: this,
      );

  /// Applies extra-bold font weight (800).
  TextModifier get extraBold => WrappedText(
        style: (context, theme) => theme.typography.extraBold,
        child: this,
      );

  /// Applies black font weight (900).
  TextModifier get black => WrappedText(
        style: (context, theme) => theme.typography.black,
        child: this,
      );

  /// Applies italic font style.
  TextModifier get italic => WrappedText(
        style: (context, theme) => theme.typography.italic,
        child: this,
      );

  /// Applies underline text decoration.
  TextModifier get underline => WrappedText(
        style: (context, theme) => const TextStyle(
          decoration: TextDecoration.underline,
        ),
        child: this,
      );

  /// Applies muted foreground color.
  TextModifier get muted => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.mutedForeground,
        ),
        child: this,
      );

  /// Applies primary foreground color.
  TextModifier get primaryForeground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.primaryForeground,
        ),
        child: this,
      );

  /// Applies secondary foreground color.
  TextModifier get secondaryForeground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.secondaryForeground,
        ),
        child: this,
      );

  /// Applies heading 1 style.
  TextModifier get h1 => WrappedText(
        style: (context, theme) => theme.typography.h1,
        child: this,
      );

  /// Applies heading 2 style with bottom border.
  TextModifier get h2 => WrappedText(
        style: (context, theme) => theme.typography.h2,
        wrapper: (context, child) => Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.border,
                width: 1,
              ),
            ),
          ),
          child: child,
        ),
        child: this,
      );

  /// Applies heading 3 style.
  TextModifier get h3 => WrappedText(
        style: (context, theme) => theme.typography.h3,
        child: this,
      );

  /// Applies heading 4 style.
  TextModifier get h4 => WrappedText(
        style: (context, theme) => theme.typography.h4,
        child: this,
      );

  /// Applies paragraph style with top spacing.
  TextModifier get p => WrappedText(
        style: (context, theme) => theme.typography.p,
        child: this,
        wrapper: (context, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: child,
          );
        },
      );

  /// Applies paragraph style for the first paragraph (no top spacing).
  TextModifier get firstP => WrappedText(
        style: (context, theme) => theme.typography.p,
        child: this,
      );

  /// Applies block quote style with left border.
  TextModifier get blockQuote => WrappedText(
        style: (context, theme) => theme.typography.blockQuote,
        wrapper: (context, child) => Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).colorScheme.border,
                width: 2,
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 16),
          child: child,
        ),
        child: this,
      );

  /// Applies list item style with bullet point.
  ///
  /// Automatically adds a bullet point and indents nested list items.
  TextModifier get li => WrappedText(
        wrapper: (context, child) {
          UnorderedListData? data = Data.maybeOf(context);
          int depth = data?.depth ?? 0;
          TextStyle style = DefaultTextStyle.of(context).style;
          double size = (style.fontSize ?? 12) / 16 * 6;
          return IntrinsicWidth(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ((style.fontSize ?? 12) * (style.height ?? 1)) * 1.2,
                  child: getBullet(context, depth, size),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Data.inherit(
                      data: UnorderedListData(depth: depth + 1), child: child),
                ),
              ],
            ),
          );
        },
        child: this,
      );

  /// Applies inline code style with background and padding.
  TextModifier get inlineCode => WrappedText(
        style: (context, theme) => theme.typography.inlineCode,
        wrapper: (context, child) {
          final style = DefaultTextStyle.of(context).style;
          final double paddingVertical = style.fontSize! * 0.2;
          final double paddingHorizontal = style.fontSize! * 0.3;
          final ThemeData themeData = Theme.of(context);
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.muted,
              borderRadius: BorderRadius.circular(themeData.radiusSm),
            ),
            child: child,
          );
        },
        child: this,
      );

  /// Applies lead paragraph style with muted color.
  TextModifier get lead => WrappedText(
        style: (context, theme) => theme.typography.lead,
        child: this,
      ).muted;

  /// Applies large text style.
  TextModifier get textLarge => WrappedText(
        style: (context, theme) => theme.typography.textLarge,
        child: this,
      );

  /// Applies small text style.
  TextModifier get textSmall => WrappedText(
        style: (context, theme) => theme.typography.textSmall,
        child: this,
      );

  /// Applies muted text style with muted color.
  TextModifier get textMuted => WrappedText(
        style: (context, theme) => theme.typography.textMuted,
        child: this,
      ).muted;

  /// Constrains text to a single line without wrapping.
  TextModifier get singleLine => WrappedText(
        softWrap: (context, theme) => false,
        maxLines: (context, theme) => 1,
        child: this,
      );

  /// Applies ellipsis overflow to text.
  TextModifier get ellipsis => WrappedText(
        overflow: (context, theme) => TextOverflow.ellipsis,
        child: this,
      );

  /// Centers text horizontally.
  TextModifier get textCenter => WrappedText(
        textAlign: (context, theme) => TextAlign.center,
        child: this,
      );

  /// Right-aligns text.
  TextModifier get textRight => WrappedText(
        textAlign: (context, theme) => TextAlign.right,
        child: this,
      );

  /// Left-aligns text.
  TextModifier get textLeft => WrappedText(
        textAlign: (context, theme) => TextAlign.left,
        child: this,
      );

  /// Justifies text alignment.
  TextModifier get textJustify => WrappedText(
        textAlign: (context, theme) => TextAlign.justify,
        child: this,
      );

  /// Aligns text to the start (left in LTR, right in RTL).
  TextModifier get textStart => WrappedText(
        textAlign: (context, theme) => TextAlign.start,
        child: this,
      );

  /// Aligns text to the end (right in LTR, left in RTL).
  TextModifier get textEnd => WrappedText(
        textAlign: (context, theme) => TextAlign.end,
        child: this,
      );

  /// Applies primary foreground color modifier.
  TextModifier get modify => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.primaryForeground,
        ),
        child: this,
      );

  /// Applies standard foreground color.
  TextModifier get foreground => WrappedText(
        style: (context, theme) => TextStyle(
          color: theme.colorScheme.foreground,
        ),
        child: this,
      );

  /// Appends an inline span to the current text widget.
  ///
  /// Allows chaining multiple text spans together. Works with [Text],
  /// [SelectableText], and [RichText] widgets.
  ///
  /// Parameters:
  /// - [span] (`InlineSpan`, required): The span to append.
  ///
  /// Returns: `Widget` — a rich text widget with the appended span.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello ').then(TextSpan(text: 'World'))
  /// ```
  Widget then(InlineSpan span) {
    if (this is RichText) {
      final text = this as RichText;
      return _RichTextThenWidget(text: text, then: [span]);
    }
    if (this is SelectableText) {
      final text = this as SelectableText;
      return _SelectableTextThenWidget(text: text, then: [span]);
    }
    if (this is Text) {
      final text = this as Text;
      return _TextThenWidget(text: text, then: [span]);
    }
    if (this is _RichTextThenWidget) {
      final text = this as _RichTextThenWidget;
      return _RichTextThenWidget(
        text: text.text,
        then: [...text.then, span],
      );
    }
    if (this is _TextThenWidget) {
      final text = this as _TextThenWidget;
      return _TextThenWidget(
        text: text.text,
        then: [...text.then, span],
      );
    }
    if (this is _SelectableTextThenWidget) {
      final text = this as _SelectableTextThenWidget;
      return _SelectableTextThenWidget(
        text: text.text,
        then: [...text.then, span],
      );
    }
    throw Exception(
      'then() can only be used on Text, SelectableText, or RichText widgets.',
    );
  }
}

typedef WrappedTextDataBuilder<T> = T Function(
    BuildContext context, ThemeData theme);
typedef WidgetTextWrapper = Widget Function(BuildContext context, Widget child);

class WrappedText extends TextModifier {
  final WrappedTextDataBuilder<TextStyle>? style;
  final WrappedTextDataBuilder<TextAlign>? textAlign;
  final WrappedTextDataBuilder<bool>? softWrap;
  final WrappedTextDataBuilder<TextOverflow>? overflow;
  final WrappedTextDataBuilder<int>? maxLines;
  final WrappedTextDataBuilder<TextWidthBasis>? textWidthBasis;
  final WidgetTextWrapper? wrapper;
  final Widget child;

  const WrappedText({
    super.key,
    this.style,
    this.textAlign,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.textWidthBasis,
    this.wrapper,
    required this.child,
  });

  @override
  Widget call({
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    return copyWithStyle(
      (context, theme) => TextStyle(
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        package: package,
        overflow: overflow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle.merge(
      child: wrapper?.call(context, child) ?? child,
      style: style?.call(context, theme),
      textAlign: textAlign?.call(context, theme),
      softWrap: softWrap?.call(context, theme),
      overflow: overflow?.call(context, theme),
      maxLines: maxLines?.call(context, theme),
      textWidthBasis: textWidthBasis?.call(context, theme),
    );
  }

  /// Creates a copy of this [WrappedText] with modified properties.
  ///
  /// Each parameter is a builder function that, if provided, will
  /// replace the corresponding property in the new instance.
  /// If a parameter is `null`, the existing property value is retained.
  ///
  /// Parameters:
  /// - [style] (`ValueGetter<WrappedTextDataBuilder<TextStyle>?>?`, optional): New style builder.
  /// - [textAlign] (`ValueGetter<WrappedTextDataBuilder<TextAlign>?>?`, optional): New text alignment builder.
  /// - [softWrap] (`ValueGetter<WrappedTextDataBuilder<bool>?>?`, optional): New soft wrap builder.
  /// - [overflow] (`ValueGetter<WrappedTextDataBuilder<TextOverflow>?>?`, optional): New overflow handling builder.
  /// - [maxLines] (`ValueGetter<WrappedTextDataBuilder<int>?>?`, optional): New max lines builder.
  /// - [textWidthBasis] (`ValueGetter<WrappedTextDataBuilder<TextWidthBasis>?>?`, optional): New text width basis builder.
  /// - [wrapper] (`ValueGetter<WidgetTextWrapper?>?`, optional): New container wrapper function.
  /// - [child] (`ValueGetter<Widget>?`, optional): New child widget.
  WrappedText copyWith({
    ValueGetter<WrappedTextDataBuilder<TextStyle>?>? style,
    ValueGetter<WrappedTextDataBuilder<TextAlign>?>? textAlign,
    ValueGetter<WrappedTextDataBuilder<bool>?>? softWrap,
    ValueGetter<WrappedTextDataBuilder<TextOverflow>?>? overflow,
    ValueGetter<WrappedTextDataBuilder<int>?>? maxLines,
    ValueGetter<WrappedTextDataBuilder<TextWidthBasis>?>? textWidthBasis,
    ValueGetter<WidgetTextWrapper?>? wrapper,
    ValueGetter<Widget>? child,
  }) {
    return WrappedText(
      wrapper: wrapper == null ? this.wrapper : wrapper(),
      style: style == null ? this.style : style(),
      textAlign: textAlign == null ? this.textAlign : textAlign(),
      softWrap: softWrap == null ? this.softWrap : softWrap(),
      overflow: overflow == null ? this.overflow : overflow(),
      maxLines: maxLines == null ? this.maxLines : maxLines(),
      textWidthBasis:
          textWidthBasis == null ? this.textWidthBasis : textWidthBasis(),
      child: child == null ? this.child : child(),
    );
  }

  /// Creates a copy of this [WrappedText] with an updated style.
  ///
  /// The provided [style] builder is merged with the existing style.
  ///
  /// Parameters:
  /// - [style] (`WrappedTextDataBuilder<TextStyle>`, required): New style builder to merge.
  WrappedText copyWithStyle(WrappedTextDataBuilder<TextStyle> style) {
    return WrappedText(
      wrapper: wrapper,
      style: (context, theme) =>
          style(context, theme).merge(this.style?.call(context, theme)),
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: child,
    );
  }
}

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

class UnorderedListData {
  final int depth;

  /// Creates an [UnorderedListData].
  const UnorderedListData({this.depth = 0});
}

Widget getBullet(BuildContext context, int depth, double size) {
  return CustomPaint(
    size: Size(size, size),
    painter: _BulletPainter(
      color: DefaultTextStyle.of(context).style.color,
      depth: depth,
    ),
  );
}

class _BulletPainter extends CustomPainter {
  final Color? color;
  final int depth;

  _BulletPainter({required this.color, required this.depth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? const Color(0xFF000000)
      ..style = PaintingStyle.fill;
    if (depth % 3 == 0) {
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), size.width / 2, paint);
    } else if (depth % 3 == 1) {
      canvas.drawRect(Offset(0, 0) & size, paint);
    } else {
      final path = Path();
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BulletPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.depth != depth;
  }
}
