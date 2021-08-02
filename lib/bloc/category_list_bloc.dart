import 'package:rxdart/rxdart.dart';
import 'package:wall_hunt/bloc/base_bloc.dart';
import 'package:wall_hunt/service/all_request.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/response/model/category_list_model.dart';

class CategoryListBloc extends BaseBloc {
  bool isApiResponseReceived = false;
  int totalPage = 0;
  bool isLoadMore = false;
  bool isLoadMorePending = false;

  List<CategoryListModel> _categoryList = <CategoryListModel>[];

  List<CategoryListModel> get categoryList => _categoryList ?? <CategoryListModel>[];

  PublishSubject<CategoryListResponse> _categoryListSubject = PublishSubject<CategoryListResponse>();

  Stream<CategoryListResponse> get categoryListStream => _categoryListSubject.stream;

  Future<void> categoryListApi({int page = 1}) async {
    CategoryListRequest request = CategoryListRequest();

    request.page = page.toString();
    CategoryListResponse response = await repository.getCategoryListApi(request: request);
    if (response.status == 200) {
      if (page == 0) {
        _categoryList.clear();
      }
      totalPage = 6;
      _categoryList.addAll(response.data ?? <CategoryListModel>[]);
      isLoadMore = totalPage > (page + 1);
    }
    isApiResponseReceived = true;
    isLoadMorePending = false;

    _categoryListSubject.sink.add(response);
  }

  @override
  void dispose() {
    _categoryListSubject?.close();
    super.dispose();
  }
}
