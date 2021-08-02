import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/logger.dart';

class PlatformChannel {

  factory PlatformChannel() {
    return _instance;
  }

  static PlatformChannel _instance = new PlatformChannel._internal();

  static const _channelName = "app.wallhunt";
  MethodChannel _platform = const MethodChannel(PlatformChannel._channelName);

  PlatformChannel._internal(){
    this._platform.setMethodCallHandler((MethodCall call) {
      Logger().e("call.method ${call.method}  call.arguments :: ${call.arguments}" );
      return;
    });
  }

  void dispose() {
  }

  Future testMethod() async {
    try {
      final String result = await _platform.invokeMethod('test');
      Logger().e("Result :: $result");
      return;
    } on PlatformException catch (e) {
      Logger().e("Exception :: ${e.message}");
    }
  }

  //region clearNotification
  Future clearNotification() async {
    try {
      final result = await _platform.invokeMethod('clearNotification');
      return result;
    } on PlatformException catch (e) {
      Logger().e("Exception :: ${e.message}");
      return null;
    }
  }
  //endregion

  Future<bool> openSettings() async {
    bool isOpened = await openAppSettings();
    return isOpened;
  }

  //region Check for permission group
  Future<bool> checkForPermission(Permission permission) async {
    if (Platform.isIOS) {
      bool result = await this._checkPermissionForIOS(permission);
      return result;
    } else if (Platform.isAndroid) {
      bool result = await this._checkPermissionForAndroid(permission);
      return result;
    } else {
      return false;
    }
  }
}

extension PermissionMethod on PlatformChannel {
  //region IOS
  Future<bool> _checkPermissionForIOS(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;
    Logger().v(" PermissionStatus :: ${permissionStatus.toString()}");
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    else if (permissionStatus == PermissionStatus.undetermined) {
      Logger().v("PermissionGroup :: $permission");
      PermissionStatus status = await permission.request();
      return status == PermissionStatus.granted;
    }
    else {
      return false;
    }
  }
  //endregion

  //region Android
  Future<bool> _checkPermissionForAndroid(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;
    Logger().v(" PermissionStatus :: ${permissionStatus.toString()}");
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    else if  (permissionStatus == PermissionStatus.denied || permissionStatus == PermissionStatus.undetermined) {
      PermissionStatus pStatus = await permission.request();
      Logger().v(" PermissionStatus :: ${pStatus.toString()}");
      if (pStatus == PermissionStatus.granted) {
        return true;
      } else if (pStatus == PermissionStatus.permanentlyDenied) {
        return false;
      } else if (pStatus == PermissionStatus.undetermined) {
        return true;
      } else {
        bool status = await this._checkPermissionForNeverAsk(permission);
        return status;
      }
    }
    else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      return false;
    }
    return false;
  }

  Future<bool> _checkPermissionForNeverAsk(Permission permission) async {
    Logger().v("_check Persmission For NeverAsk");
    PermissionStatus permissionStatus = await permission.request();
    Logger().v(" PermissionStatus :: ${permissionStatus.toString()}");
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      return false;
    } else {
      bool status = await this._checkPermissionForNeverAsk(permission);
      return status;
    }
  }
//endregion
}



