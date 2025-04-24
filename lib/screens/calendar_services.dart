import 'package:demo1/views/item_modal_calendar_services.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:table_calendar/table_calendar.dart';



class CalendarServices extends StatefulWidget {
  const CalendarServices({super.key});

  @override
  State<CalendarServices> createState() => _CalendarServicesState();
}

class _CalendarServicesState extends State<CalendarServices> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario de ventas'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay, 
            firstDay: DateTime(1900), 
            lastDay: DateTime(2040),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              showCupertinoModalBottomSheet(
                context: context,
                expand: true,
                builder: (context) => ModalCalendar(date: selectedDay)
              );
            })
        ],
      ),
    );
  }
}