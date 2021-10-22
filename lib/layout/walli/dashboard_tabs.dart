import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:wall_hunt/layout/walli/category_list_screen.dart';

import '../../localization/localization.dart';
import '../../utils/app_color.dart';
import '../../utils/ui_utils.dart';
import 'walls_screen.dart';

class DashboardTabs extends StatefulWidget {
  @override
  _DashboardTabsState createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 1;
    _tabController.addListener(_handleTabChanges);

    super.initState();
  }

  _handleTabChanges() {
    setState(() {});
    print(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TextStyle getTabTextStyle() {
    return UIUtils().getTextStyle(
      fontSize: 16,
      color: AppColor.darkTextColor,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle getTabOrderNumberTextStyle() {
    return UIUtils().getTextStyle(
      fontSize: 16,
      color: AppColor.loginButtonColor,
      fontWeight: FontWeight.w500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          toolbarHeight: 45,
          backgroundColor: Colors.white,
          title: Text(
            Translations.of(context).appName,
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
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    onTap: (value) {},
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: MD2Indicator(
                      indicatorHeight: UIUtils().getProportionalWidth(3),
                      indicatorColor: AppColor.darkTextColor,
                      indicatorSize: MD2IndicatorSize.normal,
                    ),
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Translations.of(context).strCollection,
                              style: getTabTextStyle(),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Translations.of(context).strFeatured,
                              style: getTabTextStyle(),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Translations.of(context).strRecent,
                              style: getTabTextStyle(),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Translations.of(context).strPopular,
                              style: getTabTextStyle(),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColor.hintTextColor,
                    height: 1,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: BouncingScrollPhysics(
                          parent: NeverScrollableScrollPhysics()),
                      children: [
                        CategoryListPage(),
                        WallsScreen(tabIndex: 1),
                        WallsScreen(tabIndex: 2),
                        WallsScreen(tabIndex: 3),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
