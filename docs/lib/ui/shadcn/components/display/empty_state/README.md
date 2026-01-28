# Empty State

Standardized empty state block for empty, no-results, or error.

## Usage

```dart
EmptyState(
  variant: EmptyStateVariant.noResults,
  size: EmptyStateSize.compact,
  primaryAction: const EmptyStateAction(label: 'Clear filters'),
  secondaryAction: const EmptyStateAction(
    label: 'Try again',
    style: EmptyStateActionStyle.link,
  ),
)
```
