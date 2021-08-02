import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wall_hunt/localization/localization.dart';

import '../control/notification_view.dart';
import 'logger.dart';

/*
## Notification types :-

*/

class FireBaseCloudMessagingWrapper extends Object {


  RemoteMessage _pendingNotification;

  FirebaseMessaging _fireBaseMessaging;
  String _fcmToken = "WDU9hl_B4UWdTfzCP";
  String get fcmToken => _fcmToken;
  bool _isAppStarted = false; // Used for identify if navigation instance created

  factory FireBaseCloudMessagingWrapper() {
    return _singleton;
  }

  static final FireBaseCloudMessagingWrapper _singleton = new FireBaseCloudMessagingWrapper._internal();
  FireBaseCloudMessagingWrapper._internal() {
    Logger().e("===== Firebase Messaging instance created =====");
    _fireBaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessagingListeners();
  }


  Future<String> getFCMToken() async {
    try {
      String token = await _fireBaseMessaging.getToken();
      if (token != null && token.isNotEmpty) {
        Logger().e("===== FCM Token :: $token =====");
        _fcmToken = token;
      }
      return _fcmToken;
    } catch (e) {
      print("Error :: ${e.toString()}");
      return null;
    }
  }


  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _fireBaseMessaging.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        if (this._isAppStarted) {
          this.notificationOperation(payload: message);
        } else {
          this._pendingNotification = message;
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().v("onMessage :: ${message.toString()}");
      Future.delayed(Duration(seconds: 1), () => this.displayNotificationView(payload: message));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationOperation(payload: message);
    });

  }

  performPendingNotificationOperation() {
    this._isAppStarted = true;
    Logger().e("Check Operation for pending notification");
    if (this._pendingNotification == null) { return; }
    this.notificationOperation(payload: this._pendingNotification);
    this._pendingNotification = null;
  }

  void iOSPermission() async {
    NotificationSettings settings = await _fireBaseMessaging.requestPermission(alert: true,badge: true,sound: true, criticalAlert: true,);
    print('User granted permission: ${settings.authorizationStatus}');
    _fireBaseMessaging.getNotificationSettings();
  }

  //region notification action view
  void displayNotificationView({RemoteMessage payload}) {
    String title = Translations.globalTranslations.appName;
    String body = "";

    title = payload?.notification?.title ?? '';
    body = payload?.notification?.body ?? '';

    Logger().v("Display notification view");

    showOverlayNotification((BuildContext _cont) {
      return NotificationView(title: title, subTitle: body, onTap: (isAllow) {
        OverlaySupportEntry.of(_cont).dismiss();
        if (isAllow) {
          this.notificationOperation(payload: payload);
        }
      });
    }, duration: Duration(milliseconds: 5000));
  }
  //endregion

  //region notificationOperation or input action
  void notificationOperation({RemoteMessage payload}) {

    Logger().v(" Notification On tap Detected ");

    Map<String, dynamic> notification = Map<String, dynamic>();
    notification = payload.data ?? Map<String, dynamic>();

    int notificationType = int.tryParse((notification['type'] ?? '').toString());
    Logger().v(" Notification :: $notificationType");
  }
//endregion
}