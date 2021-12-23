part of 'news_bloc.dart';

abstract class NewsState extends Equatable {}

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


class CategoryScreenDataLoaded extends NewsState {
  final AriticlesModel? articles;
  final String? errorText;

  CategoryScreenDataLoaded({
    this.articles,
    this.errorText,
  });

  @override
  List<Object?> get props => [articles, errorText];
}

class SearchScreenDataLoaded extends NewsState {
  final AriticlesModel? articles;
  final String? errorText;

  SearchScreenDataLoaded({
    this.articles,
    this.errorText,
  });

  @override
  List<Object?> get props => [articles, errorText];
}
