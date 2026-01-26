# Phone Input

`PhoneInput` pairs a selectable country dropdown with a phone number field, handling formatting/filter rules plus searchable country selection. Include it wherever you want consistent international phone entry.

```dart
PhoneInput(
  initialCountry: Country.unitedStates,
  onChanged: (phone) => print(phone.fullNumber),
)
```
