import 'dart:io';
import 'package:wall_hunt/utils/firebase_cloud_messaging.dart';

class DeviceUtil {
  factory DeviceUtil() {
    return _singleton;
  }

  static final DeviceUtil _singleton = DeviceUtil._internal();

  DeviceUtil._internal() {
    // Logger().v("Instance created DevideUtil");
  }

  String currentLanguageCode = "en";
  String _deviceId = '';
  String get deviceId => _deviceId;
  String baseOS;
  String model;

  String _version = '';
  String _buildNumber = '';
  bool isPhysicalDevice = false;
  String get versionName => '$_version ($_buildNumber)';

  // Future<void> updateDeviceInfo() async {
  //
  //   // Getting Device Info
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     _deviceId = androidInfo.androidId;
  //     isPhysicalDevice = androidInfo.isPhysicalDevice;
  //     baseOS = androidInfo.version.release;
  //     model = androidInfo.model;
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     _deviceId = iosInfo.identifierForVendor;
  //     isPhysicalDevice = iosInfo.isPhysicalDevice;
  //     baseOS = iosInfo.systemVersion;
  //     model = iosInfo.model;
  //   }
  //
  //   // Getting Device Info
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   _version = packageInfo.version;
  //   _buildNumber = packageInfo.buildNumber;
  // }

  static Map<String, dynamic> generateDeviceDTO() {
    // "prDeviceDTO": {
    // "deviceUUID": "string",
    // "latitude": 0,
    // "longitude": 0,
    // },

    final Map<String, dynamic> deviceDTO = new Map<String, dynamic>();
    deviceDTO['deviceId'] = DeviceUtil().deviceId ?? '';
    deviceDTO['deviceUUID'] = DeviceUtil().deviceId ?? '';
    deviceDTO['deviceType'] = Platform.isAndroid ? 'ANDROID' : 'IOS';
    deviceDTO['userType'] = 'CONTRACTOR';
    deviceDTO['deviceModel'] = DeviceUtil().model ?? '';
    deviceDTO['osVersion'] = DeviceUtil().baseOS ?? '';
    deviceDTO['deviceToken'] = FireBaseCloudMessagingWrapper().fcmToken ?? '';
    return deviceDTO;
  }
}
