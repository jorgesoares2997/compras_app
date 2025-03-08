import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationService(this._notificationsPlugin);

  // Configurações padrão para Android e iOS
  static const AndroidNotificationDetails _androidDetails =
      AndroidNotificationDetails(
        'general_channel',
        'General Notifications',
        channelDescription: 'Channel for general app notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

  static const DarwinNotificationDetails _iOSDetails =
      DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

  static const NotificationDetails _platformDetails = NotificationDetails(
    android: _androidDetails,
    iOS: _iOSDetails,
  );

  // Exibir uma notificação imediata
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      await _notificationsPlugin.show(id, title, body, _platformDetails);
    } catch (e) {
      print('Error showing notification: $e');
      rethrow; // Relança a exceção para ser capturada no _submitForm
    }
  }

  // Agendar uma notificação para um horário específico
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    try {
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        _platformDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    } catch (e) {
      print('Error scheduling notification: $e');
      rethrow;
    }
  }

  // Cancelar uma notificação específica
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  // Cancelar todas as notificações
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
