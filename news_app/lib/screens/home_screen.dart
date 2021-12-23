import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/screen_config.dart';
import 'package:news_app/routes/routes_const.dart';
import 'package:news_app/shared/bloc/news_bloc.dart';
import 'package:news_app/widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? errorText;
  List<String> _categories = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  late String _selectedCategory;

  @override
  void initState() {
    _selectedCategory = "Business";
    BlocProvider.of<NewsBloc>(context)
        .add(FetchCategoryDataEvent(category: _selectedCategory));

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 20.0),
        _displayCategoryList(context),
        SizedBox(height: 30.0),
        Expanded(
          child: BlocBuilder<NewsBloc, NewsState>(
            buildWhen: (previous, current) =>
                current is CategoryScreenLoader ||
                current is CategoryScreenDataLoaded,
            builder: _homeScreenBuilder,
          ),
        ),
      ],
    );
  }

  Widget _homeScreenBuilder(BuildContext context, NewsState state) {
    if (state is CategoryScreenDataLoaded) {
      if (state.articles != null) {
        return _displayData(context, state);
      } else {
        setState(() {
          errorText = state.errorText;
        });
      }
    }

    return Center(child: AppCircularProgressLoader());
  }

  Widget _displayCategoryList(BuildContext context) {
    return Container(
      height: 30.0,
      child: ListView.builder(
        itemCount: _categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selectedCategory = _categories[index];
              });
              BlocProvider.of<NewsBloc>(context)
                  .add(FetchCategoryDataEvent(category: _selectedCategory));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: _categories[index] == _selectedCategory
                    ? Colors.indigoAccent
                    : Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: Text(
                  _categories[index],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: _categories[index] == _selectedCategory
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _displayData(BuildContext context, CategoryScreenDataLoaded state) {
    return Container(
      height: double.maxFinite,
      width: AppScreenConfig.screenWidth! - 40.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.articles?.articles?.length ?? 0,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: AppCard(
              callback: () => Navigator.pushNamed(
                context,
                AppRoutes.newsDetailScreen,
                arguments: state.articles!.articles![index],
              ),
              article: state.articles!.articles![index],
              width: AppScreenConfig.screenWidth! - 50.0,
              height: 350,
            ),
          );
        },
      ),
    );
  }
}
