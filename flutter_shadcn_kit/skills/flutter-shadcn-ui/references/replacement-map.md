# Material/Cupertino Replacement Map

Check this before adding Material/Cupertino widgets or custom wrappers.

## Direct Replacements

- `Scaffold` -> `layout/scaffold` (`Scaffold`)
- `AppBar` -> `layout/scaffold` (`AppBar`)
- `Card` -> `layout/card` (`Card`, `SurfaceCard`)
- `Divider`, `VerticalDivider` -> `display/divider`
- `Chip`, `InputChip`, `ChoiceChip` -> `display/chip`
- `TextField` -> `form/text_field` or `form/input`
- `DropdownButton`, `DropdownMenu` -> `form/select`
- `Checkbox` -> `form/checkbox`
- `Radio`, `RadioListTile` groups -> `form/radio_group`
- `Switch` -> `form/switch`
- `Slider`, `RangeSlider` -> `form/slider`
- `LinearProgressIndicator` -> `display/linear_progress_indicator` or `display/progress`
- `CircularProgressIndicator` -> `display/circular_progress_indicator`
- `Tooltip` -> `overlay/tooltip`
- `AlertDialog` -> `overlay/alert_dialog` or `overlay/dialog`
- `Dialog` -> `overlay/dialog`
- `BottomSheet`, `showModalBottomSheet` -> `overlay/drawer` (`openSheet`, `openSheetOverlay`)
- `Drawer` -> `overlay/drawer` (`openDrawer`, `openDrawerOverlay`)
- `PopupMenuButton`, `PopupMenuItem` -> `overlay/menu`, `overlay/dropdown_menu`, `overlay/context_menu`
- `TabBar`, `TabBarView`, `DefaultTabController` -> `navigation/tabs`, `navigation/tab_list`, `navigation/tab_container`, `navigation/tab_pane`
- `Stepper` -> `navigation/stepper` or `layout/steps`
- Pagination patterns -> `navigation/pagination`
- Breadcrumb patterns -> `navigation/breadcrumb`
- `SnackBar` and transient toasts -> `overlay/toast`
- `ExpansionPanelList` and collapsible sections -> `layout/accordion` or `layout/collapsible`
- `DataTable` -> `layout/table`
- List wheel and carousel patterns -> `display/carousel` or `display/feature_carousel`
- `RefreshIndicator` -> `overlay/refresh_trigger`
- `Autocomplete` -> `form/autocomplete`
- `CalendarDatePicker` and date dialogs -> `display/calendar` plus `form/date_picker`
- `TimePicker` -> `form/time_picker`

## Framework Primitives That Are Fine

Use `package:flutter/widgets.dart` primitives when no registry abstraction is better:

- `Row`, `Column`, `Flex`, `Expanded`, `Spacer`
- `Stack`, `Positioned`, `Container`, `SizedBox`
- `Padding`, `Align`, `Center`, `Wrap`, `SafeArea`, `LayoutBuilder`

## Import Conflict Rule

Do not alias registry imports. Hide conflicting Material/Cupertino symbols:

```dart
import 'package:flutter/material.dart'
    hide Scaffold, AppBar, Card, Drawer, AlertDialog, showDialog;
import 'package:my_app/ui/shadcn/components/scaffold.dart';
import 'package:my_app/ui/shadcn/components/dialog.dart';
```
