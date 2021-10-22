import 'dart:async';
import 'dart:convert';
import 'dart:io' show File;

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:wall_hunt/service/response/model/category_list_model.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';
import 'package:wall_hunt/service/response/model/rectangle_wallpaper_model.dart';

import '../localization/localization.dart';
import '../utils/logger.dart';
import '../utils/navigation/navigation_service.dart';
import 'all_request.dart';
import 'all_response.dart';
import 'api_constant.dart';
import 'reachability.dart';

class ApiProvider {
  CancelToken lastRequestToken;

  factory ApiProvider() {
    return _singleton;
  }

  final Dio dio = new Dio();
  static final ApiProvider _singleton = ApiProvider._internal();

  ApiProvider._internal() {
    Logger().v("Instance created ApiProvider");
    // Setting up connection and response time out
    dio.options.connectTimeout = 60 * 1000;
    dio.options.receiveTimeout = 60 * 1000;
    //dio.options.contentType = 'application/json';
  }

  HttpResponse _handleNetworkSuccess({Response<dynamic> response}) {
    dynamic jsonResponse = response.data;

    Logger().v("Response Status code:: ${response.statusCode}");
    Logger().v("response body :: $jsonResponse");

    final message = (jsonResponse is Map)
        ? jsonResponse[ResponseKeys.kMessage] ??
            (jsonResponse[ResponseKeys.kTitle] ?? '')
        : '';
    final status = (jsonResponse is Map)
        ? jsonResponse[ResponseKeys.kStatus] ?? response.statusCode
        : response.statusCode;
    final data =
        (jsonResponse is Map) ? jsonResponse[ResponseKeys.kData] : null;
    if (response.statusCode >= 200 && response.statusCode < 299) {
      return HttpResponse(
          status: status,
          errMessage: message,
          data: data,
          mainResponse: jsonResponse);
    } else {
      var errMessage = jsonResponse[ResponseKeys.kMessage] ??
          (jsonResponse[ResponseKeys.kTitle] ?? '');
      return HttpResponse(
          status: status, errMessage: errMessage, mainResponse: jsonResponse);
    }
  }

  Future<HttpResponse> _handleDioNetworkError(
      {DioError error, ApiType apiType}) async {
    Logger().v("Error Details :: ${error.message}");

    if ((error.response == null) || (error.response.data == null)) {
      String errMessage =
          Translations.of(NavigationService().context).msgSomethingWrong;
      return HttpResponse(
        status: 500,
        errMessage: errMessage,
      );
    } else {
      Logger().v("Error Details :: ${error.response.data}");
      dynamic jsonResponse = getErrorData(error);
      if (jsonResponse is Map) {
        final status = jsonResponse[ResponseKeys.kStatus] ?? 400;
        String errMessage = jsonResponse[ResponseKeys.kTitle] ??
            (jsonResponse[ResponseKeys.kMessage] ??
                Translations.of(NavigationService().context).msgSomethingWrong);
        return HttpResponse(
          status: status,
          errMessage: errMessage,
        );
      } else {
        return HttpResponse(
          status: 500,
          errMessage:
              Translations.of(NavigationService().context).msgSomethingWrong,
        );
      }
    }
  }

  Map getErrorData(DioError error) {
    if (error.response.data is Map) {
      return error.response.data;
    } else if (error.response.data is String) {
      return json.decode(error.response.data);
    }
    return null;
  }

  Future<HttpResponse> getRequest(ApiType apiType,
      {Map<String, String> params, String urlParam}) async {
    if (!Reachability().isInterNetAvaialble()) {
      return HttpResponse(
          status: 101,
          errMessage:
              Translations.of(NavigationService().context).msgInternetMessage);
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType,
        params: params, urlParams: urlParam);

    final option = Options(headers: requestFinal.item2);
    try {
      final response = await this.dio.get(requestFinal.item1,
          queryParameters: requestFinal.item3, options: option);
      return _handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await this._handleDioNetworkError(error: error);
      if (result.failDueToToken ?? false) {
        return this.getRequest(apiType, params: params, urlParam: urlParam);
      }
      return result;
    }
  }

  Future<HttpResponse> postRequest(ApiType apiType,
      {Map<String, dynamic> params, String urlParams}) async {
    if (!Reachability().isInterNetAvaialble()) {
      return HttpResponse(
          status: 101,
          errMessage:
              Translations.of(NavigationService().context).msgInternetMessage);
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType,
        params: params, urlParams: urlParams);
    final option = Options(headers: requestFinal.item2);
    this.lastRequestToken = CancelToken();
    try {
      final response = await this.dio.post(requestFinal.item1,
          data: json.encode(requestFinal.item3),
          options: option,
          cancelToken: this.lastRequestToken);
      return this._handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await this._handleDioNetworkError(error: error);
      if (result.failDueToToken ?? false) {
        return this.postRequest(apiType, params: params, urlParams: urlParams);
      }
      return result;
    }
  }

  Future<HttpResponse> deleteRequest(ApiType apiType,
      {Map<String, dynamic> params, String urlParams}) async {
    if (!Reachability().isInterNetAvaialble()) {
      return HttpResponse(
          status: 101,
          errMessage:
              Translations.of(NavigationService().context).msgInternetMessage);
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType,
        params: params, urlParams: urlParams);
    final option = Options(headers: requestFinal.item2);
    this.lastRequestToken = CancelToken();
    try {
      final response = await this.dio.delete(requestFinal.item1,
          data: json.encode(requestFinal.item3),
          options: option,
          cancelToken: this.lastRequestToken);
      return this._handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await this._handleDioNetworkError(error: error);
      if (result.failDueToToken ?? false) {
        return this
            .deleteRequest(apiType, params: params, urlParams: urlParams);
      }
      return result;
    }
  }

  Future<HttpResponse> putRequest(ApiType apiType,
      {Map<String, dynamic> params, String urlParam}) async {
    if (!Reachability().isInterNetAvaialble()) {
      return HttpResponse(
          status: 101,
          errMessage:
              Translations.of(NavigationService().context).msgInternetMessage);
    }

    final requestFinal = ApiConstant.requestParamsForSync(
      apiType,
      params: params,
    );

    final option = Options(headers: requestFinal.item2);
    this.lastRequestToken = CancelToken();
    try {
      final response = await this.dio.put(requestFinal.item1,
          data: json.encode(requestFinal.item3),
          options: option,
          cancelToken: this.lastRequestToken);
      return this._handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await this._handleDioNetworkError(error: error);
      if (result.failDueToToken ?? false) {
        return this.putRequest(
          apiType,
          params: params,
        );
      }
      return result;
    }
  }

  Future<HttpResponse> putFormDataRequest(ApiType apiType,
      {Map<String, dynamic> params,
      List<AppMultiPartFile> arrFile = const [],
      String urlParam}) async {
    if (!Reachability().isInterNetAvaialble()) {
      return HttpResponse(
          status: 101,
          errMessage:
              Translations.of(NavigationService().context).msgInternetMessage);
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType,
        params: params, arrFile: arrFile, isFormDataApi: true);

    // Create form data Request
    FormData formData = new FormData.fromMap(Map<String, dynamic>());

    MultipartFile mFile =
        MultipartFile.fromBytes(utf8.encode(json.encode(requestFinal.item3)),
            contentType: MediaType(
              'application',
              'json',
              {'charset': 'utf-8'},
            ));
    formData.files.add(MapEntry('requestDTO', mFile));

    /* Adding File Content */
    for (AppMultiPartFile partFile in requestFinal.item4) {
      for (File file in partFile.localFiles) {
        Logger().v("File Path :: ${file.path}");
        String filename = basename(file.path);
        String mineType = lookupMimeType(filename);
        if (mineType == null) {
          MultipartFile mFile = await MultipartFile.fromFile(
            file.path,
            filename: filename,
          );
          formData.files.add(MapEntry(partFile.key, mFile));
        } else {
          MultipartFile mFile = await MultipartFile.fromFile(file.path,
              filename: filename,
              contentType: MediaType(
                  mineType.split("/").first, mineType.split("/").last));
          formData.files.add(MapEntry(partFile.key, mFile));
        }
      }
    }

    final option = Options(headers: requestFinal.item2);
    try {
      final response = await this.dio.put(requestFinal.item1,
          data: formData,
          options: option,
          onSendProgress: (sent, total) =>
              Logger().v("uploadFile ${sent / total}"));
      return this._handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await this._handleDioNetworkError(error: error);
      if (result.failDueToToken ?? false) {
        return this.putRequest(
          apiType,
          params: params,
        );
      }
      return result;
    }
  }

  Future<HttpResponse> uploadRequest(ApiType apiType,
      {Map<String, dynamic> params,
      List<AppMultiPartFile> arrFile,
      String urlParam}) async {
    if (!Reachability().isInterNetAvaialble()) {
      final httpResonse = HttpResponse(
          status: 101,
          errMessage:
              Translations.of(NavigationService().context).msgInternetMessage);
      return httpResonse;
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType,
        params: params, arrFile: arrFile ?? List<AppMultiPartFile>());

    // Create form data Request
    FormData formData = new FormData.fromMap(requestFinal.item3);

    /* Adding File Content */
    for (AppMultiPartFile partFile in requestFinal.item4) {
      for (File file in partFile.localFiles) {
        Logger().v("File Path :: ${file.path}");
        String filename = basename(file.path);
        String mineType = lookupMimeType(filename);
        if (mineType == null) {
          MultipartFile mFile = await MultipartFile.fromFile(
            file.path,
            filename: filename,
          );
          formData.files.add(MapEntry(partFile.key, mFile));
        } else {
          MultipartFile mFile = await MultipartFile.fromFile(file.path,
              filename: filename,
              contentType: MediaType(
                  mineType.split("/").first, mineType.split("/").last));
          formData.files.add(MapEntry(partFile.key, mFile));
        }
      }
    }

    /* Create Header */
    final option = Options(headers: requestFinal.item2);

    try {
      final response = await this.dio.post(requestFinal.item1,
          data: formData,
          options: option,
          onSendProgress: (sent, total) =>
              Logger().v("uploadFile ${sent / total}"));
      return this._handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await this._handleDioNetworkError(error: error);
      if (result.failDueToToken ?? false) {
        return this.uploadRequest(apiType,
            params: params, arrFile: arrFile, urlParam: urlParam);
      }
      return result;
    }
  }
}

extension WallsApiProvider on ApiProvider {
  Future<WallsResponse> wallsApi(
      {WallsRequest request, ApiType apiType}) async {
    final HttpResponse response =
        await this.getRequest(apiType, params: request.toJson());
    List<WallsModel> wallpaperList;
    if (response.status == 200) {
      wallpaperList = WallsModel.createFromList(response.mainResponse);
    }
    return WallsResponse(
        status: response.status,
        message: response.errMessage,
        data: wallpaperList);
  }

  Future<CategoryListResponse> getCategoryListApi(
      {CategoryListRequest request}) async {
    final HttpResponse response =
        await this.getRequest(ApiType.categories, params: request.toJson());
    List<CategoryListModel> categoryList;
    if (response.status == 200) {
      categoryList = CategoryListModel.createFromList(response.mainResponse);
    }
    return CategoryListResponse(
        status: response.status,
        message: response.errMessage,
        data: categoryList);
  }

  Future<WallsResponse> categoryWiseWallsApi({WallsRequest request}) async {
    final HttpResponse response = await this
        .getRequest(ApiType.categoryWiseWalls, params: request.toJson());
    List<WallsModel> wallpaperList;
    if (response.status == 200) {
      wallpaperList = WallsModel.createFromList(response.mainResponse);
    }
    return WallsResponse(
        status: response.status,
        message: response.errMessage,
        data: wallpaperList);
  }

  Future<RectangleWallResponse> rectangleWallApi(
      {RectangleWallRequest request}) async {
    final HttpResponse response = await this
        .getRequest(ApiType.rectangleWallpaper, params: request.toJson());
    RectangleWallPaper wallPaper;
    if (response.status == 200) {
      wallPaper = RectangleWallPaper.fromJson(response.mainResponse);
    }
    return RectangleWallResponse(
        status: response.status, message: response.errMessage, data: wallPaper);
  }
}
