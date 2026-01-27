import 'package:flutter/material.dart' hide TextField;
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../number_ticker/number_ticker.dart';
import '../../form/text_field/text_field.dart';

part '_number_ticker_preview_state.dart';


class NumberTickerPreview extends StatefulWidget {
  const NumberTickerPreview({super.key});

  @override
  State<NumberTickerPreview> createState() => _NumberTickerPreviewState();
}
