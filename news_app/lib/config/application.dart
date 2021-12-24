import 'package:news_app/routes/routes.dart';
import 'package:news_app/services/local_storage.dart';
import 'package:news_app/services/rest_service.dart';
import 'package:uuid/uuid.dart';

class Application {
  static RestAPIService? restAPIService;
  static AppRouteSetting? routeSettings;
  static LocalStorageService? localStorageService;
  static Uuid? uuid;
}
