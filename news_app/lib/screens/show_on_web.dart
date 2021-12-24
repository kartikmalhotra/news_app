import 'package:news_app/config/screen_config.dart';
import 'package:news_app/shared/model/model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class ShowOnWeb extends StatelessWidget {
  final Articles articles;

  const ShowOnWeb({required this.articles});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: AppScreenConfig.screenHeight,
        width: AppScreenConfig.screenWidth,
        child: WebView(
          initialUrl: articles.url,
        ),
      ),
    );
  }
}
