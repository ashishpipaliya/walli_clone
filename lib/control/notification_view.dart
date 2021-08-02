import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../localization/localization.dart';
import '../utils/app_color.dart';
import '../utils/enum.dart';
import '../utils/ui_utils.dart';

class NotificationView extends StatelessWidget {
  final String title;
  final String subTitle;
  final NotificationOViewCallback onTap;

  NotificationView({this.title = "", this.subTitle = "", this.onTap});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Material(
        color: Colors.white,
        child: SafeArea(
          child: GestureDetector(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: UIUtils().getProportionalWidth(15.0),
                      left: UIUtils().getProportionalWidth(16.0),
                      right: UIUtils().getProportionalWidth(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              child: Image.network(
                                "https://moddroid.com/wp-content/uploads/2020/01/walli-mod-premium-moddroid.png",
                                width: UIUtils().getProportionalWidth(20.0),
                                height: UIUtils().getProportionalWidth(20.0),
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            SizedBox(
                              width: UIUtils().getProportionalWidth(6.0),
                            ),
                            Text(
                              Translations.of(context).appName,
                              style: UIUtils().getTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColor.darkTextColor,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: UIUtils().getProportionalWidth(6.0))),
                        Text(
                          this.title,
                          style: UIUtils().getTextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColor.darkTextColor,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: UIUtils().getProportionalWidth(6.0))),
                        Text(
                          this.subTitle,
                          style: UIUtils().getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColor.darkTextColor,
                          ),
                          maxLines: 3,
                        ),
                        Padding(padding: EdgeInsets.only(top: UIUtils().getProportionalWidth(10.0))),
                      ],
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              color: Colors.transparent,
              width: double.infinity,
            ),
            onTap: () {
              if (this.onTap != null) {
                this.onTap(true);
              }
            },
          ),
          bottom: false,
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          child: SafeArea(
            child: Container(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            "https://moddroid.com/wp-content/uploads/2020/01/walli-mod-premium-moddroid.png",
                            width: UIUtils().getProportionalWidth(20.0),
                            height: UIUtils().getProportionalWidth(20.0),
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        SizedBox(
                          width: UIUtils().getProportionalWidth(6.0),
                        ),
                        Text(
                          Translations.of(context).appName,
                          style: UIUtils().getTextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColor.darkTextColor,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: UIUtils().getProportionalWidth(6.0))),
                    Text(
                      this.title,
                      style: UIUtils().getTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColor.darkTextColor,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 6)),
                    Text(
                      this.subTitle,
                      style: UIUtils().getTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColor.darkTextColor,
                      ),
                      maxLines: 3,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)), color: AppColor.whiteColor.withAlpha(200), boxShadow: kElevationToShadow[2]),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)), color: AppColor.whiteColor, boxShadow: kElevationToShadow[2]),
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
            ),
            bottom: false,
          ),
          onTap: () {
            if (this.onTap != null) {
              this.onTap(true);
            }
          },
        ),
      );
    }
  }
}
