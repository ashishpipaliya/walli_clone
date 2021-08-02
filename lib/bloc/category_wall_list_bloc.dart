import 'package:rxdart/rxdart.dart';
import 'package:wall_hunt/bloc/base_bloc.dart';
import 'package:wall_hunt/service/all_request.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';

class CategoryWallListBloc extends BaseBloc{

  bool isApiResponseReceived = false;
  int totalPage = 0;
  bool isLoadMore = false;
  bool isLoadMorePending = false;
  List<WallsModel> _wallsList = <WallsModel>[];

  String categoryId;

  List<WallsModel> get wallsList => _wallsList ?? <WallsModel>[];
  PublishSubject<WallsResponse> _wallsSubject = PublishSubject<WallsResponse>();

  Stream<WallsResponse> get wallsStream => _wallsSubject.stream;


  Future categoryWiseWallsApi({int page}) async {

    WallsRequest request = WallsRequest();
    request.page = page;
    request.perPage = defaultFetchLimit;
    request.id = categoryId;
    WallsResponse response = await repository.categoryWiseWallsApi(request: request);
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