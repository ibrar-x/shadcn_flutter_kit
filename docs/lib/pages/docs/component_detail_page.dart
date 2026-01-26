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
import 'widget_usage_example.dart';

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

  @override
  Widget build(BuildContext context) {
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
              _buildPerformanceControls(
                totalExamples: examples.length,
                hiddenCount: hiddenCount,
              ),
              for (final example in visibleExamples)
                WidgetUsageExample(
                  title: example.title,
                  code: example.code,
                  lazyThreshold: _performanceMode ? _lazyThreshold : 0.1,
                  child: example.builder(context),
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
    final thresholdLabel = (_lazyThreshold * 100).round();
    final selectedMax = _maxRenderedOptions.contains(_maxRendered)
        ? _maxRendered
        : _maxRenderedOptions.first;
    final controls = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Performance mode').semiBold(),
        const SizedBox(height: 8),
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
        const SizedBox(height: 12),
        Opacity(
          opacity: _performanceMode ? 1 : 0.4,
          child: IgnorePointer(
            ignoring: !_performanceMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lazy-load threshold: $thresholdLabel%').small(),
                const SizedBox(height: 8),
                shadcn_slider.Slider(
                  value: shadcn_slider_value.SliderValue.single(_lazyThreshold),
                  min: 0.05,
                  max: 0.75,
                  divisions: 14,
                  onChanged: (value) => setState(() {
                    _lazyThreshold = value.value;
                  }),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Max rendered examples:').small(),
                    const SizedBox(width: 8),
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
