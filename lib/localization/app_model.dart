import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/reachability.dart';
import '../utils/channel/platform_channel.dart';
import '../utils/firebase_cloud_messaging.dart';
import '../utils/logger.dart';

class AppModel with ChangeNotifier {
  bool isLoading = true;
  bool isUserLogin = true;
  //String pastLanguageOfApp;

  static const Locale enLocale = Locale('en');
  static const Locale arLocale = Locale('ar');

  Locale _appLocale;
  Locale get appLocal {
    if (_appLocale == null) return AppModel.enLocale;
    return _appLocale;
  }

  AppModel() {
    this._setupInitial();
  }

  Future _setupInitial() async {
    Logger().v(" ------------------- ");
    Logger().v("Perform Initial Setup");

    _appLocale = AppModel.enLocale;

    /// Wait until setup reachability
    Reachability reachability = Reachability();
    await reachability.setUpConnectivity();
    Logger().v("Network status : ${reachability.connectStatus}");

    await PlatformChannel().testMethod();

    // isUserLogin = await Token.isUserLogin();
    // if (isUserLogin) {
    //   Token.currentToken.loadUserDetails();
    // }

    // Update FCM Token
    Future.delayed(Duration(seconds: 3), () async {
      await Firebase.initializeApp();
      await FireBaseCloudMessagingWrapper().getFCMToken();
    });
    isLoading = false;
    notifyListeners();
  }

  List<Locale> get supportedLocales => [enLocale, arLocale];

  void changeLanguage({String languageCode}) async {
    Logger().i("Current Local changed with language code $languageCode");

    if (languageCode.toLowerCase() == 'en') {
      _appLocale = enLocale;
    }
    if (languageCode.toLowerCase() == 'ar') {
      _appLocale = arLocale;
    } else {
      _appLocale = enLocale;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'CurrentDeviceLanguage', _appLocale.languageCode.toLowerCase());
    notifyListeners();
  }
}
