import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import '../lib/src/screens/friends_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testing for searching for user', () {
    
    testWidgets('Searching for users', (WidgetTester tester) async {
      app.main();
      await tester.pumpWidget(const MaterialApp(
      home: FriendsListScreen(),
      ));
      await tester.pumpAndSettle();

      // Navigating to search / friends screen
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'tester222'); // change name as test account
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();
      expect(find.text('tester222'), findsOneWidget); // making sure that the next screen displays the users username
    });
    
  });
}