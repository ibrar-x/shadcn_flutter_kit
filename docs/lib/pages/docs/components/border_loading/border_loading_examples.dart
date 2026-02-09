import '../../component_example_models.dart';
import 'border_loading_example_progress.dart';
import 'border_loading_example_stream.dart';
import 'border_loading_example_sweep.dart';
import 'border_loading_example_tracer.dart';

const bool enableBorderLoadingStreamExamples = bool.fromEnvironment(
  'ENABLE_BORDER_LOADING_STREAM_EXAMPLES',
  defaultValue: true,
);

final List<ComponentExample> borderLoadingExamples = [
  borderLoadingSweepExample,
  borderLoadingTracerExample,
  borderLoadingProgressExample,
  if (enableBorderLoadingStreamExamples) borderLoadingStreamExample,
];
