import 'dart:convert';

import 'package:flutter/cupertino.dart' as Route;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wall_hunt/control/progress_dialog.dart';
import 'package:wall_hunt/localization/localization.dart';
import 'package:wall_hunt/service/reachability.dart';
import '../utils/ui_utils.dart';
import 'app_color.dart';
import 'enum.dart';
import 'logger.dart';

class Utils {
  factory Utils() {
    return _singleton;
  }

  static final Utils _singleton = Utils._internal();

  Utils._internal() {
    Logger().v("Instance created Utils");
  }

  /// Used for update page list
  bool isApiCallRequired = false;

  //region Convert Map
  static Map<String, dynamic> convertMap(dynamic map) {
    Map<dynamic, dynamic> mapDynamic;
    if (map is String) {
      var obj = json.decode(map);
      mapDynamic = obj;
    } else if (map is Map<dynamic, dynamic>) {
      mapDynamic = map;
    } else {
      return Map<String, dynamic>();
    }

    Map<String, dynamic> convertedMap = Map<String, dynamic>();
    for (dynamic key in mapDynamic.keys) {
      if (key is String) {
        convertedMap[key] = mapDynamic[key];
      }
    }
    return convertedMap;
  }

  //endregion

  static Widget buildImageWidget({String url, String placeholder, BoxFit fit}) {
    if (url.isEmpty) {
      return Image.asset(
        placeholder,
        fit: fit ?? BoxFit.cover,
      );
    }

    return FadeInImage.assetNetwork(
      placeholder: placeholder,
      image: url,
      fit: fit ?? BoxFit.cover,
    );
  }

//endregion

  static void showSnackBar(GlobalKey<ScaffoldState> _key, String message, {int duration = 1, SnackBarAction action}) {
    final text = Text(
      message,
      style: UIUtils().getTextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColor.whiteColor,
      ),
    );

    final snackBar = SnackBar(
      content: text,
      backgroundColor: AppColor.darkTextColor,
      duration: Duration(seconds: duration),
      action: action,
    );

    // Remove Current sanckbar if viewed
    _key.currentState.removeCurrentSnackBar();
    _key.currentState.showSnackBar(snackBar);
  }

  static void showSnackBarWithContext(BuildContext context, String message, {int duration = 1, SnackBarAction action}) {
    final text = Text(
      message,
      style: UIUtils().getTextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColor.whiteColor,
      ),
    );

    final snackBar = SnackBar(
      content: text,
      backgroundColor: AppColor.darkTextColor,
      duration: Duration(seconds: duration),
      action: action,
    );

    // Remove Current SnackBar if viewed
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }

  //region Internet Check
  static bool isInternetAvailable(GlobalKey<ScaffoldState> key, {bool isInternetMessageRequire = true}) {
    bool isInternet = Reachability().isInterNetAvaialble();
    if (!isInternet && isInternetMessageRequire) {
      Utils.showSnackBar(key, Translations.of(key.currentContext).msgInternetMessage);
    }
    return isInternet;
  }

  //endregion

  //region Bottom sheet in IOs
  static showBottomSheet(BuildContext _context, {String title = '', String message = '', List<String> arrButton, AlertWidgetButtonActionCallback callback}) {
    final titlewidget = (title.length > 0)
        ? Text(
            title,
      style: UIUtils().getTextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColor.darkTextColor),
          )
        : null;
    final messsagewidget = (message.length > 0)
        ? Text(
            message,
            style: UIUtils().getTextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: AppColor.darkTextColor),
          )
        : null;

    void onButtonPressed(String btnTitle) {
      int index = arrButton.indexOf(btnTitle) ?? -1;
      //dismiss Diloag
      Navigator.of(_context).pop();

      // Provide callback
      if (callback != null) {
        callback(index);
      }
    }

    List<Widget> actions = [];

    for (String str in arrButton) {
      bool isDistructive = (str.toLowerCase() == "delete") || (str.toLowerCase() == "no");
      actions.add(CupertinoDialogAction(
        child: Container(
          child: Text(
            str,
            style: UIUtils().getTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: AppColor.darkTextColor,
            ),
          ),
          alignment: Alignment.center,
          height: UIUtils().getProportionalWidth(44.0),
        ),
        onPressed: () => onButtonPressed(str),
        isDestructiveAction: isDistructive,
      ));
    }

    final cancelAciton = CupertinoDialogAction(
      onPressed: () => onButtonPressed('Cancel'),
      child: Text(
        'Cancel',
        style: UIUtils().getTextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: AppColor.cancelRedColor),
      ),
    );
    final actionSheet = CupertinoActionSheet(
      title: titlewidget,
      message: messsagewidget,
      actions: actions,
      cancelButton: cancelAciton,
    );

    Route.showCupertinoModalPopup(context: _context, builder: (BuildContext context) => actionSheet).then((result) {
      print("Result :: $result");
    });
  }

  //endregion

  //region Progress Dialog
  static void showProgressDialog(BuildContext context) {
    Logger().v("DisPlay Loader");
    showDialog(
      barrierDismissible: false,
      // barrierColor: Colors.transparent,
      context: context,
      builder: (context) => ProgressDialog(),
    );
  }

  static Future dismissProgressDialog(BuildContext context) async {
    /// This Delay Added due to loader open or not
    await Future.delayed(Duration(milliseconds: 100));
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    return null;
  }

//endregion

}
