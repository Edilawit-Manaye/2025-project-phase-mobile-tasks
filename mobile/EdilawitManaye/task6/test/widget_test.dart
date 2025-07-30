import 'package:flutter_test/flutter_test.dart';
import 'package:task6/main.dart';

void main() {
  // This is a simple test that just checks if the app starts without crashing.
  testWidgets('App starts smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // You could add a simple check here, for example, to find the home page title.
    // For now, just building the app is a good basic test.
  });
}