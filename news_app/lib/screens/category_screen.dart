import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/screen_config.dart';
import 'package:news_app/routes/routes_const.dart';
import 'package:news_app/shared/bloc/news_bloc.dart';
import 'package:news_app/widget/widget.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "$category",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        height: AppScreenConfig.screenHeight,
        width: AppScreenConfig.screenWidth,
        child: _buildCategoryScreen(context),
      ),
    );
  }

  Widget _buildCategoryScreen(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is CategoryScreenDataLoaded) {
          if (state.errorText == null) {
            return _checkListSize(context, state);
          } else {
            return Center(child: AppCircularProgressLoader());
          }
        }
        return Center(
          child: AppCircularProgressLoader(),
        );
      },
    );
  }

  Widget _checkListSize(BuildContext context, CategoryScreenDataLoaded state) {
    if (state.categoryArticles!.isEmpty) {
      return Center(
        child: Text("Oops no article is there"),
      );
    }
    return _displayCategoryList(context, state);
  }

  Widget _displayCategoryList(
      BuildContext context, CategoryScreenDataLoaded state) {
    return Container(
      height: double.maxFinite,
      width: AppScreenConfig.screenWidth! - 40.0,
      child: ListView.builder(
        itemCount: state.categoryArticles?.length ?? 0,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: AppCard(
              callback: () => Navigator.pushNamed(
                context,
                AppRoutes.newsDetailScreen,
                arguments: state.categoryArticles![index],
              ),
              article: state.categoryArticles![index],
              width: AppScreenConfig.screenWidth! - 50.0,
              height: 350,
            ),
          );
        },
      ),
    );
  }
}
