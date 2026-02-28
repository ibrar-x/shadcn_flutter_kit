# Getting Started

`chat` is a registry component in category `display`.

Chat bubbles, groups, and tail helpers for conversational layouts.

## Folder Map

- `README.md`: Primary component docs and usage guidance for contributors/users.
- `chat.dart`: Widget/composite source file in this folder.
- `chat.meta.json`: Generated readme/meta companion used by docs/index tooling.
- `meta.json`: Registry metadata used for manifests, dependencies, and tooling.
- `preview.dart`: Preview/demo entry used by gallery/docs environments.
- `_impl/`: Private implementation details that support `chat`.

## `_impl` Guide

### `core/`
Core rendering/building blocks that implement the main behavior.

- `_chat_tail_behavior.dart`: Core implementation part of the widget/composite.
- `_tail_painter.dart`: Core implementation part of the widget/composite.
- `chat_bubble.dart`: Core implementation part of the widget/composite.
- `chat_bubble_corner.dart`: Core implementation part of the widget/composite.
- `chat_bubble_corner_directional.dart`: Core implementation part of the widget/composite.
- `chat_bubble_data.dart`: Core implementation part of the widget/composite.
- `chat_bubble_type.dart`: Core implementation part of the widget/composite.
- `chat_group.dart`: Core implementation part of the widget/composite.
- `chat_group_theme.dart`: Theme model/helpers for styling resolution.
- `chat_tail_theme.dart`: Theme model/helpers for styling resolution.
- `chat_theme.dart`: Theme model/helpers for styling resolution.
- `plain_chat_bubble_type.dart`: Core implementation part of the widget/composite.
- `render_chat_constrained_box.dart`: Core implementation part of the widget/composite.
- `sharp_corner_chat_bubble_type.dart`: Core implementation part of the widget/composite.
- `tail_behavior.dart`: Core implementation part of the widget/composite.
- `tail_chat_bubble_type.dart`: Core implementation part of the widget/composite.

### `extensions/`
Extension methods used by this widget.

- (empty)

### `state/`
State objects, controllers, and mutable interaction logic.

- (empty)

### `styles/`
Style classes and style-resolution helpers.

- (empty)

### `themes/`
Theme data and ThemeExtension integration.

- (empty)

### `utils/`
Small reusable helper functions/models.

- (empty)

### `variants/`
Alternative visual or behavior variants.

- (empty)

## Suggested Reading Order

1. `README.md`
2. `meta.json`
3. `chat.dart`
4. `preview.dart`
5. `_impl/core/`
6. `_impl/state/`
7. `_impl/styles/`
8. `_impl/themes/`
9. `_impl/variants/`
10. `_impl/utils/`
11. `_impl/extensions/`
