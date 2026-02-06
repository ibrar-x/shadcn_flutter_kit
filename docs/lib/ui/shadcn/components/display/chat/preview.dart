import 'package:flutter/material.dart';

import '../avatar/avatar.dart';
import '../chat/chat.dart';
import '../../../shared/utils/axis.dart';

class ChatPreview extends StatelessWidget {
  const ChatPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatGroup(
              color: Colors.blue,
              type: ChatBubbleType.tail,
              alignment: AxisAlignmentDirectional.end,
              children: [
                ChatBubble(
                  child: Text('Did you remember the meeting time?'),
                ),
                ChatBubble(child: Text('Please reply ASAP.')),
              ],
            ),
            SizedBox(height: 12),
            ChatGroup(
              color: Colors.grey,
              avatarPrefix: Avatar(initials: 'JO'),
              type: ChatBubbleType.tail,
              alignment: AxisAlignmentDirectional.start,
              children: [
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
