import 'package:flutter/material.dart';
import 'package:wall_hunt/utils/app_color.dart';
import 'package:wall_hunt/utils/app_font.dart';
import 'package:wall_hunt/utils/ui_utils.dart';

class EmptyListWidget extends StatelessWidget {
  final String title;

  EmptyListWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: UIUtils().getTextStyle(
            color: AppColor.darkTextColor,
            fontSize: 16,
            fontFamily: AppFont.googleSans,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
