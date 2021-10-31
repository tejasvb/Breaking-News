part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}



class GetNewsEvent extends NewsEvent {
  final String category;
  final String field;
  final String type;
  final String query;
  GetNewsEvent({this.category,this.field,this.type,this.query});
  get props => [category,field,type,query];
}
