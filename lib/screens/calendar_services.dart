import 'package:demo1/firebase/store_firebase.dart';
import 'package:demo1/views/item_modal_calendar_services.dart';
import 'package:flutter/material.dart';
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

  final StoreFirebase storeFirebase = StoreFirebase();
  Map<DateTime, List<String>> eventosPorFecha = {};

  DateTime _normalizeDate(DateTime date) =>
  DateTime.utc(date.year, date.month, date.day);

  void _loadEventos() async {
    final eventos = await storeFirebase.getEventosCalendar();
    setState(() {
      eventosPorFecha = eventos;
    });
  }

  @override
  void initState(){
    super.initState();
    _loadEventos();
  }
  Widget _indicatorPoint(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 14, color: Colors.black)),
    ],
  );
}

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
                useRootNavigator: true,
                builder: (context) => ModalCalendar(date: selectedDay, storeFirebase: storeFirebase,)
              );
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context,day,events){
                final dateKey = _normalizeDate(day);
                final estados = eventosPorFecha[dateKey];

                if (estados == null || estados.isEmpty) return SizedBox.shrink();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: estados.map((estados){
                    Color color;
                    switch (estados) {
                      case 'pendiente':
                        color = Colors.yellow;
                        break;
                      case 'completado':
                        color = Colors.green;
                        break;
                      case 'cancelado':
                        color = Colors.red;
                        break;
                      default:
                        color = Colors.grey;
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.5),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    );
                  }).toList()
                );
              }
            ),
            
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _indicatorPoint(Colors.yellow, 'Pendiente'),
                const SizedBox(width: 16),
                _indicatorPoint(Colors.green, 'Completado'),
                const SizedBox(width: 16),
                _indicatorPoint(Colors.red, 'Cancelado'),
              ],
            ),
          )

        ],
      ),
    );
  }
}