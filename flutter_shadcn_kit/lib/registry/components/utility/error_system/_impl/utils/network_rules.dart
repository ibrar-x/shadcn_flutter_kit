// Network rules entry point with conditional exports.
// Uses dart:io mapping on IO platforms; returns an empty list on web via stub.

export 'network_rules_stub.dart' if (dart.library.io) 'network_rules_io.dart';
