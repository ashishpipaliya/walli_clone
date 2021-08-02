import 'dart:math';
import 'package:tuple/tuple.dart';
import '../logger.dart';

extension PreciseExtensions on double {
  String convertPreciseToString() {
    if (this.toInt().toDouble() == this) {
      return this.toStringAsFixed(0);
    } else {
      double newVal = this * 10.0;
      if (newVal.toInt().toDouble() == newVal) {
        return this.toStringAsFixed(1);
      } else {
        return this.toStringAsFixed(2);
      }
    }
  }
}

extension IntExtension on int {
  String convertToDays() {
    return (this > 1) ? "$this days" : "$this day";
  }

  String convertToHours() {
    return (this > 1) ? "$this hours" : "$this hour";
  }

  String convertToMins() {
    return (this > 1) ? "$this mins" : "$this min";
  }

  String convertToSec() {
    return "$this sec";
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String convertToUSAPhoneNumber() {

    if (this.length == 0) { return this; }

    if (this.length > 0 && this.contains('(')) {
        return this;
    }
    String updatedStr = (this.length > 10) ? this.substring(0, 10) : this;
    updatedStr = updatedStr.replaceAll("-", "");


    int usedSubstringIndex = 0;
    final int newTextLength = updatedStr.length;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 4) {
      newText.write(updatedStr.substring(0, usedSubstringIndex = 3) + '-');
    }
    if (newTextLength >= 7) {
      newText.write(updatedStr.substring(3, usedSubstringIndex = 6) + '-');
    }
    if (newTextLength >= 11) {
      newText.write(updatedStr.substring(6, usedSubstringIndex = 10) + '-');
    }
    if (newTextLength >= usedSubstringIndex) { // Dump the rest.
      newText.write(updatedStr.substring(usedSubstringIndex));
    }

    return newText.toString();
  }

  String convertToPhoneNumber() {

    String updatedStr = this.replaceAll("-", "");
    return updatedStr;
  }

  Tuple2<int, int> decodeInchFootConvert() {

    if (this.length == 0) { return Tuple2(0, 0); }
    Logger().v("${this}");
    String updatedStr = this.replaceAll(" Ft", "");
    updatedStr = updatedStr.replaceAll("In", "");

    List<String> arr = updatedStr.split("'");
    return Tuple2(int.tryParse(arr[0]) ?? 0, int.tryParse(arr[1]) ?? 0);
  }

  String encodeInchFootConvert() {

    if (this.length == 0) { return ''; }

//    List<String> arr = this.split("-");
//    if (arr.length == 1) {
//      return "${arr[0]} Ft-00 In";
//    }
//    else {
//      return "${arr[0]} Ft-${arr[1]} In";
//    }

    List<String> arr = this.split("-");
    if (arr.length == 1) {
      return "${arr[0]}";
    }
    else {
      return "${arr[0]}'${arr[1]}''";
    }

  }
}

class Uuid {
  final Random _random = new Random();

  /// Generate a version 4 (random) uuid. This is a uuid scheme that only uses
  /// random numbers as the source of the generated uuid.
  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}