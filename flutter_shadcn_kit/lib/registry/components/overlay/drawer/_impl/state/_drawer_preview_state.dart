part of '../../preview.dart';

class _DrawerPreviewState extends State<DrawerPreview> {
  // Sequence of positions to cycle through as drawers are stacked.
  List<OverlayPosition> positions = [
    OverlayPosition.end,
    OverlayPosition.bottom,
    OverlayPosition.start,
  ];

  void open(BuildContext context, int count) {
    openDrawer(
      context: context,
      expands: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(48),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Drawer at ${positions[count % positions.length].name}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () {
                    open(context, count + 1);
                  },
                  child: const Text('Open Another Drawer'),
                ),
                const SizedBox(height: 8),
                SecondaryButton(
                  onPressed: () {
                    closeOverlay(context);
                  },
                  child: const Text('Close Drawer'),
                ),
              ],
            ),
          ),
        );
      },
      position: positions[count % positions.length],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrimaryButton(
          onPressed: () {
            open(context, 0);
          },
          child: const Text('Open Drawer'),
        ),
      ),
    );
  }
}
