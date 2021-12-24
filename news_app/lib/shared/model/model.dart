import 'package:intl/intl.dart';
import 'package:news_app/config/application.dart';

class AriticlesModel {
  List<Articles>? articles;

  AriticlesModel({
    required this.articles,
  });

  AriticlesModel.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(other) {
    print(other);
    if (other is AriticlesModel) {
      return articles == this.articles;
    }
    return false;
  }

  @override
  int get hashCode => articles.hashCode;
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? displayPublishedAt;
  String? content;
  late bool favourate;

  Articles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.favourate = false,
  });

  Articles.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'] != null
        ? DateTime.parse(json['publishedAt'])
        : null;
    displayPublishedAt = publishedAt != null
        ? DateFormat('yyyy-MM-dd').format(publishedAt!).toString()
        : null;
    content = json['content'];
    favourate = json['favourate'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    if (this.publishedAt != null) {
      data['publishedAt'] = this.publishedAt!.toString();
    }
    data['content'] = this.content;
    data['favourate'] = this.favourate;
    return data;
  }

  @override
  bool operator ==(other) {
    print(other);

    if (other is Articles) {
      return source == other.source &&
          author == other.author &&
          title == other.title &&
          description == other.description &&
          url == other.url &&
          urlToImage == other.urlToImage &&
          publishedAt == other.publishedAt &&
          content == other.content &&
          favourate == other.favourate;
    }
    return false;
  }

  @override
  int get hashCode =>
      source.hashCode ^
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      publishedAt.hashCode ^
      content.hashCode ^
      favourate.hashCode;
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? Application.uuid!.v4();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  bool operator ==(other) {
    print(other);

    if (other is Source) {
      return id == other.id && name == other.name;
    }
    return false;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
