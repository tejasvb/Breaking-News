import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news/models/NewsForListing.dart';
import 'package:news/models/api_response.dart';
import 'package:news/service/news_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsService _newsService  = NewsService();
  NewsBloc() : super(NewsInitial());
  APIResponse<List<NewsForListing>> _apiResponse;
  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetNewsEvent) {
      yield NewsLoading();
      try {
        _apiResponse =
        await _newsService.getNewsList(category: event.category, field: event.field,type:event.type,query:event.query);
        if (_apiResponse.data==null) {
          yield NewsError(errorMessage: 'no news found');
        } else {
          yield NewsLoaded(
            apiResponse: _apiResponse,
          );
        }
      } catch (e) {
        yield NewsError(errorMessage: e.toString());
      }
    }
  }
}


