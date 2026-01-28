import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_shadcn_kit/registry/composites/layout/app/app.dart';
import 'package:flutter_shadcn_kit/registry/components/display/empty_state/preview.dart';
import 'package:flutter_shadcn_kit/registry/shared/theme/theme.dart' as shadcn;

void main() {
  testWidgets('Empty state demo boots', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ShadcnApp(
        title: 'Empty State',
        theme: shadcn.ThemeData(),
        home: EmptyStatePreview(),
      ),
    );
    expect(find.text('Empty State'), findsOneWidget);
  });
}
