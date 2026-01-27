part of 'chip_input.dart';

abstract class _ChipProvider<T> {
  Widget? buildChip(BuildContext context, T chip);
}
