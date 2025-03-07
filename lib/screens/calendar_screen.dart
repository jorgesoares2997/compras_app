import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/main.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';
import '../models/schedule.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<Schedule>> _schedules;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _personController = TextEditingController();

  DateTime get normalizedDay => DateTime(2025);

  @override
  void initState() {
    super.initState();
    _schedules = {};
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _personController.dispose();
    super.dispose();
  }

  // Adicionar uma escala
  void _addSchedule(DateTime day) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Escalar para ${DateFormat('dd/MM/yyyy').format(day)}'),
            content: TextField(
              controller: _personController,
              decoration: const InputDecoration(
                labelText: 'Nome da Pessoa',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_personController.text.isNotEmpty) {
                    setState(() {
                      final normalizedDay = DateTime(
                        day.year,
                        day.month,
                        day.day,
                      );
                      _schedules[normalizedDay] ??= [];
                      _schedules[normalizedDay]!.add(
                        Schedule(
                          date: normalizedDay,
                          person: _personController.text,
                        ),
                      );
                    });
                    _scheduleNotification(
                      normalizedDay,
                      _personController.text,
                    );
                    _personController.clear();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAEBF8A),
                ),
                child: const Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }

  // Configurar notificação (Corrigido)
  Future<void> _scheduleNotification(DateTime day, String person) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'schedule_channel',
          'Escalas',
          channelDescription: 'Notificações de escalas',
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final scheduledDate = DateTime(
      day.year,
      day.month,
      day.day,
      8,
      0,
    ); // 8h do dia
    await flutterLocalNotificationsPlugin.zonedSchedule(
      day.hashCode, // ID único baseado no dia
      'Escala Hoje',
      'Olá, $person! Você está escalado(a) hoje.',
      TZDateTime.from(scheduledDate, local), // Usar TZDateTime para timezone
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  // Obter escalas para um dia
  List<Schedule> _getSchedulesForDay(DateTime day) {
    return _schedules[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário'),
        backgroundColor: const Color(0xFFF2D4AE),
      ),
      body: Stack(
        children: [
          const ParticleBackground(
            backgroundColor: Color.fromARGB(255, 155, 124, 221),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFFAEBF8A).withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF02732A),
                      shape: BoxShape.circle,
                    ),
                  ),
                  eventLoader: _getSchedulesForDay,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children:
                        _getSchedulesForDay(_selectedDay!).map((schedule) {
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(schedule.person),
                              subtitle: Text(
                                'Escalado para ${DateFormat('dd/MM/yyyy').format(schedule.date)}',
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSchedule(_selectedDay!),
        backgroundColor: const Color(0xFFAEBF8A),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
