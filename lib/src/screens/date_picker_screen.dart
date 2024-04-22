import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Date'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DayPicker.single(
              selectedDate: _selectedDate,
              onChanged: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              datePickerLayoutSettings: const DatePickerLayoutSettings(
                maxDayPickerRowCount: 6,
                showPrevMonthEnd: true,
                showNextMonthStart: true,
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _selectedDate),
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
