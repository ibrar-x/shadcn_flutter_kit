import 'package:flutter/material.dart'
    hide Card, Checkbox, Divider, Slider, Switch;

import '../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../ui/shadcn/components/display/badge/badge.dart' as shadcn_badge;
import '../../ui/shadcn/components/display/divider/divider.dart'
    as shadcn_divider;
import '../../ui/shadcn/components/display/progress/progress.dart'
    as shadcn_progress;
import '../../ui/shadcn/components/form/checkbox/checkbox.dart'
    as shadcn_checkbox;
import '../../ui/shadcn/components/form/slider/slider.dart' as shadcn_slider;
import '../../ui/shadcn/components/form/switch/switch.dart' as shadcn_switch;
import '../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../ui/shadcn/components/layout/accordion/accordion.dart'
    as shadcn_accordion;
import '../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../ui/shadcn/shared/icons/lucide_icons.dart';
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/shared/primitives/slider_value.dart'
    as shadcn_slider_value;

typedef ComponentPreviewBuilder = Widget Function(BuildContext context);

const Map<String, String> componentStatusTags = {
  'chat': 'Experimental',
  'file_picker': 'Experimental',
  'window': 'Experimental',
  'audio_control': 'WIP',
  'video_control': 'WIP',
  'linear_gradient_picker': 'WIP',
  'radial_gradient_picker': 'WIP',
  'sweep_gradient_picker': 'WIP',
};

const Map<String, ComponentPreviewBuilder> componentPreviews = {
  'button': _buttonPreview,
  'badge': _badgePreview,
  'accordion': _accordionPreview,
  'card': _cardPreview,
  'divider': _dividerPreview,
  'checkbox': _checkboxPreview,
  'input': _inputPreview,
  'slider': _sliderPreview,
  'switch': _switchPreview,
  'progress': _progressPreview,
};

const Map<String, IconData> categoryIcons = {
  'control': LucideIcons.textCursorInput,
  'form': LucideIcons.listChecks,
  'layout': LucideIcons.layoutGrid,
  'display': LucideIcons.monitor,
  'navigation': LucideIcons.navigation,
  'overlay': LucideIcons.layers,
  'utility': LucideIcons.wandSparkles,
  'data': LucideIcons.database,
};

IconData iconForCategory(String category) {
  return categoryIcons[category.toLowerCase()] ?? LucideIcons.box;
}

Widget buildComponentPreview(
  BuildContext context,
  String id, {
  String? label,
}) {
  final builder = componentPreviews[id];
  if (builder == null) {
    final displayLabel = label ?? id;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(LucideIcons.box, size: 20),
        const SizedBox(height: 8),
        Text(displayLabel).xSmall().muted(),
      ],
    );
  }
  return builder(context);
}

Widget buildStatusBadge(String status) {
  switch (status) {
    case 'Experimental':
      return const shadcn_badge.PrimaryBadge(child: Text('Experimental'));
    case 'WIP':
      return const shadcn_badge.OutlineBadge(child: Text('WIP'));
    default:
      return const shadcn_badge.SecondaryBadge(child: Text('Info'));
  }
}

Widget _buttonPreview(BuildContext context) {
  return shadcn_buttons.PrimaryButton(
    onPressed: () {},
    child: const Text('Primary'),
  );
}

Widget _badgePreview(BuildContext context) {
  return const shadcn_badge.PrimaryBadge(child: Text('Badge'));
}

Widget _accordionPreview(BuildContext context) {
  return const shadcn_accordion.Accordion(
    items: [
      shadcn_accordion.AccordionItem(
        trigger:
            shadcn_accordion.AccordionTrigger(child: Text('Accordion item')),
        content: Text('Accordion content'),
      ),
    ],
  );
}

Widget _cardPreview(BuildContext context) {
  return shadcn_card.Card(
    padding: const EdgeInsets.all(8),
    child: const Text('Card').xSmall().semiBold(),
  );
}

Widget _dividerPreview(BuildContext context) {
  return const Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      shadcn_divider.Divider(child: Text('Divider')),
    ],
  );
}

Widget _checkboxPreview(BuildContext context) {
  return shadcn_checkbox.Checkbox(
    state: shadcn_checkbox.CheckboxState.checked,
    onChanged: (_) {},
  );
}

Widget _inputPreview(BuildContext context) {
  return const SizedBox(
    width: 160,
    child: shadcn_text_field.TextField(
      hintText: 'Search...',
    ),
  );
}

Widget _sliderPreview(BuildContext context) {
  return SizedBox(
    width: 160,
    child: shadcn_slider.Slider(
      value: const shadcn_slider_value.SliderValue.single(0.6),
      onChanged: (_) {},
    ),
  );
}

Widget _switchPreview(BuildContext context) {
  return shadcn_switch.Switch(
    value: true,
    onChanged: (_) {},
  );
}

Widget _progressPreview(BuildContext context) {
  return const SizedBox(
    width: 160,
    child: shadcn_progress.Progress(progress: 0.62),
  );
}
