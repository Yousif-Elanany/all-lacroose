

import '../../../../NewsPage/data/model/newsModel.dart';



abstract class NewsState {}

final class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<NewsModel> NewsData;


  NewsSuccess( this.NewsData);
}

class NewsFailure extends NewsState {
  final String errorMessage;

  NewsFailure(this.errorMessage);
}

class NewsByIdLoading extends NewsState {}

class NewsByIdSuccess extends NewsState {
  final NewsModel NewsData;


  NewsByIdSuccess( this.NewsData);
}

class NewsByIdFailure extends NewsState {
  final String errorMessage;

  NewsByIdFailure(this.errorMessage);
}
