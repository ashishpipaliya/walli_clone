import 'package:rxdart/rxdart.dart';
import 'package:wall_hunt/bloc/base_bloc.dart';
import 'package:wall_hunt/service/all_request.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/response/model/rectangle_wallpaper_model.dart';
import 'package:wallpaper/wallpaper.dart';

class OpenImageDetailsBloc extends BaseBloc {
  String wallId;
  RectangleWallPaper wallpaper;
  bool isApiResponseReceived = false;

  RectangleWallPaper _wall = RectangleWallPaper();

  RectangleWallPaper get walls => _wall ?? RectangleWallPaper();
  PublishSubject<RectangleWallResponse> _wallsSubject = PublishSubject<RectangleWallResponse>();

  Stream<RectangleWallResponse> get wallsStream => _wallsSubject.stream;

  Future categoryWiseWallsApi() async {
    RectangleWallRequest request = RectangleWallRequest();
    request.id = wallId;
    RectangleWallResponse response = await repository.rectangleWallApi(request: request);
    if (response.status == 200) {
      wallpaper = response.data;
    }
    isApiResponseReceived = true;
    _wallsSubject.sink.add(response);
  }

  // double downloadedPercent = 0.0;
  // String get progress => (downloadedPercent * 100).toString() + '%';

  // PublishSubject<String> _progressSub = PublishSubject<String>();
  //
  // Stream<String> get progressStream => _progressSub.stream;
  //
  // String get progress => (downloadedPercent * 100).toString() + '%';
  //
  // void getProgress() {
  //   _progressSub.sink.add(progress);
  // }

  String home = "Home Screen";
  PublishSubject<String> _progress = PublishSubject<String>();

  Stream<String> get progress => _progress.stream;
  bool downloading = false;

  Future<void> getProgress() async {
    _progress =  Wallpaper.ImageDownloadProgress(wallpaper?.image);
  }

  @override
  void dispose() {
    _wallsSubject.close();
    _progress.close();
    super.dispose();
  }
}
