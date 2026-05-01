import 'package:flutter/material.dart';

import '../avatar/avatar.dart';
import '../chat/chat.dart';
import '../../../shared/utils/axis.dart';

/// Core class used by the chat component.
class ChatPreview extends StatelessWidget {
  const ChatPreview({super.key});

  /// Builds the widget tree for chat.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatGroup(
              color: Colors.blue,
              type: ChatBubbleType.tail,
              alignment: AxisAlignmentDirectional.end,
              children: const [
                ChatBubble(child: Text('Did you remember the meeting time?')),

                ChatBubble(child: Text('Please reply ASAP.')),
              ],
            ),

            const SizedBox(height: 12),

            ChatGroup(
              color: Colors.grey,
              avatarPrefix: const Avatar(initials: 'JO'),
              type: ChatBubbleType.tail,
              alignment: AxisAlignmentDirectional.start,
              children: const [
                ChatBubble(child: Text('Around 6 or 7?')),

                ChatBubble(child: Text('New phone who dis?')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
