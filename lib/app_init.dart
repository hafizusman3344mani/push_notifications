import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cloud_messaging_service.dart';
import 'local_notification_service.dart';


Future appInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  CloudMessagingService.instance.init();
  LocalNotificationsService.instance.init();

  String? deviceToken = await CloudMessagingService.instance.getToken();
  debugPrint('fcm device token :: $deviceToken');

}
