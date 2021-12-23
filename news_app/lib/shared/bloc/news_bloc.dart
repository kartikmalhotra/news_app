import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/shared/model/model.dart';
import 'package:news_app/shared/repository/repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc({required this.repository}) : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is FetchCategoryDataEvent) {
      yield* _mapFetchCategoryDataEventToState(event);
    } else if (event is SearchNewsDataEvent) {
      yield* _mapSearchNewsDataEventToState(event);
    }
  }

  Stream<NewsState> _mapFetchCategoryDataEventToState(
      FetchCategoryDataEvent event) async* {
    yield CategoryScreenLoader();

    final response = await repository.fetchCategory(event.category);
    if (response["data"] != null) {
      AriticlesModel ariticlesModel = AriticlesModel.fromJson(response["data"]);
      yield CategoryScreenDataLoaded(articles: ariticlesModel);
    } else {
      yield CategoryScreenDataLoaded(errorText: response["error"]);
    }
  }

  Stream<NewsState> _mapSearchNewsDataEventToState(
      SearchNewsDataEvent event) async* {
    yield SearchScreenLoader();

    final response = await repository.searchString(event.searchString);
    if (response["data"] != null) {
      AriticlesModel ariticlesModel = AriticlesModel.fromJson(response["data"]);
      yield SearchScreenDataLoaded(articles: ariticlesModel);
    } else {
      yield SearchScreenDataLoaded(errorText: response["error"]);
    }
  }
}
