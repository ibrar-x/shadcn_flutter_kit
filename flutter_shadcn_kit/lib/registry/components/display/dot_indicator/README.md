# Dot Indicator

Row/column of dots highlighting the current index. Tap dots to change position if `onChanged` is set.

## Usage

```dart
DotIndicator(
  index: activeIndex,
  length: 5,
  onChanged: (value) => pageController.animateToPage(value),
  dotBuilder: (context, index, active) {
    return Container(
      width: active ? 16 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  },
);
```

Use `ComponentTheme<DotIndicatorTheme>` to override spacing, padding, or default colors for the active/inactive dots.
