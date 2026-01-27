part of '../../calendar.dart';

class CalendarGridData {
  /// The month number (1-12) this grid represents.
  final int month;

  /// The year this grid represents.
  final int year;

  /// The list of calendar grid items including current and adjacent month dates.
  final List<CalendarGridItem> items;

  /// Creates calendar grid data for the specified month and year.
  ///
  /// Automatically calculates and includes dates from previous and next months
  /// to fill complete weeks in the grid.
  factory CalendarGridData({required int month, required int year}) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month == 12 ? 1 : month + 1, 0).day;

    int prevMonthDays = firstDayOfMonth.weekday;
    DateTime prevMonthLastDay =
        firstDayOfMonth.subtract(Duration(days: prevMonthDays));

    List<CalendarGridItem> items = [];

    int itemCount = 0;

    if (prevMonthDays < 7) {
      for (int i = 0; i < prevMonthDays; i++) {
        int currentItemIndex = itemCount++;
        items.add(CalendarGridItem(
          prevMonthLastDay.add(Duration(days: i)),
          currentItemIndex % 7,
          true,
          currentItemIndex ~/ 7,
        ));
      }
    }

    for (int i = 0; i < daysInMonth; i++) {
      int currentItemIndex = itemCount++;
      DateTime currentDay = DateTime(year, month, i + 1);
      items.add(CalendarGridItem(
        currentDay,
        currentItemIndex % 7,
        false,
        currentItemIndex ~/ 7,
      ));
    }

    int remainingDays = (7 - (items.length % 7)) % 7;
    DateTime nextMonthFirstDay = DateTime(year, month + 1, 1);

    if (remainingDays < 7) {
      for (int i = 0; i < remainingDays; i++) {
        int currentItemIndex = itemCount++;
        items.add(CalendarGridItem(
          nextMonthFirstDay.add(Duration(days: i)),
          currentItemIndex % 7,
          true,
          currentItemIndex ~/ 7,
        ));
      }
    }

    return CalendarGridData._(month, year, items);
  }

  CalendarGridData._(this.month, this.year, this.items);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarGridData &&
        other.month == month &&
        other.year == year &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hash(month, year, items);
}

/// Individual item within a calendar grid representing a single date cell.
///
/// Contains metadata about a date's position and state within the calendar grid.
class CalendarGridItem {
  /// The date this grid item represents.
  final DateTime date;

  /// The index of this item within its row (0-6 for day of week).
  final int indexInRow;

  /// The row index in the calendar grid.
  final int rowIndex;

  /// Whether this date belongs to a different month than the grid's primary month.
  final bool fromAnotherMonth;

  /// Creates a calendar grid item.
  CalendarGridItem(
      this.date, this.indexInRow, this.fromAnotherMonth, this.rowIndex);

  /// Returns true if this item represents today's date.
  bool get isToday {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarGridItem &&
        other.date.isAtSameMomentAs(date) &&
        other.indexInRow == indexInRow &&
        other.fromAnotherMonth == fromAnotherMonth &&
        other.rowIndex == rowIndex;
  }

  @override
  int get hashCode => Object.hash(date, indexInRow, fromAnotherMonth, rowIndex);
}

/// Widget that renders a calendar grid using provided data.
///
/// Takes calendar grid data and an item builder to render the visual grid
/// of calendar dates. Handles layout and arrangement of dates in a weekly grid.
class CalendarGrid extends StatelessWidget {
  /// The grid data containing all calendar items to display.
  final CalendarGridData data;

  /// Builder function to create widgets for each grid item.
  final Widget Function(CalendarGridItem item) itemBuilder;

  /// Creates a calendar grid widget.
  const CalendarGrid({
    super.key,
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = ShadcnLocalizations.of(context);
    // return GridView.builder(
    //   shrinkWrap: true,
    //   itemCount: data.items.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 7,
    //     mainAxisSpacing: 0,
    //     crossAxisSpacing: 8 * theme.scaling,
    //   ),
    //   itemBuilder: (context, index) {
    //     return SizedBox(
    //       width: theme.scaling * 32,
    //       height: theme.scaling * 32,
    //       child: itemBuilder(data.items[index]),
    //     );
    //   },
    // );
    // do not use GridView because it doesn't support IntrinsicWidth
    List<Widget> rows = [];
    List<Widget> weekDays = [];
    for (int i = 0; i < 7; i++) {
      int weekday = ((i - 1) % 7) + 1;
      weekDays.add(
        Container(
          width: theme.scaling * 32,
          height: theme.scaling * 32,
          alignment: Alignment.center,
          child: Text(localizations.getAbbreviatedWeekday(weekday))
              .muted()
              .xSmall(),
        ),
      );
    }
    rows.add(Row(
      mainAxisSize: MainAxisSize.min,
      children: weekDays,
    ));
    for (int i = 0; i < data.items.length; i += 7) {
      rows.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: data.items.sublist(i, i + 7).map((e) {
          return SizedBox(
            width: theme.scaling * 32,
            height: theme.scaling * 32,
            child: itemBuilder(e),
          );
        }).toList(),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: theme.scaling * 8,
      children: rows,
    );
  }
}
