import 'component_example_models.dart';
import 'components/accordion/accordion_examples.dart';
import 'components/alert/alert_examples.dart';
import 'components/avatar/avatar_examples.dart';
import 'components/badge/badge_examples.dart';
import 'components/button/button_examples.dart';
import 'components/calendar/calendar_examples.dart';
import 'components/card/card_examples.dart';
import 'components/checkbox/checkbox_examples.dart';
import 'components/clickable/clickable_examples.dart';
import 'components/command/command_examples.dart';
import 'components/dialog/dialog_examples.dart';
import 'components/divider/divider_examples.dart';
import 'components/hover/hover_examples.dart';
import 'components/input/input_examples.dart';
import 'components/patch/patch_examples.dart';
import 'components/popover/popover_examples.dart';
import 'components/progress/progress_examples.dart';
import 'components/scrollbar/scrollbar_examples.dart';
import 'components/scrollview/scrollview_examples.dart';
import 'components/select/select_examples.dart';
import 'components/skeleton/skeleton_examples.dart';
import 'components/slider/slider_examples.dart';
import 'components/switch/switch_examples.dart';
import 'components/table/table_examples.dart';
import 'components/tabs/tabs_examples.dart';
import 'components/toast/toast_examples.dart';
import 'components/tooltip/tooltip_examples.dart';

const List<ComponentExampleBatch> exampleBatches = [
  ComponentExampleBatch(
    title: 'Batch 1',
    componentIds: [
      'button',
      'badge',
      'accordion',
      'card',
      'divider',
      'checkbox',
      'input',
      'select',
      'slider',
      'switch',
      'progress',
    ],
  ),
  ComponentExampleBatch(
    title: 'Batch 2',
    componentIds: [
      'alert',
      'dialog',
      'tabs',
      'table',
      'toast',
      'tooltip',
      'popover',
      'skeleton',
      'calendar',
    ],
  ),
  ComponentExampleBatch(
    title: 'Batch 3',
    componentIds: [
      'clickable',
      'command',
      'hover',
      'patch',
      'scrollbar',
      'scrollview',
    ],
  ),
  ComponentExampleBatch(
    title: 'Batch 4',
    componentIds: [
      'avatar',
    ],
  ),
];

final Map<String, List<ComponentExample>> componentExamples = {
  'button': buttonExamples,
  'avatar': avatarExamples,
  'badge': badgeExamples,
  'accordion': accordionExamples,
  'card': cardExamples,
  'divider': dividerExamples,
  'checkbox': checkboxExamples,
  'clickable': clickableExamples,
  'command': commandExamples,
  'input': inputExamples,
  'hover': hoverExamples,
  'patch': patchExamples,
  'select': selectExamples,
  'slider': sliderExamples,
  'switch': switchExamples,
  'progress': progressExamples,
  'scrollbar': scrollbarExamples,
  'scrollview': scrollviewExamples,
  'alert': alertExamples,
  'dialog': dialogExamples,
  'tabs': tabsExamples,
  'table': tableExamples,
  'toast': toastExamples,
  'tooltip': tooltipExamples,
  'popover': popoverExamples,
  'skeleton': skeletonExamples,
  'calendar': calendarExamples,
};

List<ComponentExample> examplesForComponent(String componentId) {
  return componentExamples[componentId] ?? const [];
}
