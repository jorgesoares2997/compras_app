import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationService(this._notificationsPlugin);

  // Configurações para Android
  static const AndroidNotificationDetails _androidDetails =
      AndroidNotificationDetails(
        'urgent_equipment_channel', // ID único do canal
        'Urgent Equipment Notifications', // Nome visível ao usuário
        channelDescription: 'Notificações para equipamentos urgentes',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

  // Configurações para iOS
  static const DarwinNotificationDetails _iOSDetails =
      DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

  // Detalhes da plataforma
  static const NotificationDetails _platformDetails = NotificationDetails(
    android: _androidDetails,
    iOS: _iOSDetails,
  );

  // Exibir notificação imediata
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      print(
        'Attempting to show notification: ID=$id, Title=$title, Body=$body',
      );
      await _notificationsPlugin.show(id, title, body, _platformDetails);
      print('Notification shown successfully');
    } catch (e) {
      print('Error showing notification: $e');
      rethrow;
    }
  }

  // Agendar notificação (se necessário)
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    try {
      print(
        'Scheduling notification: ID=$id, Title=$title, Body=$body, Date=$scheduledDate',
      );
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
      print('Notification scheduled successfully');
    } catch (e) {
      print('Error scheduling notification: $e');
      rethrow;
    }
  }
}
