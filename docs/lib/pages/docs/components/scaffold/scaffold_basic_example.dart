import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/display/divider/divider.dart'
    as shadcn_divider;
import '../../../../ui/shadcn/components/layout/scaffold/scaffold.dart'
    as shadcn_scaffold;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample scaffoldBasicExample = ComponentExample(
  title: 'Example',
  builder: _buildScaffoldBasicExample,
  code: '''Scaffold(
  loadingProgressIndeterminate: true,
  headers: [
    AppBar(
      title: Text('Counter App'),
      subtitle: Text('A simple counter app'),
      leading: [OutlineButton(...)]
      trailing: [OutlineButton(...), OutlineButton(...)],
    ),
    Divider(),
  ],
  child: Center(...),
)''',
);

Widget _buildScaffoldBasicExample(BuildContext context) {
  return const _ScaffoldBasicExample();
}

class _ScaffoldBasicExample extends StatefulWidget {
  const _ScaffoldBasicExample();

  @override
  State<_ScaffoldBasicExample> createState() => _ScaffoldBasicExampleState();
}

class _ScaffoldBasicExampleState extends State<_ScaffoldBasicExample> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_scaffold.Scaffold(
      loadingProgressIndeterminate: true,
      headers: [
        shadcn_scaffold.AppBar(
          title: const Text('Counter App'),
          subtitle: const Text('A simple counter app'),
          leading: [
            shadcn_buttons.OutlineButton(
              onPressed: () {},
              density: shadcn_buttons.ButtonDensity.icon,
              child: const Icon(Icons.menu),
            ),
          ],
          trailing: [
            shadcn_buttons.OutlineButton(
              onPressed: () {},
              density: shadcn_buttons.ButtonDensity.icon,
              child: const Icon(Icons.search),
            ),
            shadcn_buttons.OutlineButton(
              onPressed: () {},
              density: shadcn_buttons.ButtonDensity.icon,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const shadcn_divider.Divider(),
      ],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:')
                .withPadding(all: 16),
            Text('$_counter').h1(),
            shadcn_buttons.PrimaryButton(
              onPressed: _incrementCounter,
              density: shadcn_buttons.ButtonDensity.icon,
              child: const Icon(Icons.add),
            ).withPadding(all: 16),
          ],
        ),
      ),
    );
  }
}
