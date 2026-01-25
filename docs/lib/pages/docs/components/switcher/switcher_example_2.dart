import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../../../ui/shadcn/components/navigation/switcher/switcher.dart'
    as shadcn_switcher;
import '../../../../ui/shadcn/components/display/text/text.dart';

const ComponentExample switcherExample2 = ComponentExample(
  title: 'Form switch',
  builder: _buildSwitcherExample2,
  code: '''Switcher(
  index: isRegister ? 1 : 0,
  children: [loginForm, registerForm],
)''',
);

Widget _buildSwitcherExample2(BuildContext context) {
  return const _SwitcherExample2();
}

class _SwitcherExample2 extends StatefulWidget {
  const _SwitcherExample2();

  @override
  State<_SwitcherExample2> createState() => _SwitcherExample2State();
}

class _SwitcherExample2State extends State<_SwitcherExample2> {
  bool _isRegister = false;
  final _registerController = shadcn_form.FormController();
  final _loginController = shadcn_form.FormController();

  @override
  Widget build(BuildContext context) {
    return shadcn_switcher.Switcher(
      index: _isRegister ? 1 : 0,
      onIndexChanged: (index) {
        setState(() {
          _isRegister = index == 1;
        });
      },
      direction: AxisDirection.left,
      children: [
        Container(
          key: const Key('login'),
          width: 350,
          padding: const EdgeInsets.all(16),
          child: shadcn_form.Form(
            controller: _loginController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                shadcn_form.FormField<String>(
                  key: const shadcn_form.TextFieldKey(#email),
                  label: const Text('Email'),
                  validator: const shadcn_form.EmailValidator() &
                      const shadcn_form.NotEmptyValidator(),
                  showErrors: const {
                    shadcn_form.FormValidationMode.changed,
                    shadcn_form.FormValidationMode.submitted,
                  },
                  child: shadcn_text_field.TextField(
                    initialValue: _loginController
                        .getValue(const shadcn_form.TextFieldKey(#email)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
                const SizedBox(height: 16),
                const shadcn_form.FormField<String>(
                  key: shadcn_form.TextFieldKey(#password),
                  label: Text('Password'),
                  validator: shadcn_form.NotEmptyValidator(),
                  showErrors: {
                    shadcn_form.FormValidationMode.changed,
                    shadcn_form.FormValidationMode.submitted,
                  },
                  child: shadcn_text_field.TextField(obscureText: true),
                ),
                const SizedBox(height: 16),
                const shadcn_form.SubmitButton(
                  child: Text('Login'),
                ),
                const SizedBox(height: 16),
                const Text("Don't have an account? ").thenButton(
                  onPressed: () {
                    setState(() {
                      _isRegister = true;
                    });
                  },
                  child: const Text('Sign Up!'),
                ),
              ],
            ),
          ),
        ),
        Container(
          key: const Key('register-form'),
          width: 350,
          padding: const EdgeInsets.all(16),
          child: shadcn_form.Form(
            controller: _registerController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                shadcn_form.FormField<String>(
                  key: const shadcn_form.TextFieldKey(#email),
                  label: const Text('Email'),
                  validator: const shadcn_form.EmailValidator() &
                      const shadcn_form.NotEmptyValidator(),
                  showErrors: const {
                    shadcn_form.FormValidationMode.changed,
                    shadcn_form.FormValidationMode.submitted,
                  },
                  child: shadcn_text_field.TextField(
                    initialValue: _registerController
                        .getValue(const shadcn_form.TextFieldKey(#email)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
                const SizedBox(height: 16),
                const shadcn_form.FormField<String>(
                  key: shadcn_form.TextFieldKey(#password),
                  label: Text('Password'),
                  validator: shadcn_form.LengthValidator(
                    min: 6,
                    message: 'Password must be at least 6 characters',
                  ),
                  showErrors: {
                    shadcn_form.FormValidationMode.changed,
                    shadcn_form.FormValidationMode.submitted,
                  },
                  child: shadcn_text_field.TextField(obscureText: true),
                ),
                const SizedBox(height: 16),
                const shadcn_form.FormField<String>(
                  key: shadcn_form.TextFieldKey(#confirmPassword),
                  label: Text('Confirm Password'),
                  validator: shadcn_form.CompareWith.equal(
                    shadcn_form.TextFieldKey(#password),
                    message: 'Passwords do not match',
                  ),
                  showErrors: {
                    shadcn_form.FormValidationMode.changed,
                    shadcn_form.FormValidationMode.submitted,
                  },
                  child: shadcn_text_field.TextField(obscureText: true),
                ),
                const SizedBox(height: 16),
                const shadcn_form.SubmitButton(
                  child: Text('Register'),
                ),
                const SizedBox(height: 16),
                const Text('Already have an account? ').thenButton(
                  onPressed: () {
                    setState(() {
                      _isRegister = false;
                    });
                  },
                  child: const Text('Login!'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
