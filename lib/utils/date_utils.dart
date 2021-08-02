import 'dart:core';
import 'package:intl/intl.dart';
import 'logger.dart';

class AppDateFormat {
  static String serverDateTimeFormat1 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static String serverDateTimeFormat2 = "yyyy-MM-dd HH:mm:ss";
  static String serverDateTimeFormat3 = "yyyy-MM-dd'T'HH:mm:ss'Z'";
  static String filterUIDateFormat = "MMM dd,yyyy HH:mm";
  static String notificationDateFormat1 = "E MM/dd";

  static String graphDateFormat = "MM/dd HH:mm";
  static String graphDayDateFormat = "dd MMM";
  static String recentDateFormat = "MM/dd/yyyy hh:mm:ss a";
  static String daysFormat = "MM/dd";
  static String hoursFormat = "HH:mm";
  static String hoursAMPMFormat = "hh:mm a";
  static String customerLogFormat = "MM/dd/yyyy";

  static String hoursMonthDateFormat = "hh:mm a; MMM dd, yyyy";
}

class DateUtils {
  //region Date Conversation
  static String dateToString(DateTime date, {String format}) {
    DateFormat formatter = DateFormat(format);
    if (date != null) {
      try {
        return formatter.format(date);
      } catch (e) {
        Logger().v('Error formatting date: $e');
      }
    }
    return '';
  }
  //endregion

  static DateTime stringToDate(String string, {String format, bool isUTCtime = true}) {
    DateFormat formatter = DateFormat(format);
    if (string?.isNotEmpty ?? false) {
      try {
        var convertedDate = formatter.parse(string);
        if (isUTCtime) {
          convertedDate = convertedDate.add(DateTime.now().timeZoneOffset);
        }
        return convertedDate;
      } catch (e) {}
    }
    return null;
  }

  static DateTime stringToDateInLocal(String string) {
    if (string?.isNotEmpty ?? false) {
      try {
        var convertedDate = (string.contains('Z')) ? DateTime.parse(string) : DateTime.parse(string + 'Z');
        return convertedDate.toLocal();
      } catch (e) {}
    }
    return DateTime.now();
  }
}
