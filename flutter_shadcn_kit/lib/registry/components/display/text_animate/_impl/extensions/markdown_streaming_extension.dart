import 'package:flutter/widgets.dart';

import '../../../markdown/markdown.dart' as md;
import '../../text_animate.dart';

extension MarkdownStreamingExtension on md.Markdown {
  Widget withTextStreaming({
    TypewriterEffect typewriter = const TypewriterEffect(enabled: false),
    StreamingTextEffectAdapter effect = const FadeInEffect(
      duration: Duration(milliseconds: 220),
    ),
    StreamingCursor cursor = const StreamingCursor.none(),
    bool animateByWord = false,
  }) {
    if (sourceType != md.MarkdownSourceType.text) {
      throw StateError(
        'withTextStreaming currently supports Markdown(data: ...) only. '
        'Resolve asset/file content first, then stream the text value.',
      );
    }
    return _StreamingMarkdownAdapter(
      source: this,
      typewriter: typewriter,
      effect: effect,
      cursor: cursor,
      animateByWord: animateByWord,
    );
  }
}

class _StreamingMarkdownAdapter extends StatefulWidget {
  const _StreamingMarkdownAdapter({
    required this.source,
    required this.typewriter,
    required this.effect,
    required this.cursor,
    required this.animateByWord,
  });

  final md.Markdown source;
  final TypewriterEffect typewriter;
  final StreamingTextEffectAdapter effect;
  final StreamingCursor cursor;
  final bool animateByWord;

  @override
  State<_StreamingMarkdownAdapter> createState() =>
      _StreamingMarkdownAdapterState();
}

class _StreamingMarkdownAdapterState extends State<_StreamingMarkdownAdapter> {
  String _sourceSnapshot = '';
  String _committedMarkdown = '';
  String _streamingRawTail = '';
  String _streamingPlainTail = '';

  @override
  void initState() {
    super.initState();
    _applyIncoming(widget.source.data, forceReset: true);
  }

  @override
  void didUpdateWidget(covariant _StreamingMarkdownAdapter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.data != widget.source.data) {
      _applyIncoming(widget.source.data, forceReset: false);
    }
  }

  void _applyIncoming(String next, {required bool forceReset}) {
    if (forceReset ||
        _sourceSnapshot.isEmpty ||
        !next.startsWith(_sourceSnapshot)) {
      _sourceSnapshot = next;
      _committedMarkdown = '';
      _streamingRawTail = next;
      _streamingPlainTail = _markdownToPlainText(next);
      return;
    }

    final appended = next.substring(_sourceSnapshot.length);
    _sourceSnapshot = next;
    if (appended.isEmpty) {
      return;
    }
    _streamingRawTail = '$_streamingRawTail$appended';
    _streamingPlainTail =
        '$_streamingPlainTail${_markdownToPlainText(appended)}';
  }

  void _onSettled(String _) {
    if (!mounted || _streamingRawTail.isEmpty) {
      return;
    }
    setState(() {
      _committedMarkdown = '$_committedMarkdown$_streamingRawTail';
      _streamingRawTail = '';
      _streamingPlainTail = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (_committedMarkdown.isNotEmpty) {
      children.add(widget.source.copyWith(data: _committedMarkdown));
    }

    if (_streamingPlainTail.isNotEmpty) {
      children.add(
        StreamingText(
          text: _streamingPlainTail,
          typewriter: widget.typewriter,
          effect: widget.effect,
          cursor: widget.cursor,
          animateByWord: widget.animateByWord,
          onSettled: _onSettled,
        ),
      );
    }

    if (children.isEmpty) {
      return widget.source;
    }

    return Column(
      mainAxisSize: widget.source.shrinkWrap
          ? MainAxisSize.min
          : MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  String _markdownToPlainText(String value) {
    var text = value.replaceAll('\r\n', '\n');
    text = text.replaceAll(RegExp(r'```[\\w-]*\n'), '');
    text = text.replaceAll('```', '');
    text = text.replaceAll(RegExp(r'`([^`]+)`'), r'$1');
    text = text.replaceAll(RegExp(r'~~([^~]+)~~'), r'$1');
    text = text.replaceAll(RegExp(r'\*\*([^*]+)\*\*'), r'$1');
    text = text.replaceAll(RegExp(r'\*([^*]+)\*'), r'$1');
    text = text.replaceAll(RegExp(r'!\[([^\]]*)\]\([^\)]+\)'), r'$1');
    text = text.replaceAll(RegExp(r'\[([^\]]+)\]\([^\)]+\)'), r'$1');
    text = text.replaceAll(RegExp(r'^\s*\|(.+)\|\s*$', multiLine: true), r'$1');
    text = text.replaceAll('|', ' ');
    text = text.replaceAll(
      RegExp(r'^[ \\t]{0,3}#{1,6}[ \\t]*', multiLine: true),
      '',
    );
    text = text.replaceAll(RegExp(r'^[ \\t]*>[ \\t]?', multiLine: true), '');
    text = text.replaceAll(
      RegExp(r'^[ \\t]*[-+*][ \\t]+', multiLine: true),
      '• ',
    );
    text = text.replaceAll(
      RegExp(r'^[ \\t]*\\d+\\.[ \\t]+', multiLine: true),
      '',
    );
    return text.trimRight();
  }
}
