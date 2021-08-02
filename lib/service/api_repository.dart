import 'package:wall_hunt/service/api_constant.dart';

import 'all_request.dart';
import 'all_response.dart';
import 'api_provider.dart';

class AppRepository {
  final apiProvider = ApiProvider();

  Future<WallsResponse> wallsApi({WallsRequest request, ApiType apiType}) => apiProvider.wallsApi(request: request, apiType: apiType);

  Future<CategoryListResponse> getCategoryListApi({CategoryListRequest request}) => apiProvider.getCategoryListApi(request: request);

  Future<WallsResponse> categoryWiseWallsApi({WallsRequest request}) => apiProvider.categoryWiseWallsApi(request: request);

  Future<RectangleWallResponse> rectangleWallApi({RectangleWallRequest request}) => apiProvider.rectangleWallApi(request: request);
}
