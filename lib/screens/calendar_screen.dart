import 'package:compras_app/ParticleBackground.dart';
import 'package:compras_app/generated/l10n.dart';
import 'package:compras_app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
  late NotificationService _notificationService;

  @override
  void initState() {
    super.initState();
    _schedules = {};
    _selectedDay = _focusedDay;
    _notificationService = NotificationService(
      Provider.of<FlutterLocalNotificationsPlugin>(context, listen: false),
    );
  }

  @override
  void dispose() {
    _personController.dispose();
    super.dispose();
  }

  void _addSchedule(DateTime day) {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              localizations.scheduleFor(DateFormat('dd/MM/yyyy').format(day)),
            ),
            content: TextField(
              controller: _personController,
              decoration: InputDecoration(
                labelText: localizations.personName,
                border: const OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(localizations.cancel),
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
                    _scheduleNotification(day, _personController.text);
                    _personController.clear();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAEBF8A),
                ),
                child: Text(
                  localizations.add,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _scheduleNotification(DateTime day, String person) async {
    final localizations = AppLocalizations.of(context)!;
    final scheduledDate = DateTime(
      day.year,
      day.month,
      day.day,
      8,
      0,
    ); // 8h do dia
    await _notificationService.scheduleNotification(
      id: day.hashCode,
      title: localizations.scheduleToday,
      body: localizations.scheduleNotificationMessage(person),
      scheduledDate: scheduledDate,
    );
  }

  List<Schedule> _getSchedulesForDay(DateTime day) {
    return _schedules[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.calendar),
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
                                localizations.scheduledFor(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(schedule.date),
                                ),
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
