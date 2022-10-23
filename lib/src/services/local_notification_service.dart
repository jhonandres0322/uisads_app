import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:uisads_app/src/constants/colors.dart';

class LocalNotificationService {
  LocalNotificationService();

  // Propiedad para cargar el plugin de notificaciones
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  // Stream para escuchar la informacion de ingreso de la notificacion
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  // Inicializacion ded las configuraciones para las Notificaciones en Android y IOS
  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_logo_app');

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }
  // Metodo para mostrar los detalles de la notificacion
  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            color: AppColors.accept,
            playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }
  // Metodo para mostrar la notificacion simple
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }
  // Metodo para mostrar la notificacion con una duracion en ejecutarse
  Future<void> showScheduledNotification(
      {required int id,
      required String title,
      required String body,
      required int seconds}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        DateTime.now().add(Duration(seconds: seconds)),
        tz.local,
      ),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  // Metodo para mostrar una notificacion con un payload o informacion recibida de este
  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }
  // Metodo para recibir la notificacion del usuario al dispositivo IOS
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }
  // Metodo para recibir la notificacion del usuario al dispositivo Android y seleccionarla
  void onSelectNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      // Envia el payload a la variable onNotificationClick que es mi stream
      onNotificationClick.add(payload);
    }
  }
}