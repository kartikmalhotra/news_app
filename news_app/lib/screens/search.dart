import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/screen_config.dart';
import 'package:news_app/routes/routes_const.dart';
import 'package:news_app/shared/bloc/news_bloc.dart';
import 'package:news_app/widget/widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late String _initialString;

  @override
  void initState() {
    super.initState();
    _initialString = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        height: AppScreenConfig.screenHeight,
        width: AppScreenConfig.screenWidth,
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: _buildSearchScreen(context),
        ),
      ),
    );
  }

  Widget _buildSearchScreen(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      buildWhen: (previous, current) =>
          current is SearchScreenDataLoaded || current is SearchScreenLoader,
      builder: (BuildContext context, NewsState state) {
        if (state is SearchScreenLoader) {
          return Center(child: AppCircularProgressLoader());
        } else if (state is SearchScreenDataLoaded) {
          if (state.errorText == null) {
            return _showSearchList(context, state);
          } else {
            return Center(child: Text("Search not Found"));
          }
        }
        return Container();
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => _textEditingController.clear(),
        )
      ],
      backgroundColor: Colors.white,
      title: TextFormField(
        autofocus: true,
        controller: _textEditingController,
        onChanged: (value) {
          if (_initialString != value) {
            _initialString = value;
            BlocProvider.of<NewsBloc>(context)
                .add(SearchNewsDataEvent(searchString: value));
          }
        },
      ),
    );
  }

  Widget _showSearchList(BuildContext context, SearchScreenDataLoaded state) {
    return Container(
      height: AppScreenConfig.screenHeight! - 40,
      width: AppScreenConfig.screenWidth! - 40.0,
      child: ListView.builder(
        itemCount: state.articles?.length ?? 0,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: AppCard(
              callback: () => Navigator.pushNamed(
                context,
                AppRoutes.newsDetailScreen,
                arguments: state.articles![index],
              ),
              article: state.articles![index],
              width: AppScreenConfig.screenWidth! - 50.0,
              height: 350,
            ),
          );
        },
      ),
    );
  }
}
