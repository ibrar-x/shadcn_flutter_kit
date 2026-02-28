part of '../../chip_input.dart';

/// _ChipProvider represents a form-related type in the registry.
abstract class _ChipProvider<T> {
  Widget? buildChip(BuildContext context, T chip);
}
