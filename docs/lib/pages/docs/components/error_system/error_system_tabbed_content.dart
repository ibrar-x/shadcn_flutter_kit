import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../component_example_models.dart';
import '../../widget_usage_example.dart';
import '../../../docs_page.dart';
import 'error_system_quick_start_example.dart';
import '../../../../ui/shadcn/components/navigation/tabs/tabs.dart'
    as shadcn_tabs;

class ErrorSystemTabbedContent extends StatefulWidget {
  const ErrorSystemTabbedContent({
    super.key,
    required this.examples,
    required this.previewOnThisPage,
    required this.quickStartOnThisPage,
  });

  final List<ComponentExample> examples;
  final Map<String, OnThisPage> previewOnThisPage;
  final Map<String, OnThisPage> quickStartOnThisPage;

  @override
  State<ErrorSystemTabbedContent> createState() =>
      _ErrorSystemTabbedContentState();
}

class _ErrorSystemTabbedContentState extends State<ErrorSystemTabbedContent> {
  int index = 0;

  void _setIndex(int nextIndex) {
    setState(() => index = nextIndex);
    for (final entry in widget.previewOnThisPage.values) {
      entry.isVisible.value = false;
    }
    for (final entry in widget.quickStartOnThisPage.values) {
      entry.isVisible.value = false;
    }
    final ScrollController? controller = PrimaryScrollController.maybeOf(
      context,
    );
    if (controller != null && controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        shadcn_tabs.TabList(
          index: index,
          onChanged: _setIndex,
          children: const [
            shadcn_tabs.TabItem(child: Text('Example Preview')),
            shadcn_tabs.TabItem(child: Text('Quick Start Guide')),
          ],
        ),
        const Gap(16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: index == 0
              ? _PreviewTab(
                  key: const ValueKey('error-system-preview'),
                  examples: widget.examples,
                  onThisPage: widget.previewOnThisPage,
                )
              : ErrorSystemQuickStartGuide(
                  key: const ValueKey('error-system-quick-start'),
                  onThisPage: widget.quickStartOnThisPage,
                ),
        ),
      ],
    );
  }
}

class _PreviewTab extends StatelessWidget {
  const _PreviewTab({
    super.key,
    required this.examples,
    required this.onThisPage,
  });

  final List<ComponentExample> examples;
  final Map<String, OnThisPage> onThisPage;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: examples.length,
      itemBuilder: (context, index) => 
          PageItemWidget(
            onThisPage: onThisPage[examples[index].title]!,
            child: WidgetUsageExample(
              title: examples[index].title,
              code: examples[index].code,
              installCommand:
                  index == 0 ? 'flutter_shadcn add error-system' : null,
              child: examples[index].builder(context),
            ),
          ),
    );
  }
}
