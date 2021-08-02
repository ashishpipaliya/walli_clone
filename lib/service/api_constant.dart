import 'dart:io';

import 'package:tuple/tuple.dart';

import '../utils/logger.dart';

enum ApiType {
  recent,
  featured,
  popular,
  random,
  categories,
  categoryWiseWalls,
  rectangleWallpaper,
}

class PreferenceKey {
  static String storeToken = "UserToken";
  static String storeUser = "UserDetail";
}

class ApiConstant {
  static String get appleAppId => '';

  static String get androidAppId => '';

  static String get googlePlacesKey => '';

  static String get baseDomain => 'https://walli-api-lime.vercel.app'; // Production

  // static String get apiVersion => '/v1/';
  // static String get apiVersion => '/';

  static String getValue(ApiType type) {
    switch (type) {
      case ApiType.featured:
        return '/wallpaper?type=featured&';
      case ApiType.recent:
        return '/wallpaper?type=recent&';
      case ApiType.popular:
        return '/wallpaper?type=popular&';
      case ApiType.categories:
        return '/categories';
      case ApiType.categoryWiseWalls:
        return '/category';
        case ApiType.rectangleWallpaper:
      return '/rectangle_wall';
      default:
        return "";
    }
  }

  /*
  * Tuple Sequence
  * - Url
  * - Header
  * - params
  * - files
  * */
  static Tuple4<String, Map<String, String>, Map<String, dynamic>, List<AppMultiPartFile>> requestParamsForSync(ApiType type,
      {Map<String, dynamic> params, List<AppMultiPartFile> arrFile = const [], String urlParams, bool isFormDataApi = false}) {
    // String apiUrl = ApiConstant.baseDomain + ApiConstant.apiVersion + ApiConstant.getValue(type);
    String apiUrl = ApiConstant.baseDomain + ApiConstant.getValue(type);

    if (urlParams != null) apiUrl = apiUrl + urlParams;

    Map<String, dynamic> paramsFinal = params ?? Map<String, dynamic>();
    Map<String, String> headers = Map<String, String>();
    //headers['Content-Type'] = isFormDataApi ? 'multipart/form-data' : 'application/json';
    // if ((Token.currentToken.idToken ?? '').isNotEmpty) {
    //   headers['Authorization'] = Token.currentToken.token;
    // }

    Logger().d("Request Url :: $apiUrl");
    Logger().d("Request Params :: $paramsFinal");
    Logger().d("Request headers :: $headers");

    return Tuple4(apiUrl, headers, paramsFinal, arrFile);
  }
}

class ResponseKeys {
  static String kMessage = 'message';
  static String kTitle = 'title';
  static String kStatus = 'status';
  static String kData = 'data';
}

class HttpResponse {
  int status;
  String errMessage;
  dynamic data;
  dynamic mainResponse;
  bool failDueToToken;

  HttpResponse({this.status, this.errMessage, this.data, this.mainResponse, this.failDueToToken = false});
}

class AppMultiPartFile {
  List<File> localFiles;
  String key;

  AppMultiPartFile({this.localFiles, this.key});
}
