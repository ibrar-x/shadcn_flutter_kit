// ErrorRegistry: mutable container to compose/extend ErrorRule lists at runtime.
// Useful for app-level setup where features can register their own rules.

import 'error_rule.dart';

/// ErrorRegistry defines a reusable type for this registry module.
class ErrorRegistry {
  ErrorRegistry({List<ErrorRule>? rules}) : _rules = List.of(rules ?? const []);

/// Stores `_rules` state/configuration for this implementation.
  final List<ErrorRule> _rules;

  List<ErrorRule> get rules => List.unmodifiable(_rules);

/// Executes `add` behavior for this component/composite.
  void add(ErrorRule rule) => _rules.add(rule);

/// Executes `addAll` behavior for this component/composite.
  void addAll(Iterable<ErrorRule> rules) => _rules.addAll(rules);

/// Executes `clear` behavior for this component/composite.
  void clear() => _rules.clear();
}
