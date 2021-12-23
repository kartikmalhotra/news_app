import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/application.dart';
import 'package:news_app/config/screen_config.dart';
import 'package:news_app/routes/routes.dart';
import 'package:news_app/routes/routes_const.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/profile_screen.dart';
import 'package:news_app/services/rest_service.dart';
import 'package:news_app/shared/bloc/news_bloc.dart';
import 'package:news_app/shared/repository/repository.dart';

void main() {
  /// Getting Instance of all the classes needed
  Application.restAPIService = RestAPIService.getInstance();
  Application.routeSettings = AppRouteSetting.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      create: (context) => NewsBloc(repository: NewsRepositoryImpl()),
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Application.routeSettings!.generateRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// Initialize AppScreen Config
    AppScreenConfig.initializeScreenConfig(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "News App",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        actions: [
          _currentIndex == 0
              ? IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.searchScreen),
                )
              : Container(),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          Center(
            child: Text("Nothing added to Favourate"),
          ),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.indigoAccent),
        selectedItemColor: Colors.indigoAccent,
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_sharp), label: "Favourate"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
