import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/ui_utils.dart';
import '../utils/app_color.dart';

class ProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SpinKitWave(
          // color: AppColor.blackTextColor,
          color: AppColor.whiteColor,
          size: UIUtils().screenWidth * 0.08,
        ),
        onWillPop: this._onBackSpace);
  }

  Future<bool> _onBackSpace() async {
    return false;
  }
}
