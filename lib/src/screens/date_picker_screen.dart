import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

/// A screen that provides a user interface for selecting a date within a specified range.
///
/// This widget uses the [DayPicker] widget from the `flutter_date_pickers` package
/// to allow users to pick a single date. The selected date can be used for other
/// purposes outside this widget, such as filtering data or setting deadlines.
class DatePickerScreen extends StatefulWidget {
  /// Constructs the [DatePickerScreen] widget.
  const DatePickerScreen({super.key});

  @override
  // Ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

/// State for [DatePickerScreen] which handles date selection and user interactions.
///
/// This state manages the currently selected date and updates it when the user
/// selects a new date from the picker.
class _DatePickerScreenState extends State<DatePickerScreen> {
  /// Currently selected date, initialized to today's date.
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Date'), // AppBar title.
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DayPicker.single(
              selectedDate: _selectedDate, // Currently selected date.
              onChanged: (date) {
                setState(() {
                  _selectedDate = date; // Update the selected date.
                });
              },
              firstDate: DateTime.now().subtract(
                  const Duration(days: 30)), // Earliest selectable date.
              lastDate: DateTime.now()
                  .add(const Duration(days: 30)), // Latest selectable date.
              datePickerLayoutSettings: const DatePickerLayoutSettings(
                maxDayPickerRowCount:
                    6, // Maximum number of rows for days to display.
                showPrevMonthEnd:
                    true, // Whether to show the end of the previous month.
                showNextMonthStart:
                    true, // Whether to show the start of the next month.
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context,
                  _selectedDate), // Passes back the selected date on button press.
              child: const Text('Confirm'), // Button label.
            ),
          ],
        ),
      ),
    );
  }
}
