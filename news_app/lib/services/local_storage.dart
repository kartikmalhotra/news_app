import 'dart:convert';

import 'package:news_app/shared/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  LocalStorageService._internal();

  get json => null;

  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._internal();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  List<Articles> get favourateArticle {
    dynamic data = _getDataFromDisk("FAVOURATE_ARTICLE");
    data = jsonDecode(data);
    if (data != null && data is List) {
      return data.map((e) => Articles.fromJson(e)).toList();
    }
    return [];
  }

  set setFavourateArticle(List<Articles> value) {
    var json = value.map((e) => e.toJson()).toList();
    _saveDataToDisk("FAVOURATE_ARTICLE", jsonEncode(json));
  }

  dynamic _getDataFromDisk(String key) {
    if (_preferences != null) {
      var value = _preferences!.get(key);
      return value;
    }
  }

  void _saveDataToDisk<T>(String key, T content) {
    if (_preferences != null) {
      if (content is String) {
        _preferences!.setString(key, content);
      } else if (content is bool) {
        _preferences!.setBool(key, content);
      } else if (content is int) {
        _preferences!.setInt(key, content);
      } else if (content is double) {
        _preferences!.setDouble(key, content);
      } else if (content is List<String>) {
        _preferences!.setStringList(key, content);
      } else {
        _preferences!.setString(key, content.toString());
      }
    }
  }
}
