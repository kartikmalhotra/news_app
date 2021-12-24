import 'package:news_app/config/application.dart';
import 'package:news_app/constants/const.dart';

abstract class NewsRepository {
  // Fetch Category
  Future<dynamic> fetchCategory(String category);

  // Fetch Category
  Future<dynamic> searchString(String searchString);
}

class NewsRepositoryImpl extends NewsRepository {
  @override
  Future<dynamic> fetchCategory(String category) async {
    try {
      final response = await Application.restAPIService!.fetchData(
          "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=0cdfa5540e4b49019dbb0406a193e0b5",
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
          "https://newsapi.org/v2/top-headlines?q=$string&apiKey=0cdfa5540e4b49019dbb0406a193e0b5",
          RestAPIEndPoint.GET);
      return response;
    } catch (e) {
      return {"error": "Unexpected Error"};
    }
  }
}
