part of '../../calendar.dart';

class _CalendarState extends State<Calendar> {
  late CalendarGridData _gridData;

  @override
  void initState() {
    super.initState();
    _gridData = CalendarGridData(
      month: widget.view.month,
      year: widget.view.year,
    );
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view.year != widget.view.year ||
        oldWidget.view.month != widget.view.month) {
      _gridData = CalendarGridData(
        month: widget.view.month,
        year: widget.view.year,
      );
    }
  }

  void _handleTap(DateTime date) {
    var calendarValue = widget.value;
    if (widget.selectionMode == CalendarSelectionMode.none) {
      return;
    }
    if (widget.selectionMode == CalendarSelectionMode.single) {
      if (calendarValue is SingleCalendarValue &&
          date.isAtSameMomentAs(calendarValue.date)) {
        widget.onChanged?.call(null);
        return;
      }
      widget.onChanged?.call(CalendarValue.single(date));
      return;
    }
    if (widget.selectionMode == CalendarSelectionMode.multi) {
      if (calendarValue == null) {
        widget.onChanged?.call(CalendarValue.single(date));
        return;
      }
      final lookup = calendarValue.lookup(date.year, date.month, date.day);
      if (lookup == CalendarValueLookup.none) {
        var multi = calendarValue.toMulti();
        (multi).dates.add(date);
        widget.onChanged?.call(multi);
        return;
      } else {
        var multi = calendarValue.toMulti();
        (multi).dates.remove(date);
        if (multi.dates.isEmpty) {
          widget.onChanged?.call(null);
          return;
        }
        widget.onChanged?.call(multi);
        return;
      }
    }
    if (widget.selectionMode == CalendarSelectionMode.range) {
      if (calendarValue == null) {
        widget.onChanged?.call(CalendarValue.single(date));
        return;
      }
      if (calendarValue is MultiCalendarValue) {
        calendarValue = calendarValue.toRange();
      }
      if (calendarValue is SingleCalendarValue) {
        DateTime selectedDate = calendarValue.date;
        if (date.isAtSameMomentAs(selectedDate)) {
          widget.onChanged?.call(null);
          return;
        }
        widget.onChanged?.call(CalendarValue.range(selectedDate, date));
        return;
      }
      if (calendarValue is RangeCalendarValue) {
        DateTime start = calendarValue.start;
        DateTime end = calendarValue.end;
        if (date.isBefore(start)) {
          widget.onChanged?.call(CalendarValue.range(date, end));
          return;
        }
        if (date.isAfter(end)) {
          widget.onChanged?.call(CalendarValue.range(start, date));
          return;
        }
        if (date.isAtSameMomentAs(start)) {
          widget.onChanged?.call(null);
          return;
        }
        if (date.isAtSameMomentAs(end)) {
          widget.onChanged?.call(CalendarValue.single(end));
          return;
        }
        widget.onChanged?.call(CalendarValue.range(start, date));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalendarGrid(
      data: _gridData,
      itemBuilder: (item) {
        DateTime date = item.date;
        CalendarValueLookup lookup =
            widget.value?.lookup(date.year, date.month, date.day) ??
            CalendarValueLookup.none;
        CalendarItemType type = CalendarItemType.none;
        switch (lookup) {
          case CalendarValueLookup.none:
            if (widget.now != null && widget.now!.isAtSameMomentAs(date)) {
              type = CalendarItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = CalendarItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = CalendarItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = CalendarItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = CalendarItemType.inRange;
            break;
        }
        Widget calendarItem = CalendarItem(
          type: type,
          indexAtRow: item.indexInRow,
          rowCount: 7,
          onTap: () {
            _handleTap(date);
          },
          state: widget.stateBuilder?.call(date) ?? DateState.enabled,
          child: Text('${date.day}'),
        );
        if (item.fromAnotherMonth) {
          return Opacity(opacity: 0.5, child: calendarItem);
        }
        return calendarItem;
      },
    );
  }
}
