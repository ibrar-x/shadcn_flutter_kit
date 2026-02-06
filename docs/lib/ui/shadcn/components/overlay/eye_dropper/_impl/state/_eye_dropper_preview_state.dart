part of '../../preview.dart';

class _EyeDropperPreviewState extends State<EyeDropperPreview> {
  Color? _picked;

  @override
  Widget build(BuildContext context) {
    return EyeDropperLayer(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  color: _picked ?? Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black12),
                ),
              ),
              const SizedBox(height: 12),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      final scope = EyeDropperLayerScope.find(context);
                      final color = await scope.promptPickColor();
                      if (!mounted) return;
                      setState(() {
                        _picked = color;
                      });
                    },
                    child: const Text('Pick color'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
