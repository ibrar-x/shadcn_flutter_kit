# Chat

Rich chat bubble system with groups, tails, and bubble theming. Wraps bubbles in `ComponentTheme<ChatTheme>` and `ChatGroupTheme` so you can customize spacing, colors, and tail placement while reusing the shared `WidgetStatesController` helpers.

## Features

- Bubble/group theming plus avatar alignment helpers (`ChatGroup`, `ChatBubble`, `ChatTheme`, `ChatGroupTheme`).
- Multiple bubble shapes (`ChatBubbleType.tail`, `.plain`, `.sharpCorner`) and tail placement behaviors.
- Built-in `ChatTailTheme` that animates tails based on bubble position.
- Uses `Gap`/`Basic` plus `OutlinedContainer` for the image/text layout typical of chat UIs.

## Example

```dart
ChatGroup(
  avatarPrefix: Avatar(child: Text('A')),
  children: [
    ChatBubble(
      child: Text('Hello!'),
      bubbleTheme: ChatTheme(
        color: Colors.blue,
        alignment: AxisAlignment.start,
      ),
    ),
    ChatBubble(
      child: Text('How are you?'),
      bubbleTheme: ChatTheme(
        color: Colors.white,
        alignment: AxisAlignment.end,
      ),
    ),
  ],
);
```
