import 'package:flutter/material.dart' hide Card;
import 'package:gap/gap.dart';
import '../calendar/calendar.dart';
import '../../../shared/localizations/shadcn_localizations.dart';
import '../../../shared/primitives/icon_extensions.dart';
import '../../../shared/primitives/text.dart';
import '../../control/button/button.dart';
import '../../layout/card/card.dart' as shadcn;

part '_calendar_preview_state.dart';


class CalendarPreview extends StatefulWidget {
  const CalendarPreview({super.key});

  @override
  State<CalendarPreview> createState() => _CalendarPreviewState();
}
