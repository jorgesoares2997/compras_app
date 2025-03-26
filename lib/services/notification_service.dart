import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/schedule.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications;
  final String _smtpServer;
  final String _smtpUsername;
  final String _smtpPassword;
  final String _senderEmail;

  NotificationService({
    required FlutterLocalNotificationsPlugin notifications,
    required String smtpServer,
    required String smtpUsername,
    required String smtpPassword,
    required String senderEmail,
  }) : _notifications = notifications,
       _smtpServer = smtpServer,
       _smtpUsername = smtpUsername,
       _smtpPassword = smtpPassword,
       _senderEmail = senderEmail;

  Future<void> scheduleNotification(Schedule schedule) async {
    // Schedule push notification
    await _schedulePushNotification(schedule);

    // Schedule email notification
    await _scheduleEmailNotification(schedule);
  }

  Future<void> _schedulePushNotification(Schedule schedule) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'schedule_channel',
          'Schedules',
          channelDescription: 'Schedule notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final scheduledDate = DateTime(
      schedule.date.year,
      schedule.date.month,
      schedule.date.day,
      8, // 8 AM
      0,
    );

    await _notifications.zonedSchedule(
      schedule.date.hashCode,
      'Lembrete de Escala',
      'Você tem uma escala hoje!',
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> _scheduleEmailNotification(Schedule schedule) async {
    final smtpServer = SmtpServer(
      _smtpServer,
      username: _smtpUsername,
      password: _smtpPassword,
    );

    final message =
        mailer.Message()
          ..from = mailer.Address(_senderEmail)
          ..recipients.add(schedule.email)
          ..subject = 'Lembrete de Escala'
          ..text = '''
      Olá ${schedule.person},

      Este é um lembrete de que você tem uma escala hoje.

      Data: ${schedule.date.day}/${schedule.date.month}/${schedule.date.year}

      Por favor, não se atrase!

      Atenciosamente,
      Sistema de Escalas
      ''';

    try {
      await mailer.send(message, smtpServer);
    } catch (e) {
      print('Erro ao enviar email: $e');
      // You might want to handle this error appropriately
    }
  }
}
