part of 'news_bloc.dart';

@immutable
abstract class NewsState extends Equatable{}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}


class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoaded extends NewsState {
 final  APIResponse<List<NewsForListing>> apiResponse;
  NewsLoaded({this.apiResponse});
  @override
  List<Object> get props => [apiResponse];
}

class NewsError extends NewsState {
  final String errorMessage;
  NewsError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
