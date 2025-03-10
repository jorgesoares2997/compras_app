// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> showNotification(String title, String body) async {
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'compras_app_channel', // ID único do canal
//     'Notificações do Compras App',
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: true,
//   );

//   const NotificationDetails details = NotificationDetails(
//     android: androidDetails,
//     iOS: DarwinNotificationDetails(),
//   );

//   await flutterLocalNotificationsPlugin.show(
//     0, // ID da notificação
//     title,
//     body,
//     details,
//   );
// }
