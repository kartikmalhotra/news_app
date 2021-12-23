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
