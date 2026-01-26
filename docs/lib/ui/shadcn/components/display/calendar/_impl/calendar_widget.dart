part of '../calendar.dart';

class Calendar extends StatefulWidget {
  /// The current date for highlighting purposes (defaults to DateTime.now()).
  final DateTime? now;

  /// The currently selected date value(s).
  final CalendarValue? value;

  /// The month and year view to display in the calendar.
  final CalendarView view;

  /// The selection mode determining how dates can be selected.
  final CalendarSelectionMode selectionMode;

  /// Callback invoked when the selected date(s) change.
  final ValueChanged<CalendarValue?>? onChanged;

  /// Legacy function to determine if a date should be enabled.
  final bool Function(DateTime date)? isDateEnabled;

  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;

  /// Creates a [Calendar] widget with flexible date selection capabilities.
  ///
  /// Configures the calendar's view, selection behavior, and interaction handling
  /// with comprehensive options for customization and validation.
  ///
  /// Parameters:
  /// - [view] (CalendarView, required): Month/year to display in calendar grid
  /// - [selectionMode] (CalendarSelectionMode, required): How dates can be selected
  /// - [now] (DateTime?, optional): Current date for highlighting, defaults to DateTime.now()
  /// - [value] (CalendarValue?, optional): Currently selected date(s)
  /// - [onChanged] (`ValueChanged<CalendarValue>?`, optional): Called when selection changes
  /// - [isDateEnabled] (bool Function(DateTime)?, optional): Legacy date validation function
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// The [view] parameter determines which month and year are shown in the calendar grid.
  /// Use [CalendarView.now()] for current month or [CalendarView(year, month)] for specific dates.
  ///
  /// The [stateBuilder] takes precedence over [isDateEnabled] when both are provided.
  ///
  /// Example:
  /// ```dart
  /// Calendar(
  ///   view: CalendarView(2024, 3), // March 2024
  ///   selectionMode: CalendarSelectionMode.single,
  ///   onChanged: (value) => print('Selected: ${value?.toString()}'),
  ///   stateBuilder: (date) => date.weekday == DateTime.sunday
  ///     ? DateState.disabled
  ///     : DateState.enabled,
  /// )
  /// ```
  const Calendar({
    super.key,
    this.now,
    this.value,
    required this.view,
    required this.selectionMode,
    this.onChanged,
    this.isDateEnabled,
    this.stateBuilder,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late CalendarGridData _gridData;

  @override
  void initState() {
    super.initState();
    _gridData =
        CalendarGridData(month: widget.view.month, year: widget.view.year);
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view.year != widget.view.year ||
        oldWidget.view.month != widget.view.month) {
      _gridData =
          CalendarGridData(month: widget.view.month, year: widget.view.year);
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
          return Opacity(
            opacity: 0.5,
            child: calendarItem,
          );
        }
        return calendarItem;
      },
    );
  }
}

/// A calendar widget that displays months in a year grid.
///
/// Shows a 4x3 grid of months for year selection. Used as part of the calendar
/// navigation when users want to select a different month.
