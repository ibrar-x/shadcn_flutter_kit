part of '../../refresh_trigger.dart';

/// DefaultRefreshIndicator defines a reusable type for this registry module.
class DefaultRefreshIndicator extends StatefulWidget {
  /// Current refresh trigger stage.
  final RefreshTriggerStage stage;

  /// Creates a default refresh indicator.
  const DefaultRefreshIndicator({super.key, required this.stage});

  @override
/// Executes `createState` behavior for this component/composite.
  State<DefaultRefreshIndicator> createState() =>
      _DefaultRefreshIndicatorState();
}
