import 'package:wall_hunt/service/response/model/category_list_model.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';
import 'package:wall_hunt/service/response/model/rectangle_wallpaper_model.dart';

class BaseResponse extends Object {
  int status;
  String message;

  BaseResponse({this.status, this.message});
}

class WallsResponse {
  int status;
  String message;
  List<WallsModel> data;

  WallsResponse({this.status, this.message, this.data});
}

class CategoryListResponse {
  int status;
  String message;
  List<CategoryListModel> data;

  CategoryListResponse({this.status, this.message, this.data});
}

class RectangleWallResponse {
  int status;
  String message;
  RectangleWallPaper data;

  RectangleWallResponse({this.status, this.message, this.data});
}
