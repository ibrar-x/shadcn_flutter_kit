import 'package:cli_install_validation_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Validation app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ValidationApp());

    expect(find.text('shadcn CLI Validation'), findsOneWidget);
  });
}
