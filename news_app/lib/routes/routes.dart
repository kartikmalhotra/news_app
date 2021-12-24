import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/routes/routes_const.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/screens/search.dart';
import 'package:news_app/screens/show_on_web.dart';
import 'package:news_app/shared/model/model.dart';

class AppRouteSetting {
  static AppRouteSetting? _routeSetting;

  AppRouteSetting._internal();

  static AppRouteSetting? getInstance() {
    if (_routeSetting == null) {
      _routeSetting = AppRouteSetting._internal();
    }
    return _routeSetting;
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case AppRoutes.appScreen:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case AppRoutes.categoryScreen:
        return MaterialPageRoute(
            builder: (_) =>
                CategoryScreen(category: settings.arguments as String));
      case AppRoutes.newsDetailScreen:
        return MaterialPageRoute(
            builder: (_) =>
                NewsDetailScreen(articles: settings.arguments as Articles));
      case AppRoutes.searchScreen:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case AppRoutes.showOnWeb:
        return MaterialPageRoute(
            builder: (_) =>
                ShowOnWeb(articles: settings.arguments as Articles));
      default:
        return MaterialPageRoute(
          builder: (_) => Center(child: Text("Hi There")),
        );
    }
  }
}
