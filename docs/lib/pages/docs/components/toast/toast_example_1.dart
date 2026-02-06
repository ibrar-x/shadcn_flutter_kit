import 'package:docs/shadcn_ui.dart';

// Demonstrates toast overlays in different screen locations with a custom
// content builder and programmatic close via the overlay handle.

class ToastExample1 extends StatefulWidget {
  const ToastExample1({super.key});

  @override
  State<ToastExample1> createState() => _ToastExample1State();
}

class _ToastExample1State extends State<ToastExample1> {
  // Builder for the toast content.
  Widget buildToast(BuildContext context, ToastOverlay overlay, String message) {
    return SurfaceCard(
      child: Basic(
        title: Text(message),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: PrimaryButton(
          size: ButtonSize.small,
          onPressed: overlay.close,
          child: const Text('Undo'),
        ),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: (context, overlay) =>
                  buildToast(context, overlay, 'Toast triggered: Default'),
            );
          },
          child: const Text('Show Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: (context, overlay) =>
                  buildToast(context, overlay, 'Toast triggered: Long'),
              duration: const Duration(seconds: 6),
            );
          },
          child: const Text('Show Long Toast'),
        ),
      ],
    );
  }
}
