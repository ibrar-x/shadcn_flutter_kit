import 'package:flutter/widgets.dart';

import '../../../../../shared/utils/style_value.dart';
import '../themes/scrollbar_theme.dart';
import '../state/shadcn_scrollbar_state.dart';

const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

class ShadcnScrollbar extends RawScrollbar {
  const ShadcnScrollbar({
    super.key,
    required super.child,
    super.controller,
    super.thumbVisibility,
    super.trackVisibility,
    super.thickness,
    super.radius,
    this.color,
    ScrollNotificationPredicate? notificationPredicate,
    super.interactive,
    super.scrollbarOrientation,
  }) : super(
         fadeDuration: _kScrollbarFadeDuration,
         timeToFade: _kScrollbarTimeToFade,
         pressDuration: Duration.zero,
         notificationPredicate:
             notificationPredicate ?? defaultScrollNotificationPredicate,
       );

  final Color? color;

  @override
  RawScrollbarState<ShadcnScrollbar> createState() => ShadcnScrollbarState();
}
