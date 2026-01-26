# Future Improvements

- We will try to minimize external dependencies.

## Lowest risk to replace (minimal behavior impact)

gap
Used only for spacing widgets. Replace with a local Gap widget or SizedBox.
Example usages: util.dart:214, timeline.dart:321
Safe swap: implement Gap locally and/or replace calls with SizedBox.

animation_kit
Only used for IntervalDuration in checkbox animation.
Single usage: checkbox.dart:732
Safe swap: implement a small local Curve class (same API) and remove the import.

email_validator
Used in form validation.
Usage: form.dart:1
Safe swap: local RegExp validator. Slight behavior differences are possible, but usually acceptable.

## Potentially replaceable (but functionality trade-offs)
4) skeletonizer

Used by skeleton component.
Usage: skeleton.dart:1
Replacement would change visuals. You can build a lightweight shimmer or static skeleton.

country_flags + phonecodes
Only used by phone input.
Usage: phone_input.dart:1
Replaceable if you ship a local country/phone code list and a simple flag widget (emoji flags or assets). Adds maintenance burden and removes locale-specific behavior.

## Hard to replace without broad changes (keep unless you want a larger refactor)
6) data_widget

Deeply used for Data.inherit, Data.of, Data.capture, CapturedThemes, CapturedData across overlays, layout, primitives, and shared utils.
Example: overlay.dart:1, util.dart:176
You can replace it by creating a local DataScope + capture helpers, but it’s a large refactor.

expressions
Used for math expression input formatting.
Usage: formatter.dart:1
Replacing requires a custom parser/evaluator or dropping the mathExpression formatter.

## Should keep (core features)
8) intl

Used by localization and number formatting.
Usage: shadcn_localizations.dart:1
Removing will break localization.

flutter_localizations
Flutter SDK dependency; not an external package.
