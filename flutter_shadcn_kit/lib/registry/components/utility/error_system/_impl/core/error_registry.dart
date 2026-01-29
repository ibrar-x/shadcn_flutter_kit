// ErrorRegistry: mutable container to compose/extend ErrorRule lists at runtime.
// Useful for app-level setup where features can register their own rules.

import 'error_rule.dart';

class ErrorRegistry {
  ErrorRegistry({List<ErrorRule>? rules}) : _rules = List.of(rules ?? const []);

  final List<ErrorRule> _rules;

  List<ErrorRule> get rules => List.unmodifiable(_rules);

  void add(ErrorRule rule) => _rules.add(rule);

  void addAll(Iterable<ErrorRule> rules) => _rules.addAll(rules);

  void clear() => _rules.clear();
}
