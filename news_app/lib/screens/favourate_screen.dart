import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/screen_config.dart';
import 'package:news_app/routes/routes_const.dart';
import 'package:news_app/shared/bloc/news_bloc.dart';
import 'package:news_app/widget/widget.dart';

class FavourateScreen extends StatefulWidget {
  const FavourateScreen({Key? key}) : super(key: key);

  @override
  _FavourateScreenState createState() => _FavourateScreenState();
}

class _FavourateScreenState extends State<FavourateScreen> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(FavourateArticleEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
      width: AppScreenConfig.screenWidth,
      height: AppScreenConfig.screenHeight,
      child: _showHomeScreenData(context),
    );
  }

  Widget _showHomeScreenData(context) {
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: BlocProvider.of<NewsBloc>(context),
      buildWhen: (previous, current) =>
          current is FavourateScreenLoader ||
          current is FavourateScreenDataLoaded,
      builder: _favourateScreenBuilder,
    );
  }

  Widget _favourateScreenBuilder(BuildContext context, NewsState state) {
    if (state is FavourateScreenDataLoaded) {
      if (state.favourateArticles!.isNotEmpty) {
        return _displayData(context, state);
      } else {
        return Center(
          child: Text("Please add some Articles to Favourate"),
        );
      }
    }

    return Center(child: AppCircularProgressLoader());
  }

  Widget _displayData(BuildContext context, FavourateScreenDataLoaded state) {
    return Container(
      height: double.maxFinite,
      width: AppScreenConfig.screenWidth! - 40.0,
      child: ListView.builder(
        itemCount: BlocProvider.of<NewsBloc>(context)
            .repository
            .favourateArticle
            .length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: AppCard(
              callback: () => Navigator.pushNamed(
                context,
                AppRoutes.newsDetailScreen,
                arguments: state.favourateArticles![index],
              ),
              article: state.favourateArticles![index],
              width: AppScreenConfig.screenWidth! - 50.0,
              height: 350,
            ),
          );
        },
      ),
    );
  }
}
