/// Simplified country metadata for phone numbers.
class Country {
  /// The international dial code (e.g. "+1").
  final String dialCode;

  /// The ISO 2-letter country code.
  final String code;

  /// Creates a [Country] descriptor.
  const Country({required this.dialCode, required this.code});
}

/// Represents an international phone number with an associated country.
class PhoneNumber {
  /// Country that owns this phone number.
  final Country country;

  /// Phone number digits without the country code.
  final String number;

  /// Creates a [PhoneNumber] for [country] and [number].
  const PhoneNumber(this.country, this.number);

  /// The combined dial code and number (e.g. +15551234567).
  String get fullNumber => '${country.dialCode}$number';

  /// Returns the dial code concatenated number or null when the number is empty.
  String? get value => number.isEmpty ? null : fullNumber;

  @override
  String toString() {
    return number.isEmpty ? '' : fullNumber;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhoneNumber &&
        other.country == country &&
        other.number == number;
  }

  @override
  int get hashCode => Object.hash(country, number);
}
