import 'dart:async';
import 'dart:typed_data';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';
import 'package:wall_hunt/bloc/open_image_details_bloc.dart';
import 'package:wall_hunt/service/ad_helper.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';
import 'package:wall_hunt/utils/app_color.dart';
import 'package:wall_hunt/utils/channel/platform_channel.dart';
import 'package:wall_hunt/utils/ui_utils.dart';
import 'package:wall_hunt/utils/utils.dart';
import 'package:wallpaper/wallpaper.dart';

class OpenImageDetail extends StatefulWidget {
  final WallsModel wallsModel;

  const OpenImageDetail({@required this.wallsModel});

  @override
  _OpenImageDetailState createState() => _OpenImageDetailState();
}

class _OpenImageDetailState extends State<OpenImageDetail> with AfterLayoutMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  OpenImageDetailsBloc _bloc = OpenImageDetailsBloc();

  StreamSubscription<RectangleWallResponse> _wall;

// TODO move this in bloc
  Stream<String> progressString;
  String res = 'Downloading..';
  bool downloading = false;

  //************

  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  InterstitialAd _interstitialAd1;
  InterstitialAd _interstitialAd2;
  InterstitialAd _interstitialAd3;
  bool _isInterstitialAd1Ready = false;
  bool _isInterstitialAd2Ready = false;
  bool _isInterstitialAd3Ready = false;

  RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

  @override
  void initState() {
    _bloc.wallId = widget.wallsModel.id;
    _wall = _bloc.wallsStream.listen((response) async {
      if (response.status != 200) {
        Utils.showSnackBar(_key, response.message);
      }
    });

    _loadBannerAd2();
    _loadInterstitialAd1();
    // _loadRewardedAd();
    Timer(Duration(seconds: 5), () {
      if (_isInterstitialAd1Ready) {
        _interstitialAd1?.show();
      } else {
        print('ad is not ready');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _wall?.cancel();
    _bloc.dispose();
    _bannerAd?.dispose();
    _interstitialAd1?.dispose();
    _interstitialAd2?.dispose();
    _interstitialAd3?.dispose();
    _rewardedAd.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _callRectangleWallApi();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: CachedNetworkImage(
                    imageUrl: widget.wallsModel.downloadLinks.thumbnail,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: IconButton(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
                          width: UIUtils().getProportionalWidth(25),
                          height: UIUtils().getProportionalWidth(25),
                        ),
                        Icon(
                          Icons.arrow_back_rounded,
                          color: AppColor.whiteColor,
                          size: UIUtils().getProportionalWidth(20),
                        ),
                      ],
                    ),
                    onPressed: _handleBackEvent,
                  ),
                ),
                Visibility(
                  visible: downloading,
                  child: Center(
                    child: Container(
                      height: UIUtils().mediaqueryScreenHeight(context) * 0.5,
                      alignment: Alignment.center,
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.black54,
                        ),
                        child: Text(
                          res,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// download and set wall buttons
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: UIUtils().getProportionalWidth(15),
                vertical: UIUtils().getProportionalWidth(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColor.darkTextColor,
                      child: TextButton(
                        onPressed: _handleDownloadButtonEvent,
                        child: Text(
                          "Download",
                          style: UIUtils().getTextStyle(color: AppColor.whiteColor, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: UIUtils().getProportionalWidth(20),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColor.darkTextColor,
                      child: TextButton(
                        onPressed: _setWallPaperOpenBottomSheet,
                        child: Text(
                          "Set Wallpaper",
                          style: UIUtils().getTextStyle(color: AppColor.whiteColor, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UIUtils().getProportionalWidth(18),
                  vertical: UIUtils().getProportionalWidth(15),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppColor.orGreyColor,
                    ),
                    SizedBox(
                      width: UIUtils().getProportionalWidth(10),
                    ),
                    Text(
                      widget.wallsModel?.likes,
                      style: UIUtils().getTextStyle(
                        fontSize: 15,
                        color: AppColor.orGreyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UIUtils().getProportionalWidth(18),
                  vertical: UIUtils().getProportionalWidth(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget?.wallsModel?.title,
                        style: UIUtils().getTextStyle(
                          fontSize: 15,
                          color: AppColor.blackTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      widget.wallsModel?.copyrightText,
                      style: UIUtils().getTextStyle(
                        fontSize: 10,
                        color: AppColor.lightTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
            Divider(
              color: AppColor.textFieldBorderColor,
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: UIUtils().getProportionalWidth(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: widget.wallsModel.artistAvatar,
                        height: UIUtils().getProportionalWidth(70),
                        width: UIUtils().getProportionalWidth(70),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: UIUtils().getProportionalWidth(12),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.wallsModel.artistName,
                        style: UIUtils().getTextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.wallsModel.location,
                        style: UIUtils().getTextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColor.orGreyColor),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: UIUtils().getProportionalWidth(15),
                vertical: UIUtils().getProportionalWidth(15),
              ),
              child: Text(
                widget?.wallsModel?.artistBio,
                textAlign: TextAlign.justify,
                style: UIUtils().getTextStyle(
                  fontSize: 14,
                  color: AppColor.darkTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleBackEvent() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    if (_isRewardedAdReady) {
      _rewardedAd?.show(
        onUserEarnedReward: (ad, reward) {},
      );
    }
  }

  _handleDownloadButtonEvent() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 60),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  color: AppColor.darkTextColor,
                  child: Row(
                    children: [
                      Icon(Icons.close, color: AppColor.transparent),
                      Expanded(
                        child: Text(
                          'Download'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.close, color: AppColor.whiteColor),
                      )
                    ],
                  ),
                ),
                Text("Tap on the photo to download"),
                Container(
                  padding: EdgeInsets.all(40),
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: _downloadRectangleWall,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FancyShimmerImage(
                              imageUrl: widget.wallsModel?.downloadLinks?.original,
                              boxFit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: _downloadSquareWall,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FancyShimmerImage(
                                imageUrl: widget.wallsModel?.downloadLinks?.original,
                                boxFit: BoxFit.contain,
                                shimmerBaseColor: Colors.transparent,
                                shimmerBackColor: Colors.transparent,
                                shimmerHighlightColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _callRectangleWallApi() async {
    if (!Utils.isInternetAvailable(_key)) return;
    Utils.showProgressDialog(_key.currentContext);
    await _bloc.categoryWiseWallsApi().then((value) async {
      await Utils.dismissProgressDialog(_key.currentContext);
    });
  }

  _downloadSquareWall() async {
    _loadInterstitialAd2();
    await PlatformChannel().checkForPermission(Permission.storage);
    var response = await Dio().get(
      widget.wallsModel?.downloadLinks?.original,
      options: Options(responseType: ResponseType.bytes),
    );
    String imageName = 'sq_' + Path.basename(response.requestOptions.path.split('.jpg')[0]);
    print(imageName);
    var result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100, name: imageName);
    print(result);
    Navigator.pop(context);
    Utils.showSnackBar(_key, result['isSuccess'] == true ? 'Image Saved To Gallery' : 'Please grant storage permission to save wallpapers');
    Timer(Duration(seconds: 1), () {
      if (_isInterstitialAd2Ready) {
        _interstitialAd2?.show();
      } else {
        print('ad is not ready');
      }
    });
  }

  _downloadRectangleWall() async {
    _loadInterstitialAd2();
    await PlatformChannel().checkForPermission(Permission.storage);
    var response = await Dio().get(
      _bloc.wallpaper?.image,
      options: Options(responseType: ResponseType.bytes),
    );
    String imageName = 'rect_' + Path.basename(response.requestOptions.path.split('.jpg')[0]);
    print(imageName);
    var result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 100, name: imageName);
    print(result);
    Navigator.pop(context);
    Utils.showSnackBar(_key, result['isSuccess'] == true ? 'Image Saved To Gallery' : 'Please grant storage permission to save wallpapers');
    Timer(Duration(seconds: 1), () {
      if (_isInterstitialAd2Ready) {
        _interstitialAd2?.show();
      } else {
        print('ad is not ready');
      }
    });
  }

  _setWallPaperOpenBottomSheet() {
    Utils.showBottomSheet(
      _key.currentContext,
      title: "Set Wallpaper",
      arrButton: ['Home Screen', 'Lock Screen', 'Both'],
      callback: (index) {
        if (index == 0) {
          _setWallpaperEvent(wallpaperType: WallpaperType.HOME_SCREEN);
        } else if (index == 1) {
          _setWallpaperEvent(wallpaperType: WallpaperType.LOCK_SCREEN);
        } else if (index == 2) {
          _setWallpaperEvent(wallpaperType: WallpaperType.BOTH);
        }
      },
    );
  }

  _setWallpaperEvent({@required WallpaperType wallpaperType}) async {
    _loadInterstitialAd3();
    progressString = Wallpaper.ImageDownloadProgress(_bloc.wallpaper?.image);
    progressString.listen(
      (data) async {
        res = data;
        downloading = true;
        setState(() {});
      },
      onDone: () async {
        if (wallpaperType == WallpaperType.HOME_SCREEN) {
          await Wallpaper.homeScreen();
        } else if (wallpaperType == WallpaperType.LOCK_SCREEN) {
          await Wallpaper.lockScreen();
        } else if (wallpaperType == WallpaperType.BOTH) {
          await Wallpaper.homeScreen();
          await Wallpaper.lockScreen();
        } else if (wallpaperType == WallpaperType.SYSTEM) {
          await Wallpaper.systemScreen();
        } else {
          await Wallpaper.homeScreen();
        }
        setState(() {
          downloading = false;
        });

        Utils.showSnackBar(_key, "Wallpaper successfully set");
        Timer(Duration(seconds: 1), () {
          if (_isInterstitialAd3Ready) {
            _interstitialAd3?.show();
          } else {
            print('ad is not ready');
          }
        });
      },
      onError: (error) {
        setState(() {
          downloading = false;
        });
        Utils.showSnackBar(_key, "Something went wrong!");
      },
    );
  }

  void _loadBannerAd2() async {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId2,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  void _loadInterstitialAd1() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId1,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd1 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('ad dismissed');
            },
          );
          _isInterstitialAd2Ready = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAd1Ready = false;
        },
      ),
    );
  }

  void _loadInterstitialAd2() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId2,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd2 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('ad dismissed');
            },
          );
          _isInterstitialAd2Ready = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAd2Ready = false;
        },
      ),
    );
  }

  void _loadInterstitialAd3() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId3,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd3 = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('ad dismissed');
            },
          );
          _isInterstitialAd3Ready = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAd3Ready = false;
        },
      ),
    );
  }


  // void _loadRewardedAd() {
  //   RewardedAd.load(
  //     adUnitId: AdHelper.rewardedAdUnitId,
  //     request: AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         this._rewardedAd = ad;
  //
  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {
  //             setState(() {
  //               _isRewardedAdReady = false;
  //             });
  //             _loadRewardedAd();
  //           },
  //         );
  //
  //         setState(() {
  //           _isRewardedAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (err) {
  //         print('Failed to load a rewarded ad: ${err.message}');
  //         setState(() {
  //           _isRewardedAdReady = false;
  //         });
  //       },
  //     ),
  //   );
  // }
}

enum WallpaperType {
  HOME_SCREEN,
  LOCK_SCREEN,
  BOTH,
  SYSTEM,
}
