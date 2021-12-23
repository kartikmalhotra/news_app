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
          "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=33987db4491c4d32a49c525d42863838",
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
          "https://newsapi.org/v2/top-headlines?q=$string&apiKey=33987db4491c4d32a49c525d42863838",
          RestAPIEndPoint.GET);
      return response;
    } catch (e) {
      return {"error": "Unexpected Error"};
    }
  }
}
