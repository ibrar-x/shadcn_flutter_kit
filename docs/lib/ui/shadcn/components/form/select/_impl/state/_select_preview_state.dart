part of '../../preview.dart';

class _SelectPreviewState extends State<SelectPreview> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 300,
              child: Select<String>(
                itemBuilder: (context, item) {
                  return Text(item);
                },
                popupConstraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 300,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                value: selectedValue,
                placeholder: const Text('Select a fruit'),
                popup: const SelectPopup(
                  items: SelectItemList(
                    children: [
                      SelectItemButton(
                        value: 'Apple',
                        child: Text('Apple'),
                      ),
                      SelectItemButton(
                        value: 'Banana',
                        child: Text('Banana'),
                      ),
                      SelectItemButton(
                        value: 'Cherry',
                        child: Text('Cherry'),
                      ),
                      SelectItemButton(
                        value: 'Date',
                        child: Text('Date'),
                      ),
                      SelectItemButton(
                        value: 'Grape',
                        child: Text('Grape'),
                      ),
                    ],
                  ),
                ).call,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
