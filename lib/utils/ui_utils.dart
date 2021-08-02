import 'dart:math';
import 'package:flutter/material.dart';
import 'app_font.dart';
import 'logger.dart';

class UIUtils {
  factory UIUtils() {
    return _singleton;
  }

  static final UIUtils _singleton = UIUtils._internal();

  UIUtils._internal() {
    Logger().v("Instance created UIUtills");
  }

  //region Screen Size and Proportional according to device
  double _screenHeight;
  double _screenWidth;

  double  mediaqueryScreenHeight(context) => MediaQuery.of(context).size.height;
  double  mediaqueryScreenWidth(context) => MediaQuery.of(context).size.width;

  double get screenHeight => _screenHeight ?? _referenceScreenHeight;

  double get screenWidth => _screenWidth ?? _referenceScreenWidth;

  final double _referenceScreenHeight = 812;
  final double _referenceScreenWidth = 375;

  void updateScreenDimension({double width, double height}) {
    if (_screenWidth != null && _screenHeight != null) {
      return;
    }

    Logger().v("Update Screen Dimension");

    _screenWidth = (width != null) ? width : _screenWidth;
    _screenHeight = (height != null) ? height : _screenHeight;
  }

  double get getNavBarSize => min(UIUtils().getProportionalHeight(44.0), 44.0);
  double getProportionalHeight(double height) {
    if (_screenHeight == null) return height;
    final h = _screenHeight * height / _referenceScreenHeight;
    return h.floorToDouble();
  }

  double getProportionalWidth(double width) {
    if (_screenWidth == null) return width;
    final w = _screenWidth * width / _referenceScreenWidth;
    return w.floorToDouble();
  }
  //endregion

  TextStyle getTextStyle(
      {String fontFamily = 'GoogleSans',
      int fontSize,
      Color color,
      FontWeight fontWeight,
      bool isFixed = false,
      double characterSpacing,
      double wordSpacing,
      double lineSpacing}) {
    double finalFontSize = (fontSize ?? 12).toDouble();

    if (!isFixed && this._screenWidth != null) {
      finalFontSize = (finalFontSize * _screenWidth) / _referenceScreenWidth;
    }
    return TextStyle(
      fontSize: finalFontSize,
      fontFamily: fontFamily ?? AppFont.googleSans,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      letterSpacing: characterSpacing,
      wordSpacing: wordSpacing,
      height: lineSpacing,
    );
  }
}
