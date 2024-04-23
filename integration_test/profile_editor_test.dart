import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_drive/src/screens/profile_editor_screen.dart';

void main() {
  testWidgets('Profile Editor - Upload Image Test',
      (WidgetTester tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    // Opens app and move to profile screen.
    await tester.pumpWidget(const MaterialApp(
      home: ProfileEditorScreen(),
    ));

    // Ensures that the upload button is present, and taps the button. Image picker should open.
    expect(find.text('Upload Image'), findsOneWidget);
    await tester.tap(find.text('Upload Image'));
    await tester.pump();
  });

  testWidgets('Profile Editor - Bio Text Test', (WidgetTester tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    // Opens app and move to profile screen.
    await tester.pumpWidget(const MaterialApp(
      home: ProfileEditorScreen(),
    ));

    // Opens and tests the bio text field, ensures text is correct on the profile screen.
    await tester.enterText(find.byType(TextField), 'New bio text');
    await tester.pump();
    expect(find.text('New bio text'), findsOneWidget);

    // Uses the save button, should route to profile screen.
    await tester.tap(find.text('Save About Me'));
    await tester.pump();
  });

  testWidgets('Profile Editor - Logout Test', (WidgetTester tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    // Uses logout button, should take user to the intital login screen.
    await tester.tap(find.text('Logout'));
    await tester.pump();
    expect(find.text('Login'), findsOneWidget);
  });
}
