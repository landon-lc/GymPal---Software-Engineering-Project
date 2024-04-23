import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_drive/src/screens/checklist_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Workout App System Tests', () {
    // Test for US #1: Adding workouts and tracking daily progress
    testWidgets('Add workout and verify it is tracked (US #1)',
        (WidgetTester tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      await tester.pumpWidget(const MaterialApp(home: ChecklistPage()));
      await tester.pumpAndSettle();

      // Navigate to the workout addition page
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Input the workout details
      await tester.enterText(find.byType(TextField), 'Push Day');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify that the workout has been added to the list
      expect(find.text('Push Day'), findsOneWidget);

      // This test verifies that a user can add a workout and see it on their main screen,
      // which corresponds to the ability to track workouts for the day.
    });

    // Test for US #39: Saving changes to the checklist
    testWidgets('Save changes to the checklist and verify persistence (US #39)',
        (WidgetTester tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      await tester.pumpWidget(const MaterialApp(home: ChecklistPage()));
      await tester.pumpAndSettle();

      // Assuming there is a checkbox to mark workouts as complete
      await tester.tap(find.byType(Checkbox).first);
      await tester.pumpAndSettle();

      // Save the changes
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // Verify that the checkbox remains checked after saving
      expect(
          find.byWidgetPredicate(
              (Widget widget) => widget is Checkbox && widget.value == true),
          findsOneWidget);

      // This test checks if the app correctly saves states in the checklist, allowing users
      // to track completed workouts.
    });

    // Test for US #40: Viewing sets and reps for exercises
    testWidgets('Display sets and reps for exercises (US #40)',
        (WidgetTester tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      await tester.pumpWidget(const MaterialApp(home: ChecklistPage()));
      await tester.pumpAndSettle();

      // Assuming there's a way to view detailed information about a workout
      await tester.tap(find.text('Push Day'));
      await tester.pumpAndSettle();

      // Assuming the workout details page shows sets and reps
      expect(find.text('10 sets'), findsOneWidget);
      expect(find.text('15 reps'), findsOneWidget);

      // This test ensures that users can view the amount of sets and reps for exercises,
      // which helps them track the intensity and volume of their workouts.
    });

    // Test for US #45: Editing saved workouts
    testWidgets('Edit a saved workout and verify changes (US #45)',
        (WidgetTester tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      await tester.pumpWidget(const MaterialApp(home: ChecklistPage()));
      await tester.pumpAndSettle();

      // Navigate to the workout detail page
      await tester.tap(find.text('Push Day'));
      await tester.pumpAndSettle();

      // Tap on the edit button
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      // Change the workout name and save
      await tester.enterText(find.byType(TextField), 'Pull Day');
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();

      // Verify the changes
      expect(find.text('Pull Day'), findsOneWidget);

      // This test checks the functionality that allows users to edit their workouts after saving them,
      // ensuring that the app supports modifications post-creation.
    });

    // // Test for US #46: Continuous data saving
    // testWidgets('Ensure data is saved across sessions (US #46)',
    //     (WidgetTester tester) async {
    //       IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    //   tester.pumpWidget(const MaterialApp(home: ChecklistPage()));
    //   await tester.pumpAndSettle();

    //   // Add a new workout
    //   await tester.tap(find.byIcon(Icons.add));
    //   await tester.pumpAndSettle();
    //   await tester.enterText(find.byType(TextField), 'Bench Press');
    //   await tester.tap(find.text('Save'));
    //   await tester.pumpAndSettle();

    //   // Simulate closing and reopening the app
    //   tester.pumpWidget(const MaterialApp(home: ChecklistPage()));
    //   await tester.pumpAndSettle();

    //   // Verify that the workout is still present
    //   expect(find.text('Bench Press'), findsOneWidget);

    //   // This test verifies the user story requirement that data should persist even after the user exits the application,
    //   // testing the Firebase integration indirectly by checking data persistence.
    // });
  });
}
