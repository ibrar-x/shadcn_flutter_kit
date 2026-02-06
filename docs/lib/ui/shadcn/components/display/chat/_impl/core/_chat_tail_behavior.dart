part of '../../chat.dart';

class _ChatTailBehavior implements TailBehavior {
  final bool Function(ChatBubbleData data) shouldHaveTail;
  const _ChatTailBehavior(this.shouldHaveTail);
  @override
  bool wrapWithTail(ChatBubbleData data) {
    return shouldHaveTail(data);
  }
}
