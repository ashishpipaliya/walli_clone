import 'package:rxdart/rxdart.dart';
import 'package:wall_hunt/service/all_request.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/api_constant.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';

import 'base_bloc.dart';

class WallsListBloc extends BaseBloc {
  bool isApiResponseReceived = false;
  int totalPage = 0;
  bool isLoadMore = false;
  bool isLoadMorePending = false;
  List<WallsModel> _wallsList = <WallsModel>[];

  int tabIndex;

  List<WallsModel> get wallsList => _wallsList ?? <WallsModel>[];
  PublishSubject<WallsResponse> _wallsSubject = PublishSubject<WallsResponse>();

  Stream<WallsResponse> get wallsStream => _wallsSubject.stream;

  ApiType get apiType {
    if (tabIndex == 1) {
      return ApiType.featured;
    } else if (tabIndex == 2) {
      return ApiType.recent;
    } else if (tabIndex == 3) {
      return ApiType.popular;
    }
    return ApiType.featured;
  }

  Future wallsListApi({int page}) async {
    WallsRequest request = WallsRequest();
    request.page = page;
    request.perPage = defaultFetchLimit;
    WallsResponse response =
        await repository.wallsApi(request: request, apiType: apiType);
    if (response.status == 200) {
      if (page == 0) {
        _wallsList.clear();
      }
      _wallsList.addAll(response.data ?? <WallsModel>[]);
      isLoadMore = totalPage > (page + 1);
    }
    isApiResponseReceived = true;
    isLoadMorePending = false;
    _wallsSubject.sink.add(response);
  }

  @override
  void dispose() {
    _wallsSubject.close();
    super.dispose();
  }

  downloadWallRectangle(int id) async {}
}
