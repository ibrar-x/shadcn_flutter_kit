// ErrorMapper + RuleBasedErrorMapper: converts any thrown error into an AppError.
// RuleBasedErrorMapper tries rules in priority order and falls back to a default mapping.

import 'app_error.dart';
import 'error_rule.dart';

abstract class ErrorMapper {
  AppError map(Object error, [StackTrace? stackTrace]);
}

class RuleBasedErrorMapper implements ErrorMapper {
  RuleBasedErrorMapper({required List<ErrorRule> rules, required this.fallback})
    : rules = _sortByPriority(rules);

  final List<ErrorRule> rules;
  final AppError Function(Object error, StackTrace? stackTrace) fallback;

  static List<ErrorRule> _sortByPriority(List<ErrorRule> rules) {
    final sorted = List<ErrorRule>.from(rules);
    sorted.sort((a, b) => b.priority.compareTo(a.priority));
    return sorted;
  }

  @override
  AppError map(Object error, [StackTrace? stackTrace]) {
    for (final rule in rules) {
      if (rule.matches(error, stackTrace)) {
        return rule.build(error, stackTrace);
      }
    }
    return fallback(error, stackTrace);
  }
}
