part of '../../chat.dart';

/// Internal helper class used by the chat component implementation.
class _ChatTailBehavior implements TailBehavior {
  final bool Function(ChatBubbleData data) shouldHaveTail;
  const _ChatTailBehavior(this.shouldHaveTail);

  /// Implements `wrapWithTail` behavior for chat.
  @override
  bool wrapWithTail(ChatBubbleData data) {
    return shouldHaveTail(data);
  }
}
