# Resizable

Resizable panels with draggable dividers.

## Usage
```dart
ResizablePanel.horizontal(
  children: [
    ResizablePane(
      defaultSize: 200,
      child: Text('Sidebar'),
    ),
    ResizablePane(
      flex: 1,
      child: Text('Content'),
    ),
  ],
)
```
