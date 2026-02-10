part of '../../history.dart';

/// State class for [RecentColorsScope] implementing color history storage.
///
/// Manages the list of recently used colors and provides storage functionality
/// for color history tracking.
class RecentColorsScopeState extends State<RecentColorsScope>
    implements ColorHistoryStorage {
  late _ColorListNotifier _recentColors;

  @override
  int get capacity => widget.maxRecentColors;

  @override
  void initState() {
    super.initState();
    _recentColors = _ColorListNotifier(List.from(widget.initialRecentColors));
  }

  @override
  List<Color> get recentColors =>
      List.unmodifiable(_recentColors._recentColors);

  @override
  void addHistory(Color color) {
    var recentColors = _recentColors._recentColors;
    if (recentColors.contains(color)) {
      recentColors.remove(color);
    }
    recentColors.insert(0, color);
    if (recentColors.length > widget.maxRecentColors) {
      recentColors.removeLast();
    }
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void dispose() {
    super.dispose();
    _recentColors.dispose();
  }

  @override
  void clear() {
    _recentColors._recentColors.clear();
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void setHistory(List<Color> colors) {
    _recentColors._recentColors = colors;
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  Widget build(BuildContext context) {
    return ForwardableData<ColorHistoryStorage>(
      data: this,
      child: Data<ColorHistoryStorage>.inherit(data: this, child: widget.child),
    );
  }

  @override
  void addListener(VoidCallback listener) {
    _recentColors.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _recentColors.removeListener(listener);
  }
}
