import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import '../bloc/temp_bloc.dart';
import '../utils/navigation/navigation_service.dart';
import '../localization/app_model.dart';
import '../localization/localization.dart';
import '../utils/app_color.dart';
import 'routes.dart';

class ApplicationWrapper extends StatefulWidget {
  @override
  _ApplicationWrapperState createState() => _ApplicationWrapperState();
}

class _ApplicationWrapperState extends State<ApplicationWrapper> {
  final AppModel _appModel = AppModel();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>.value(
      value: this._appModel,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Container(
              color: AppColor.loginButtonColor,
            );
          } else {
            return MultiProvider(
              providers: [
                Provider<TempBloc>.value(value: TempBloc()),
              ],
              child: OverlaySupport(
                child: MaterialApp(
                  onGenerateTitle: (BuildContext _context) => Translations.of(_context).appName,
                  localizationsDelegates: [
                    Translations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  locale: value.appLocal,
                  debugShowCheckedModeBanner: false,
                  supportedLocales: value.supportedLocales,
                  builder: (context, child) => MediaQuery(
                    child: child,
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  ),
                  initialRoute: value.isUserLogin ? '/DashboardTabs' : '/DashboardTabs',
                  routes: appRoutes,
                  theme: new ThemeData(
                    primaryColor: AppColor.blue,
                  ),
                  navigatorKey: NavigationService().navigatorKey,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
