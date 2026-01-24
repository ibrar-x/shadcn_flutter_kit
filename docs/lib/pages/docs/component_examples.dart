import 'component_example_models.dart';
import 'components/accordion/accordion_examples.dart';
import 'components/alert/alert_examples.dart';
import 'components/avatar/avatar_examples.dart';
import 'components/badge/badge_examples.dart';
import 'components/button/button_examples.dart';
import 'components/calendar/calendar_examples.dart';
import 'components/card/card_examples.dart';
import 'components/carousel/carousel_examples.dart';
import 'components/chat/chat_examples.dart';
import 'components/checkbox/checkbox_examples.dart';
import 'components/chip/chip_examples.dart';
import 'components/circular_progress_indicator/circular_progress_indicator_examples.dart';
import 'components/clickable/clickable_examples.dart';
import 'components/code_snippet/code_snippet_examples.dart';
import 'components/command/command_examples.dart';
import 'components/dialog/dialog_examples.dart';
import 'components/divider/divider_examples.dart';
import 'components/dot_indicator/dot_indicator_examples.dart';
import 'components/feature_carousel/feature_carousel_examples.dart';
import 'components/hover/hover_examples.dart';
import 'components/icon/icon_examples.dart';
import 'components/input/input_examples.dart';
import 'components/keyboard_shortcut/keyboard_shortcut_examples.dart';
import 'components/linear_progress_indicator/linear_progress_indicator_examples.dart';
import 'components/number_ticker/number_ticker_examples.dart';
import 'components/patch/patch_examples.dart';
import 'components/popover/popover_examples.dart';
import 'components/progress/progress_examples.dart';
import 'components/scrollbar/scrollbar_examples.dart';
import 'components/scrollview/scrollview_examples.dart';
import 'components/selectable/selectable_examples.dart';
import 'components/select/select_examples.dart';
import 'components/skeleton/skeleton_examples.dart';
import 'components/slider/slider_examples.dart';
import 'components/spinner/spinner_examples.dart';
import 'components/switch/switch_examples.dart';
import 'components/table/table_examples.dart';
import 'components/tabs/tabs_examples.dart';
import 'components/text/text_examples.dart';
import 'components/toast/toast_examples.dart';
import 'components/tooltip/tooltip_examples.dart';
import 'components/tracker/tracker_examples.dart';
import 'components/tree/tree_examples.dart';
import 'components/triple_dots/triple_dots_examples.dart';

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
  ComponentExampleBatch(
    title: 'Batch 5',
    componentIds: [
      'carousel',
    ],
  ),
  ComponentExampleBatch(
    title: 'Batch 6',
    componentIds: [
      'chat',
      'chip',
      'circular_progress_indicator',
      'code_snippet',
      'dot_indicator',
      'feature_carousel',
      'icon',
      'keyboard_shortcut',
    ],
  ),
  ComponentExampleBatch(
    title: 'Batch 7',
    componentIds: [
      'linear_progress_indicator',
      'number_ticker',
      'selectable',
      'spinner',
      'text',
      'tracker',
      'tree',
      'triple_dots',
    ],
  ),
];

final Map<String, List<ComponentExample>> componentExamples = {
  'button': buttonExamples,
  'avatar': avatarExamples,
  'badge': badgeExamples,
  'accordion': accordionExamples,
  'card': cardExamples,
  'carousel': carouselExamples,
  'chat': chatExamples,
  'divider': dividerExamples,
  'checkbox': checkboxExamples,
  'chip': chipExamples,
  'circular_progress_indicator': circularProgressIndicatorExamples,
  'clickable': clickableExamples,
  'code_snippet': codeSnippetExamples,
  'command': commandExamples,
  'dot_indicator': dotIndicatorExamples,
  'feature_carousel': featureCarouselExamples,
  'input': inputExamples,
  'hover': hoverExamples,
  'icon': iconExamples,
  'keyboard_shortcut': keyboardShortcutExamples,
  'linear_progress_indicator': linearProgressIndicatorExamples,
  'number_ticker': numberTickerExamples,
  'patch': patchExamples,
  'selectable': selectableExamples,
  'select': selectExamples,
  'spinner': spinnerExamples,
  'slider': sliderExamples,
  'switch': switchExamples,
  'progress': progressExamples,
  'scrollbar': scrollbarExamples,
  'scrollview': scrollviewExamples,
  'text': textExamples,
  'alert': alertExamples,
  'dialog': dialogExamples,
  'tabs': tabsExamples,
  'table': tableExamples,
  'toast': toastExamples,
  'tooltip': tooltipExamples,
  'popover': popoverExamples,
  'skeleton': skeletonExamples,
  'calendar': calendarExamples,
  'tracker': trackerExamples,
  'tree': treeExamples,
  'triple_dots': tripleDotsExamples,
};

List<ComponentExample> examplesForComponent(String componentId) {
  return componentExamples[componentId] ?? const [];
}
