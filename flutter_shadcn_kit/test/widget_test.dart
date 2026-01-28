import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_shadcn_kit/main.dart';

void main() {
  testWidgets('File picker demo boots', (WidgetTester tester) async {
    await tester.pumpWidget(const FilePickerDemoApp());
    expect(find.text('File Upload / Dropzone'), findsOneWidget);
  });
}
