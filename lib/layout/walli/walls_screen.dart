import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_hunt/bloc/wallpaper_list_bloc.dart';
import 'package:wall_hunt/control/pull_to_refresh_list_view.dart';
import 'package:wall_hunt/layout/walli/open_image_detail.dart';
import 'package:wall_hunt/layout/walli/post_adapter.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/response/model/featured_model.dart';
import 'package:wall_hunt/utils/app_color.dart';
import 'package:wall_hunt/utils/routes.dart';
import 'package:wall_hunt/utils/utils.dart';

class WallsScreen extends StatefulWidget {
  final int tabIndex;

  const WallsScreen({@required this.tabIndex});

  @override
  _WallsScreenState createState() => _WallsScreenState();
}

class _WallsScreenState extends State<WallsScreen> with AfterLayoutMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final WallsListBloc _bloc = WallsListBloc();
  StreamSubscription<WallsResponse> _wallsSubscription;

  @override
  void initState() {
    /// Listen for Subscription
    _bloc.tabIndex = widget.tabIndex;
    _wallsSubscription = _bloc.wallsStream.listen((response) async {
      await Utils.dismissProgressDialog(_key.currentContext);
      if (response.status == 200) {
        setState(() {});
      } else {
        Utils.showSnackBar(_key, response.message);
      }
    });
    _scrollController.addListener(_onScroll);

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      key: _key,
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
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
    if (_scrollController.position.maxScrollExtent !=
        _scrollController.offset) {
      return;
    }
    if (!_bloc.isLoadMore) return;
    if (_bloc.isLoadMorePending) return;
    _bloc.isLoadMorePending = true;
    int cPage = (_bloc.wallsList.length / _bloc.defaultFetchLimit).ceil();
    _callWallpaperListApi(page: cPage + 1);
  }

  _callWallpaperListApi({int page}) async {
    FocusScope.of(context).unfocus();
    if (!Utils.isInternetAvailable(_key)) return;
    bool isLoader = (page == 1);
    if (isLoader) Utils.showProgressDialog(_key.currentContext);
    Utils.showProgressDialog(_key.currentContext);
    await _bloc.wallsListApi(page: page);
    if (isLoader) {
      await Utils.dismissProgressDialog(_key.currentContext);
    }
  }

  _handleOpenImageDetailEvent(WallsModel featuredModel) {
    Navigator.push(
      context,
      SlideRightRoute(
        widget: OpenImageDetail(
          wallsModel: featuredModel,
        ),
      ),
    );
  }
}
