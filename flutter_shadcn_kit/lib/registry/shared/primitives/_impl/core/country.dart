part of '../../phone_number.dart';

class Country {
  /// The international dial code (e.g. "+1").
  final String dialCode;

  /// The ISO 2-letter country code.
  final String code;

  /// Creates a [Country] descriptor.
  const Country({required this.dialCode, required this.code});
}

/// Represents an international phone number with an associated country.
