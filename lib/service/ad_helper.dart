import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId1 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8085579054533151/5147198243';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8085579054533151/9981318999';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId1 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8085579054533151/6397297206';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId2 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8085579054533151/6014153829';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId3 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8085579054533151/1883337126';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     // return 'ca-app-pub-3940256099942544/8673189370';
  //   } else {
  //     throw new UnsupportedError('Unsupported platform');
  //   }
  // }
}
