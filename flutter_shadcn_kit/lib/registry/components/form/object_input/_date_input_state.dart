part of 'object_input.dart';

class _DateInputState extends State<DateInput> {
  late ComponentController<NullableDate> _controller;

  NullableDate _convertToDateTime(List<String?> values) {
    Map<DatePart, String?> parts = {};
    var datePartsOrder =
        widget.datePartsOrder ?? ShadcnLocalizations.of(context).datePartsOrder;
    for (int i = 0; i < values.length; i++) {
      parts[datePartsOrder[i]] = values[i];
    }
    String? yearString = parts[DatePart.year];
    String? monthString = parts[DatePart.month];
    String? dayString = parts[DatePart.day];
    int? year = yearString == null || yearString.isEmpty
        ? null
        : int.tryParse(yearString);
    int? month = monthString == null || monthString.isEmpty
        ? null
        : int.tryParse(monthString);
    int? day =
        dayString == null || dayString.isEmpty ? null : int.tryParse(dayString);
    return NullableDate(year: year, month: month, day: day);
  }

  List<String?> _convertFromDateTime(NullableDate? value) {
    var datePartsOrder =
        widget.datePartsOrder ?? ShadcnLocalizations.of(context).datePartsOrder;
    if (value == null) {
      return datePartsOrder.map((part) => null).toList();
    }
    var validDateTime = value.getDateTime(
      defaultYear: datePartsOrder.contains(DatePart.year) ? null : 0,
      defaultMonth: datePartsOrder.contains(DatePart.month) ? null : 1,
      defaultDay: datePartsOrder.contains(DatePart.day) ? null : 1,
    );
    if (validDateTime == null) {
      return datePartsOrder.map((part) => null).toList();
    }
    return datePartsOrder.map((part) {
      switch (part) {
        case DatePart.year:
          return validDateTime.year.toString();
        case DatePart.month:
          return validDateTime.month.toString();
        case DatePart.day:
          return validDateTime.day.toString();
      }
    }).toList();
  }

  double _getWidth(DatePart part) {
    switch (part) {
      case DatePart.year:
        return 60;
      case DatePart.month:
        return 40;
      case DatePart.day:
        return 40;
    }
  }

  Widget _getPlaceholder(DatePart part) {
    var localizations = ShadcnLocalizations.of(context);
    return Text(localizations.getDatePartAbbreviation(part));
  }

  int _getLength(DatePart part) {
    switch (part) {
      case DatePart.year:
        return 4;
      case DatePart.month:
        return 2;
      case DatePart.day:
        return 2;
    }
  }

  NullableDate _convertToNullableDate(DateTime? value) {
    if (value == null) {
      return NullableDate();
    }
    return NullableDate(year: value.year, month: value.month, day: value.day);
  }

  DateTime? _convertFromNullableDate(NullableDate value) {
    return value.getDateTime();
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? ComponentValueController<NullableDate>(
            _convertToNullableDate(widget.initialValue))
        : ConvertedController<DateTime?, NullableDate>(
            widget.controller!,
            BiDirectionalConvert(
                _convertToNullableDate, _convertFromNullableDate),
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var datePartsOrder =
        widget.datePartsOrder ?? ShadcnLocalizations.of(context).datePartsOrder;
    return FormattedObjectInput<NullableDate>(
      popupBuilder: (context, controller) {
        return SurfaceCard(
          child: DatePickerDialog(
            initialViewType: widget.initialViewType ?? CalendarViewType.date,
            selectionMode: CalendarSelectionMode.single,
            initialValue: controller.value == null
                ? null
                : CalendarValue.single(controller.value!.date),
            initialView: widget.initialView ?? CalendarView.now(),
            stateBuilder: widget.stateBuilder,
            onChanged: (value) {
              var date = value?.toSingle().date;
              controller.value = NullableDate(
                year: date?.year,
                month: date?.month,
                day: date?.day,
              );
            },
          ),
        );
      },
      popoverIcon: const Icon(LucideIcons.calendarDays),
      converter: BiDirectionalConvert(_convertFromDateTime, _convertToDateTime),
      controller: _controller,
      initialValue: _convertToNullableDate(widget.initialValue),
      onChanged: (value) {
        widget.onChanged
            ?.call(value == null ? null : _convertFromNullableDate(value));
      },
      parts: datePartsOrder
          .map(
            (part) {
              return InputPart.editable(
                  length: _getLength(part),
                  width: _getWidth(part),
                  placeholder:
                      widget.placeholders?[part] ?? _getPlaceholder(part),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ]);
            },
          )
          .joinSeparator(const InputPart.static('/'))
          .toList(),
    );
  }
}
