import 'package:docs/ui/shadcn/shadcn_ui.dart';

class ItemPickerExample1 extends StatelessWidget {
  const ItemPickerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        // Show a popover item picker (non-dialog) with a virtual list of 1000 items.
        showItemPicker<int>(
          context,
          title: const Text('Pick an item'),
          items: ItemBuilder(
            itemCount: 1000,
            itemBuilder: (index) {
              return index;
            },
          ),
          builder: (context, item) {
            return ItemPickerOption(
                value: item, child: Text(item.toString()).large);
          },
        ).then(
          (value) {
            if (value != null && context.mounted) {
              // Feedback via toast when a selection is made.
              showToast(
                context: context,
                builder: (context) {
                  return SurfaceCard(
                    child: Text('You picked $value!'),
                  );
                },
              );
            } else if (context.mounted) {
              showToast(
                context: context,
                builder: (context) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}
