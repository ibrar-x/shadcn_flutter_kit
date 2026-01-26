import 'package:docs/ui/shadcn/shadcn_ui.dart';

class RebuildCounter extends StatefulWidget {
  const RebuildCounter({Key? key}) : super(key: key);

  @override
  State<RebuildCounter> createState() => _RebuildCounterState();
}

class _RebuildCounterState extends State<RebuildCounter> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.primaries[hashCode % Colors.primaries.length],
      child: Center(
        child: Text('Rebuild count: ${counter++}'),
      ),
    );
  }
}
