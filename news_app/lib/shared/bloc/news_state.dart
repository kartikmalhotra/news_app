part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  final List<Articles>? categoryArticles;
  final List<Articles>? favourateArticles;
  final String? errorText;

  NewsState({this.categoryArticles, this.favourateArticles, this.errorText});
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class CategoryScreenLoader extends NewsState {
  @override
  List<Object> get props => [];
}

class SearchScreenLoader extends NewsState {
  @override
  List<Object> get props => [];
}

class FavourateScreenLoader extends NewsState {
  @override
  List<Object> get props => [];
}

class CategoryScreenDataLoaded extends NewsState {
  final List<Articles>? categoryArticles;
  final List<Articles>? favourateArticles;
  final String? errorText;

  CategoryScreenDataLoaded({
    this.categoryArticles,
    this.favourateArticles,
    this.errorText,
  }) : super(
          categoryArticles: categoryArticles,
          favourateArticles: favourateArticles,
          errorText: errorText,
        );

  @override
  List<Object?> get props => [
        categoryArticles,
        this.favourateArticles,
        errorText,
      ];
}

class SearchScreenDataLoaded extends NewsState {
  final List<Articles>? articles;
  final String? errorText;

  SearchScreenDataLoaded({
    this.articles,
    this.errorText,
  });

  @override
  List<Object?> get props => [articles, errorText];
}

class FavourateScreenDataLoaded extends NewsState {
  final List<Articles>? categoryArticles;
  final List<Articles>? favourateArticles;
  final String? errorText;

  FavourateScreenDataLoaded({
    this.categoryArticles,
    this.favourateArticles,
    this.errorText,
  }) : super(
          categoryArticles: categoryArticles,
          favourateArticles: favourateArticles,
          errorText: errorText,
        );

  @override
  List<Object?> get props => [
        categoryArticles,
        favourateArticles,
        errorText,
      ];
}
