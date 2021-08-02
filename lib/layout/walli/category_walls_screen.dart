import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wall_hunt/bloc/category_wall_list_bloc.dart';
import 'package:wall_hunt/control/pull_to_refresh_list_view.dart';
import 'package:wall_hunt/layout/walli/post_adapter.dart';
import 'package:wall_hunt/service/ad_helper.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/response/model/category_list_model.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';
import 'package:wall_hunt/utils/app_color.dart';
import 'package:wall_hunt/utils/routes.dart';
import 'package:wall_hunt/utils/ui_utils.dart';
import 'package:wall_hunt/utils/utils.dart';

import 'open_image_detail.dart';

class CategoryWallsScreen extends StatefulWidget {
  final CategoryListModel category;

  const CategoryWallsScreen({@required this.category});

  @override
  _CategoryWallsScreenState createState() => _CategoryWallsScreenState();
}

class _CategoryWallsScreenState extends State<CategoryWallsScreen> with AfterLayoutMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final CategoryWallListBloc _bloc = CategoryWallListBloc();
  StreamSubscription<WallsResponse> _wallsSubscription;

  RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;


  @override
  void initState() {
    _bloc.categoryId = widget.category?.id;

    /// Listen for Subscription
    _wallsSubscription = _bloc.wallsStream.listen((response) async {
      await Utils.dismissProgressDialog(_key.currentContext);
      if (response.status == 200) {
        setState(() {});
      } else {
        Utils.showSnackBar(_key, response.message);
      }
    });
    _scrollController.addListener(_onScroll);


    // _loadRewardedAd();
    // Timer(Duration(seconds: 30), () {
    //   if (_isRewardedAdReady) {
    //     _rewardedAd?.show(onUserEarnedReward: (ad, reward) {
    //
    //     },);
    //   } else {
    //     print('ad is not ready');
    //   }
    // });
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    this._callWallpaperListApi(page: 1);
  }

  @override
  void dispose() {
    _wallsSubscription?.cancel();
    _scrollController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.darkTextColor),
        title: Text(
          widget.category?.name,
          style: UIUtils().getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColor.darkTextColor,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: PullToRefreshListView(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          onRefresh: () async => _callWallpaperListApi(page: 1),
          controller: _scrollController,
          itemCount: _bloc.wallsList.length ?? 0,
          builder: (context, index) {
            WallsModel featured = _bloc.wallsList[index];
            return InkWell(
              onTap: () => _handleOpenImageDetailEvent(featured),
              child: PostAdapter(
                featuredModel: featured,
              ),
            );
          },
        ),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent != _scrollController.offset) return;
    if (!_bloc.isLoadMore) return;
    if (_bloc.isLoadMorePending) return;
    _bloc.isLoadMorePending = true;
    int cPage = (_bloc.wallsList.length ~/ _bloc.defaultFetchLimit);
    _callWallpaperListApi(page: cPage + 1);
  }

  _callWallpaperListApi({int page}) async {
    /// Resign keyboard
    FocusScope.of(context).unfocus();
    if (!Utils.isInternetAvailable(_key)) return;
    bool isLoader = (page == 1);
    if (isLoader) Utils.showProgressDialog(_key.currentContext);
    Utils.showProgressDialog(_key.currentContext);
    await _bloc.categoryWiseWallsApi(page: page);
    if (isLoader) {
      await Utils.dismissProgressDialog(_key.currentContext);
    }
  }

  _handleOpenImageDetailEvent(WallsModel wallsModel) {
    Navigator.push(
      context,
      SlideRightRoute(
        widget: OpenImageDetail(
          wallsModel: wallsModel,
        ),
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
