part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {}

class FetchCategoryDataEvent extends NewsEvent {
  final String category;

  FetchCategoryDataEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class SearchNewsDataEvent extends NewsEvent {
  final String searchString;

  SearchNewsDataEvent({required this.searchString});

  @override
  List<Object> get props => [searchString];
}

class FavourateArticleEvent extends NewsEvent {
  FavourateArticleEvent();

  @override
  List<Object> get props => [];
}

class FavourateIconTappedEvent extends NewsEvent {
  final Articles article;

  FavourateIconTappedEvent({required this.article});

  @override
  List<Object> get props => [article];
}
