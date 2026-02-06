part of '../../preview.dart';

class _CheckboxPreviewState extends State<CheckboxPreview> {
  CheckboxState uncheckedState = CheckboxState.unchecked;
  CheckboxState checkedState = CheckboxState.checked;
  CheckboxState indeterminateState = CheckboxState.indeterminate;
  CheckboxState disabledState = CheckboxState.unchecked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                // Unchecked
                Checkbox(
                  state: uncheckedState,
                  onChanged: (value) {
                    setState(() => uncheckedState = value);
                  },
                  trailing: const Text('Unchecked'),
                ),
                // Checked
                Checkbox(
                  state: checkedState,
                  onChanged: (value) {
                    setState(() => checkedState = value);
                  },
                  trailing: const Text('Checked'),
                ),
                // Indeterminate
                Checkbox(
                  state: indeterminateState,
                  onChanged: (value) {
                    setState(() => indeterminateState = value);
                  },
                  trailing: const Text('Indeterminate'),
                ),
                // Disabled
                Checkbox(
                  state: disabledState,
                  onChanged: null,
                  trailing: const Text('Disabled'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
