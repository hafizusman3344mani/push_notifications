import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  LocalNotificationsService._privateConstructor();

  static final LocalNotificationsService _instance =
      LocalNotificationsService._privateConstructor();

  // Singleton instance across the app
  static LocalNotificationsService get instance => _instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  init() {
    _createChannel();
    _initSetting();
  }

  /* ===================================== Show notification ===================================== */
  void showNotification(
      RemoteMessage remoteMessage, AndroidNotification? android) {
    RemoteNotification? notification = remoteMessage.notification;
    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              icon: android.smallIcon,
              // other properties...
            ),
          ),
          payload: jsonEncode(remoteMessage.data));
    }
  }

  /* ===================================== On select notification ===================================== */
  _selectNotification(NotificationResponse response) async {
    var data = json.decode(response.payload!);
  }

  /* ===================================== Remove notification ===================================== */
  Future removeNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /* ============================= Initialize Settings for android and ios ============================= */
  void _initSetting() async {
    // Android setting
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // IOS setting
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    // Init setting
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _selectNotification,
    );
  }

  /* ===================== Notification channel to override the default behaviour ===================== */
  final AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  void _createChannel() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  /* ===================================== For Older IOS versions ===================================== */
  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }
}
