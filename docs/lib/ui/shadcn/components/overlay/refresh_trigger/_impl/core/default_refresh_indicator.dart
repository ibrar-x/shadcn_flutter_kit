part of '../../refresh_trigger.dart';

class DefaultRefreshIndicator extends StatefulWidget {
  /// Current refresh trigger stage.
  final RefreshTriggerStage stage;

  /// Creates a default refresh indicator.
  const DefaultRefreshIndicator({super.key, required this.stage});

  @override
  State<DefaultRefreshIndicator> createState() =>
      _DefaultRefreshIndicatorState();
}
