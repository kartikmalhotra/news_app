import 'package:news_app/config/application.dart';
import 'package:news_app/constants/const.dart';
import 'package:news_app/shared/model/model.dart';

abstract class NewsRepository {
  List<Articles>? get categoryArticles => [];
  set categoryArticlesData(List<Articles>? article);

  List<Articles> get favourateArticle => [];
  set favourateArticleData(List<Articles> article);

  // Fetch Category
  Future<dynamic> fetchCategory(String category);

  // Fetch Category
  Future<dynamic> searchString(String searchString);
}

class NewsRepositoryImpl extends NewsRepository {
  List<Articles> _favourateArticle = [];
  List<Articles>? _categoryArticles = [];

  @override
  List<Articles>? get categoryArticles => _categoryArticles;

  @override
  set categoryArticlesData(List<Articles>? article) {
    _categoryArticles = article;
  }

  @override
  List<Articles> get favourateArticle => _favourateArticle;

  @override
  set favourateArticleData(List<Articles> article) {
    _favourateArticle = article;
  }

  @override
  Future<dynamic> fetchCategory(String category) async {
    try {
      final response = await Application.restAPIService!.fetchData(
          "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=48f564ad20fd45d3ab2363b4ac1a2cef",
          RestAPIEndPoint.GET);
      return response;
    } catch (e) {
      return {"error": "Unexpected Error"};
    }
  }

  @override
  Future<dynamic> searchString(String string) async {
    try {
      final response = await Application.restAPIService!.fetchData(
          "https://newsapi.org/v2/top-headlines?q=$string&apiKey=48f564ad20fd45d3ab2363b4ac1a2cef",
          RestAPIEndPoint.GET);
      return response;
    } catch (e) {
      return {"error": "Unexpected Error"};
    }
  }
}
