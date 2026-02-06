import 'package:docs/shadcn_ui.dart';
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
            // Preselect a country; phone parsing/formatting adapt accordingly.
            initialCountry: Country.unitedStates,
            onChanged: (value) {
              setState(() {
                _phoneNumber = value;
              });
            },
          ),
          Text(
            _phoneNumber?.value ?? '(No value)',
          ),
        ],
        const Gap(24),
      ).toList(),
    );
  }
}
