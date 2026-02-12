import 'package:flutter/material.dart';

import 'component_page.dart';
import 'component_examples.dart';
import 'component_previews.dart';
import 'components_registry.dart';
import '../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../ui/shadcn/components/form/slider/slider.dart' as shadcn_slider;
import '../../ui/shadcn/components/form/switch/switch.dart' as shadcn_switch;
import '../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import '../../ui/shadcn/shared/primitives/slider_value.dart'
    as shadcn_slider_value;
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;
import 'widget_usage_example.dart';
import 'package:go_router/go_router.dart';

class ComponentDetailPage extends StatefulWidget {
  final String componentId;

  const ComponentDetailPage({super.key, required this.componentId});

  @override
  State<ComponentDetailPage> createState() => _ComponentDetailPageState();
}

class _ComponentDetailPageState extends State<ComponentDetailPage> {
  static const List<int> _maxRenderedOptions = [4, 6, 8, 12, 20];

  bool _performanceMode = false;
  double _lazyThreshold = 0.1;
  int _maxRendered = 6;

  static const Map<String, String> _dependentInstallCommands = {
    'toggle': 'flutter_shadcn add button',
    'avatar_group': 'flutter_shadcn add avatar',
    'choices': 'flutter_shadcn add multiple_choice',
    'multiselect': 'flutter_shadcn add select chip button',
    'number_input': 'flutter_shadcn add text_field formatter',
    'radio_card': 'flutter_shadcn add radio_group card',
    'app_bar': 'flutter_shadcn add scaffold button outlined_container',
    'material': 'flutter_shadcn add app card alert_dialog button',
    'expandable_sidebar':
        'flutter_shadcn add navigation_bar outlined_container',
    'navigation_rail': 'flutter_shadcn add navigation_bar',
    'navigation_sidebar':
        'flutter_shadcn add navigation_bar outlined_container',
    'sheet': 'flutter_shadcn add drawer form alert_dialog button',
  };

  String _installCommandFor(String id) {
    return _dependentInstallCommands[id] ?? 'flutter_shadcn add $id';
  }

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    final spacing = theme.spacing;
    return FutureBuilder<List<RegistryComponent>>(
      future: loadRegistryComponents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!originalComponentIds.contains(widget.componentId)) {
          return ComponentPage(
            name: widget.componentId,
            description: 'Component not available in the original docs app.',
            displayName: widget.componentId,
            category: 'Unavailable',
            children: [
              const Text('No examples available for this component.').muted(),
            ],
          );
        }

        final component = snapshot.data!
            .firstWhere((item) => item.id == widget.componentId, orElse: () {
          return RegistryComponent(
            id: widget.componentId,
            name: widget.componentId,
            description: 'Component not found in registry.',
            category: 'Unknown',
            tags: const [],
          );
        });

        final examples = examplesForComponent(component.id);

        if (examples.isNotEmpty) {
          final maxRendered = _performanceMode ? _maxRendered : examples.length;
          final visibleExamples = examples.take(maxRendered).toList();
          final hiddenCount = examples.length - visibleExamples.length;
          return ComponentPage(
            name: component.id,
            description: component.description,
            displayName: component.name,
            category: component.category,
            children: [
              if (component.id == 'error_system')
                OutlinedContainer(
                  child: Padding(
                    padding: EdgeInsets.all(spacing.lg),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Quick Start Guide').semiBold(),
                              SizedBox(height: spacing.xs),
                              const Text(
                                'Open the full guide with setup, rules, and best practices.',
                              ).muted(),
                            ],
                          ),
                        ),
                        shadcn_buttons.PrimaryButton(
                          onPressed: () =>
                              context.goNamed('error_system_quick_start'),
                          child: const Text('Open guide'),
                        ),
                      ],
                    ),
                  ),
                ),
              _buildPerformanceControls(
                totalExamples: examples.length,
                hiddenCount: hiddenCount,
              ),
              for (var index = 0; index < visibleExamples.length; index++)
                WidgetUsageExample(
                  key: ValueKey(
                    'example-${component.id}-$index-${visibleExamples[index].title}-${visibleExamples[index].code.hashCode}',
                  ),
                  title: visibleExamples[index].title,
                  code: visibleExamples[index].code,
                  lazyThreshold: _performanceMode ? _lazyThreshold : 0.1,
                  previewPadding: EdgeInsets.all(spacing.xxl),
                  previewFullBleed: false,
                  previewMinHeight: null,
                  installCommand:
                      index == 0 ? _installCommandFor(component.id) : null,
                  child: visibleExamples[index].builder(context),
                ),
              if (hiddenCount > 0)
                shadcn_buttons.LinkButton(
                  onPressed: () => setState(() {
                    _performanceMode = false;
                  }),
                  child: Text('Show all ${examples.length} examples'),
                ),
            ],
          );
        }

        return ComponentPage(
          name: component.id,
          description: component.description,
          displayName: component.name,
          category: component.category,
          children: [
            _buildPerformanceControls(
              totalExamples: 0,
              hiddenCount: 0,
            ),
            WidgetUsageExample(
              title: 'Preview',
              code: '// Example coming soon',
              installCommand: _installCommandFor(component.id),
              child: buildComponentPreview(
                context,
                component.id,
                label: component.name,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPerformanceControls({
    required int totalExamples,
    required int hiddenCount,
  }) {
    final spacing = shadcn_theme.Theme.of(context).spacing;
    final thresholdLabel = (_lazyThreshold * 100).round();
    final selectedMax = _maxRenderedOptions.contains(_maxRendered)
        ? _maxRendered
        : _maxRenderedOptions.first;
    final controls = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Performance mode').semiBold(),
        SizedBox(height: spacing.sm),
        shadcn_switch.Switch(
          value: _performanceMode,
          onChanged: (value) => setState(() {
            _performanceMode = value;
            if (!_maxRenderedOptions.contains(_maxRendered)) {
              _maxRendered = _maxRenderedOptions.first;
            }
          }),
          trailing: const Text('Enable performance mode'),
        ),
        SizedBox(height: spacing.md),
        Opacity(
          opacity: _performanceMode ? 1 : 0.4,
          child: IgnorePointer(
            ignoring: !_performanceMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lazy-load threshold: $thresholdLabel%').small(),
                SizedBox(height: spacing.sm),
                shadcn_slider.Slider(
                  value: shadcn_slider_value.SliderValue.single(_lazyThreshold),
                  min: 0.05,
                  max: 0.75,
                  divisions: 14,
                  onChanged: (value) => setState(() {
                    _lazyThreshold = value.value;
                  }),
                ),
                SizedBox(height: spacing.md),
                Row(
                  children: [
                    const Text('Max rendered examples:').small(),
                    SizedBox(width: spacing.sm),
                    DropdownButton<int>(
                      value: selectedMax,
                      onChanged: (value) => setState(() {
                        if (value != null) {
                          _maxRendered = value;
                        }
                      }),
                      items: [
                        for (final option in _maxRenderedOptions)
                          DropdownMenuItem(
                            value: option,
                            child: Text('$option'),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (totalExamples > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              hiddenCount > 0
                  ? 'Showing ${totalExamples - hiddenCount} of $totalExamples examples.'
                  : 'Showing all $totalExamples examples.',
            ).small(),
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: OutlinedContainer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: controls,
        ),
      ),
    );
  }
}
