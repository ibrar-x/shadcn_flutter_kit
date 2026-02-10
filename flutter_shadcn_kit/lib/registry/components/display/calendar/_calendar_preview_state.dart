part of 'preview.dart';

class _CalendarPreviewState extends State<CalendarPreview> {
  CalendarValue? _value;
  CalendarView _view = CalendarView.now();

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: shadcn.Card(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    OutlineButton(
                      density: ButtonDensity.icon,
                      onPressed: () {
                        setState(() {
                          _view = _view.previous;
                        });
                      },
                      child: const Icon(Icons.arrow_back).iconXSmall(),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${localizations.getMonth(_view.month)} ${_view.year}',
                        ).small().medium(),
                      ),
                    ),
                    OutlineButton(
                      density: ButtonDensity.icon,
                      onPressed: () {
                        setState(() {
                          _view = _view.next;
                        });
                      },
                      child: const Icon(Icons.arrow_forward).iconXSmall(),
                    ),
                  ],
                ),
                const DensityGap(gapLg),
                Calendar(
                  value: _value,
                  view: _view,
                  selectionMode: CalendarSelectionMode.range,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
