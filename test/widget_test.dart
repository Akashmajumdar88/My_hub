import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhub_akash_majumdar/app.dart';

void main() {
  testWidgets('MyHub onboarding smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame, wrapping it in a ProviderScope
    await tester.pumpWidget(
      const ProviderScope(
        child: MyHubApp(),
      ),
    );

    // Verify that our Splash View is rendered and shows the application title
    expect(find.text('Application'), findsOneWidget);
  });
}
