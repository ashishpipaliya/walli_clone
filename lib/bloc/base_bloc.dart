import '../service/api_repository.dart';

class BaseBloc extends Object {
  final repository = AppRepository();
  int get defaultFetchLimit => 24;
  int get defaultCategoryFetchLimit => 10;

  void dispose() {
    // print('------------------- ${this} Dispose ------------------- ');
  }
}
