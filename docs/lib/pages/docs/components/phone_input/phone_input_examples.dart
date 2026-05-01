import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'phone_input_example_1.dart';

const ComponentExample phoneInputExample1 = ComponentExample(
  title: "Example",
  builder: _buildPhoneInputExample1,
  code: r"""import 'package:docs/shadcn_ui.dart';
import 'package:phonecodes/phonecodes.dart' show Country;

class PhoneInputExample1 extends StatefulWidget {
  const PhoneInputExample1({super.key});

  @override
  State<PhoneInputExample1> createState() => _PhoneInputExample1State();
}

class _PhoneInputExample1State extends State<PhoneInputExample1> {
  PhoneNumber? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: join(
        [
          PhoneInput(
            initialCountry: Country.indonesia,
            onChanged: (value) {
              setState(() {
                _phoneNumber = value;
              });
            },
          ),
          Text(_phoneNumber?.value ?? '(No value)'),
        ],
        const Gap(24),
      ).toList(),
    );
  }
}
""",
);

Widget _buildPhoneInputExample1(BuildContext context) {
  return const PhoneInputExample1();
}

const List<ComponentExample> phoneInputExamples = [
  phoneInputExample1,
];
