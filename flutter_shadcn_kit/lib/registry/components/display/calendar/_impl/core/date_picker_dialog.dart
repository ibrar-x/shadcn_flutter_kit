part of '../../calendar.dart';

class DatePickerDialog extends StatefulWidget {
  /// The initial view type to display (date, month, or year grid).
  final CalendarViewType initialViewType;

  /// The initial calendar view position (month/year to display).
  final CalendarView? initialView;

  /// The selection mode determining how dates can be selected.
  final CalendarSelectionMode selectionMode;

  /// Alternative view mode for display purposes.
  final CalendarSelectionMode? viewMode;

  /// The initially selected date value(s).
  final CalendarValue? initialValue;

  /// Callback invoked when the selected date(s) change.
  final ValueChanged<CalendarValue?>? onChanged;

  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;

  /// Creates a [DatePickerDialog] with comprehensive date selection options.
  ///
  /// Configures the dialog's initial state, selection behavior, and callbacks
  /// for handling date changes and validation.
  ///
  /// Parameters:
  /// - [initialViewType] (CalendarViewType, required): Starting view (date/month/year)
  /// - [initialView] (CalendarView?, optional): Initial calendar view position
  /// - [selectionMode] (CalendarSelectionMode, required): How dates can be selected
  /// - [viewMode] (CalendarSelectionMode?, optional): Alternative view mode for display
  /// - [initialValue] (CalendarValue?, optional): Pre-selected date(s)
  /// - [onChanged] (`ValueChanged<CalendarValue>?`, optional): Called when selection changes
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// Example:
  /// ```dart
  /// DatePickerDialog(
  ///   initialViewType: CalendarViewType.date,
  ///   selectionMode: CalendarSelectionMode.range,
  ///   onChanged: (value) => handleDateChange(value),
  ///   stateBuilder: (date) => date.isBefore(DateTime.now())
  ///     ? DateState.disabled
  ///     : DateState.enabled,
  /// )
  /// ```
  const DatePickerDialog({
    super.key,
    required this.initialViewType,
    this.initialView,
    required this.selectionMode,
    this.viewMode,
    this.initialValue,
    this.onChanged,
    this.stateBuilder,
  });

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  late CalendarView _view;
  late CalendarView _alternateView;
  late CalendarValue? _value;
  late CalendarViewType _viewType;
  late int _yearSelectStart;
  bool _alternate = false;

  @override
  void initState() {
    super.initState();
    _view =
        widget.initialView ?? widget.initialValue?.view ?? CalendarView.now();
    _alternateView = _view.next;
    _value = widget.initialValue;
    _viewType = widget.initialViewType;
    // _yearSelectStart = round year every 16 years so that it can fit 4x4 grid
    _yearSelectStart = (_view.year ~/ 16) * 16;
  }

  @override
  void didUpdateWidget(covariant DatePickerDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialView != oldWidget.initialView ||
        widget.initialValue != oldWidget.initialValue) {
      _view =
          widget.initialView ?? widget.initialValue?.view ?? CalendarView.now();
      _alternateView = _view.next;
      _yearSelectStart = (_view.year ~/ 16) * 16;
    }
    if (widget.initialValue != oldWidget.initialValue) {
      _value = widget.initialValue;
    }
    if (widget.initialViewType != oldWidget.initialViewType) {
      _viewType = widget.initialViewType;
    }
  }

  String getHeaderText(ShadcnLocalizations localizations, CalendarView view,
      CalendarViewType viewType) {
    if (viewType == CalendarViewType.date) {
      return '${localizations.getMonth(view.month)} ${view.year}';
    }
    if (viewType == CalendarViewType.month) {
      return '${view.year}';
    }
    return localizations.datePickerSelectYear;
  }

  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CalendarTheme>(context);
    final arrowColor =
        styleValue(themeValue: compTheme?.arrowIconColor, defaultValue: null);
    final viewMode = widget.viewMode ?? widget.selectionMode;
    if (widget.selectionMode == CalendarSelectionMode.range) {
      return IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlineButton(
                        density: ButtonDensity.icon,
                        onPressed: () {
                          setState(() {
                            switch (_viewType) {
                              case CalendarViewType.date:
                                _view = _view.previous;
                                _alternateView = _alternateView.previous;
                                break;
                              case CalendarViewType.month:
                                _view = _view.previousYear;
                                break;
                              case CalendarViewType.year:
                                _yearSelectStart -= 16;
                                break;
                            }
                          });
                        },
                        child: Icon(LucideIcons.arrowLeft, color: arrowColor)
                            .iconXSmall(),
                      ),
                      SizedBox(
                        width: theme.scaling * 16,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: theme.scaling * 32,
                          child: GhostButton(
                            enabled: _viewType != CalendarViewType.year,
                            onPressed: () {
                              _alternate = false;
                              switch (_viewType) {
                                case CalendarViewType.date:
                                  setState(() {
                                    _viewType = CalendarViewType.month;
                                  });
                                  break;
                                case CalendarViewType.month:
                                  setState(() {
                                    _viewType = CalendarViewType.year;
                                  });
                                  break;
                                default:
                                  break;
                              }
                            },
                            child: Center(
                              child: Text(getHeaderText(
                                      localizations, _view, _viewType))
                                  .foreground()
                                  .small()
                                  .medium(),
                            ),
                          ),
                        ),
                      ),
                      if (_viewType == CalendarViewType.date &&
                          viewMode == CalendarSelectionMode.range)
                        SizedBox(
                          width: theme.scaling * 32,
                        ),
                      SizedBox(
                        width: theme.scaling * 16,
                      ),
                      if (_viewType != CalendarViewType.date ||
                          viewMode != CalendarSelectionMode.range)
                        OutlineButton(
                          density: ButtonDensity.icon,
                          onPressed: () {
                            setState(() {
                              switch (_viewType) {
                                case CalendarViewType.date:
                                  _view = _view.next;
                                  break;
                                case CalendarViewType.month:
                                  _view = _view.nextYear;
                                  break;
                                case CalendarViewType.year:
                                  _yearSelectStart += 16;
                                  break;
                              }
                            });
                          },
                          child: Icon(LucideIcons.arrowRight, color: arrowColor)
                              .iconXSmall(),
                        ),
                    ],
                  ),
                ),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  SizedBox(width: theme.scaling * 16),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: theme.scaling * (32 + 16),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: theme.scaling * 32,
                            child: GhostButton(
                              onPressed: () {
                                _alternate = true;
                                switch (_viewType) {
                                  case CalendarViewType.date:
                                    setState(() {
                                      _viewType = CalendarViewType.month;
                                    });
                                    break;
                                  case CalendarViewType.month:
                                    setState(() {
                                      _viewType = CalendarViewType.year;
                                    });
                                    break;
                                  default:
                                    break;
                                }
                              },
                              child: Center(
                                child: Text(getHeaderText(
                                        localizations, _alternateView, _viewType))
                                    .foreground()
                                    .small()
                                    .medium(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: theme.scaling * 16,
                        ),
                        OutlineButton(
                          density: ButtonDensity.icon,
                          onPressed: () {
                            setState(() {
                              switch (_viewType) {
                                case CalendarViewType.date:
                                  _view = _view.next;
                                  _alternateView = _alternateView.next;
                                  break;
                                case CalendarViewType.month:
                                  _view = _view.nextYear;
                                  break;
                                case CalendarViewType.year:
                                  _yearSelectStart += 16;
                                  break;
                              }
                            });
                          },
                          child: Icon(LucideIcons.arrowRight, color: arrowColor)
                              .iconXSmall(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: theme.scaling * 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: viewMode == CalendarSelectionMode.range
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: [
                buildView(
                  context,
                  _yearSelectStart,
                  _view,
                  _viewType,
                  widget.selectionMode,
                  (value) {
                    setState(() {
                      if (!_alternate) {
                        _view = value;
                        _alternateView = value.next;
                      } else {
                        _view = value.previous;
                        _alternateView = value;
                      }
                      switch (_viewType) {
                        case CalendarViewType.date:
                          break;
                        case CalendarViewType.month:
                          _viewType = CalendarViewType.date;
                          break;
                        case CalendarViewType.year:
                          _viewType = CalendarViewType.month;
                          break;
                      }
                    });
                  },
                ),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  SizedBox(width: theme.scaling * 16),
                if (_viewType == CalendarViewType.date &&
                    viewMode == CalendarSelectionMode.range)
                  buildView(
                    context,
                    _yearSelectStart,
                    _alternateView,
                    _viewType,
                    widget.selectionMode,
                    (value) {},
                  ),
              ],
            ),
          ],
        ),
      );
    }
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {
                  setState(() {
                    switch (_viewType) {
                      case CalendarViewType.date:
                        _view = _view.previous;
                        break;
                      case CalendarViewType.month:
                        _view = _view.previousYear;
                        break;
                      case CalendarViewType.year:
                        _yearSelectStart -= 16;
                        break;
                    }
                  });
                },
                child:
                    Icon(LucideIcons.arrowLeft, color: arrowColor).iconXSmall(),
              ),
              SizedBox(
                width: theme.scaling * 16,
              ),
              Expanded(
                child: SizedBox(
                  height: theme.scaling * 32,
                  child: GhostButton(
                    enabled: _viewType != CalendarViewType.year,
                    onPressed: () {
                      switch (_viewType) {
                        case CalendarViewType.date:
                          setState(() {
                            _viewType = CalendarViewType.month;
                          });
                          break;
                        case CalendarViewType.month:
                          setState(() {
                            _viewType = CalendarViewType.year;
                          });
                          break;
                        default:
                          break;
                      }
                    },
                    child: Center(
                      child: Text(getHeaderText(localizations, _view, _viewType))
                          .foreground()
                          .small()
                          .medium(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: theme.scaling * 16,
              ),
              OutlineButton(
                density: ButtonDensity.icon,
                onPressed: () {
                  setState(() {
                    switch (_viewType) {
                      case CalendarViewType.date:
                        _view = _view.next;
                        break;
                      case CalendarViewType.month:
                        _view = _view.nextYear;
                        break;
                      case CalendarViewType.year:
                        _yearSelectStart += 16;
                        break;
                    }
                  });
                },
                child: Icon(LucideIcons.arrowRight, color: arrowColor)
                    .iconXSmall(),
              ),
            ],
          ),
          SizedBox(height: theme.scaling * 16),
          buildView(
            context,
            _yearSelectStart,
            _view,
            _viewType,
            widget.selectionMode,
            (value) {
              setState(() {
                _view = value;
                switch (_viewType) {
                  case CalendarViewType.date:
                    break;
                  case CalendarViewType.month:
                    _viewType = CalendarViewType.date;
                    break;
                  case CalendarViewType.year:
                    _viewType = CalendarViewType.month;
                    break;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildView(
      BuildContext context,
      int yearSelectStart,
      CalendarView view,
      CalendarViewType viewType,
      CalendarSelectionMode selectionMode,
      ValueChanged<CalendarView> onViewChanged) {
    if (viewType == CalendarViewType.year) {
      return YearCalendar(
        value: view.year,
        yearSelectStart: yearSelectStart,
        calendarValue: _value,
        stateBuilder: widget.stateBuilder,
        onChanged: (value) {
          setState(() {
            onViewChanged(view.copyWith(year: () => value));
          });
        },
      );
    }
    if (viewType == CalendarViewType.month) {
      return MonthCalendar(
        value: view,
        onChanged: onViewChanged,
        stateBuilder: widget.stateBuilder,
        calendarValue: _value,
      );
    }
    return Calendar(
      value: _value,
      view: view,
      stateBuilder: widget.stateBuilder,
      onChanged: (value) {
        setState(() {
          _value = value;
          widget.onChanged?.call(value);
        });
      },
      selectionMode: selectionMode,
    );
  }
}

/// Abstract base class representing calendar selection values.
///
/// Provides a unified interface for different types of calendar selections including
/// single dates, date ranges, and multiple date collections. Handles date lookup
/// operations and conversion between different selection types.
///
/// Subclasses include:
/// - [SingleCalendarValue]: Represents a single selected date
/// - [RangeCalendarValue]: Represents a date range with start and end
/// - [MultiCalendarValue]: Represents multiple individual selected dates
///
/// The class provides factory constructors for easy creation and conversion
/// methods to transform between different selection types as needed.
///
/// Example:
/// ```dart
/// // Create different value types
/// final single = CalendarValue.single(DateTime.now());
/// final range = CalendarValue.range(startDate, endDate);
/// final multi = CalendarValue.multi([date1, date2, date3]);
///
/// // Check if a date is selected
/// final lookup = value.lookup(2024, 3, 15);
/// final isSelected = lookup != CalendarValueLookup.none;
/// ```
