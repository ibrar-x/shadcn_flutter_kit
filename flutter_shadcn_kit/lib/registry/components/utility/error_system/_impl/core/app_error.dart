import 'error_action.dart';
import 'error_code.dart';

class AppError implements Exception {
  AppError({
    required this.code,
    required this.title,
    required this.message,
    this.actions = const [],
    this.technicalDetails,
    this.metadata,
    DateTime? timestamp,
    this.fingerprint,
  }) : timestamp = timestamp ?? DateTime.now();

  final AppErrorCode code;
  final String title;
  final String message;
  final List<ErrorAction> actions;
  final String? technicalDetails;
  final Map<String, dynamic>? metadata;
  final DateTime timestamp;
  final String? fingerprint;

  bool get hasTechnicalDetails =>
      technicalDetails != null && technicalDetails!.trim().isNotEmpty;

  bool get hasMetadata => metadata != null && metadata!.isNotEmpty;

  bool get hasActions => actions.isNotEmpty;

  AppError copyWithActions(List<ErrorAction> newActions) {
    return AppError(
      code: code,
      title: title,
      message: message,
      actions: newActions,
      technicalDetails: technicalDetails,
      metadata: metadata,
      timestamp: timestamp,
      fingerprint: fingerprint,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code.name,
        'title': title,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
        'fingerprint': fingerprint,
        'metadata': metadata,
      };

  @override
  String toString() =>
      'AppError(code: $code, title: $title, message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppError &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          title == other.title &&
          message == other.message;

  @override
  int get hashCode => code.hashCode ^ title.hashCode ^ message.hashCode;
}
