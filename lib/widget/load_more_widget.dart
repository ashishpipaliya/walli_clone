import 'package:flutter/material.dart';
import 'package:wall_hunt/utils/app_color.dart';
import 'package:wall_hunt/utils/ui_utils.dart';

class LoadMoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: UIUtils().getProportionalWidth(20),
        width: UIUtils().getProportionalWidth(20),
        margin: EdgeInsets.only(
          bottom: UIUtils().getProportionalWidth(10),
        ),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: new AlwaysStoppedAnimation<Color>(AppColor.loginButtonColor),
        ),
      ),
    );
  }
}
