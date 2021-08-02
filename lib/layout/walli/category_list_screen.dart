import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wall_hunt/bloc/category_list_bloc.dart';
import 'package:wall_hunt/layout/walli/category_walls_screen.dart';
import 'package:wall_hunt/service/all_response.dart';
import 'package:wall_hunt/service/response/model/category_list_model.dart';
import 'package:wall_hunt/utils/app_color.dart';
import 'package:wall_hunt/utils/utils.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> with AfterLayoutMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final CategoryListBloc _bloc = CategoryListBloc();
  StreamSubscription<CategoryListResponse> _categoryListStreamSubscription;

  @override
  void initState() {
    _categoryListStreamSubscription = _bloc.categoryListStream.listen((response) async {
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
  void dispose() {
    _scrollController.dispose();
    _categoryListStreamSubscription?.cancel();
    _bloc.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _callCategoryListApi(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        child: GridView.builder(
          padding: EdgeInsets.only(
            left: 15,
            top: 15,
            right: 15,
          ),
          controller: _scrollController,
          physics: ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: _bloc.categoryList.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.5),
            crossAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            final CategoryListModel category = _bloc.categoryList[index];
            return CategoryAdapter(
              category: category,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CategoryWallsScreen(category: category),
                  ),
                );
              },
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
    int cPage = (_bloc.categoryList.length ~/ _bloc.defaultCategoryFetchLimit);
    _callCategoryListApi(page: cPage + 1);
  }

  _callCategoryListApi({int page}) async {
    if (!Utils.isInternetAvailable(_key)) return;
    bool isLoader = (page == 1);
    Utils.showProgressDialog(_key.currentContext);
    if (isLoader) Utils.showProgressDialog(_key.currentContext);
    await _bloc.categoryListApi(page: page);
    if (isLoader) {
      await Utils.dismissProgressDialog(_key.currentContext);
    }
  }
}

class CategoryAdapter extends StatelessWidget {
  final CategoryListModel category;
  final VoidCallback onPressed;

  const CategoryAdapter({this.category, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FancyShimmerImage(
                imageUrl: category?.categoryImage,
                boxFit: BoxFit.cover,
                shimmerHighlightColor: AppColor.whiteColor,
                shimmerBackColor: AppColor.whiteColor,
                shimmerBaseColor: AppColor.whiteColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            category?.categoryName?.toUpperCase(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 1,
            softWrap: true,
          ),
          SizedBox(height: 20),
        ],
      )),
    );
  }
}
