import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_service.dart';

class CloudMessagingService {
  CloudMessagingService._privateConstructor();

  static final CloudMessagingService _instance =
      CloudMessagingService._privateConstructor();

  static CloudMessagingService get instance => _instance;

  /* ========================================================================================================*/

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void init() async {
    _handleOnMessage();
    _handleUserInteraction();

    if (Platform.isIOS) {
      _setForeGroundNotificationsIOS();
      _setNotificationPermissionsIOS();
    }
  }

  void _handleOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('handle on message called');
      RemoteNotification notification = message.notification!;
      if (message.notification != null) {}
      AndroidNotification? android = message.notification?.android;
      LocalNotificationsService.instance.showNotification(message, android);
    });
  }

  Future<void> _handleUserInteraction() async {
    // from terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    // from background state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(
    RemoteMessage message,
  ) {
    print('handle message called');

    LocalNotificationsService.instance
        .showNotification(message, message.notification?.android);
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> deleteToken() async {
    _firebaseMessaging.deleteToken();
  }

  void _setForeGroundNotificationsIOS() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void _setNotificationPermissionsIOS() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
