part of '../../chat.dart';

/// Data associated with a [ChatBubble] within a [ChatGroup].
class ChatBubbleData {
  /// The index of the bubble in the group.
  final int index;

  /// The total number of bubbles in the group.
  final int length;

  /// Creates a [ChatBubbleData].
  ///
  /// Parameters:
  /// - [index] (`int`, required): The index of the bubble in the group.
  /// - [length] (`int`, required): The total number of bubbles in the group.
  const ChatBubbleData({
    required this.index,
    required this.length,
  });

  /// Creates a copy of this data with the given fields replaced with the new values.
  ///
  /// Parameters:
  /// - [index] (`int?`, optional): New index value.
  /// - [length] (`int?`, optional): New length value.
  ///
  /// Returns:
  /// A new [ChatBubbleData] with the specified values updated.
  ChatBubbleData copyWith({
    int? index,
    int? length,
  }) {
    return ChatBubbleData(
      index: index ?? this.index,
      length: length ?? this.length,
    );
  }

  @override
  String toString() {
    return 'ChatBubbleData(index: $index, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatBubbleData &&
        other.index == index &&
        other.length == length;
  }

  @override
  int get hashCode {
    return Object.hash(index, length);
  }
}
