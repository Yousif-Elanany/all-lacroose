

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

class UploadImageLoading extends NewsState {}

class UploadImageSuccess extends NewsState {
  final String Image_videoLink;

  UploadImageSuccess(this.Image_videoLink );
}

class UploadImageFailure extends NewsState {
  final String errorMessage;

  UploadImageFailure(this.errorMessage);
}
class NewDeletedLoading extends NewsState {}

class NewDeletedSuccess extends NewsState {

  NewDeletedSuccess();
}

class NewDeletedFailure extends NewsState {


  NewDeletedFailure();
}

class EditNewsLoading extends NewsState {}

class EditNewsSuccess extends NewsState {

  EditNewsSuccess();
}

class EditNewsFailure extends NewsState {
  final String message;
  EditNewsFailure(this.message);
}