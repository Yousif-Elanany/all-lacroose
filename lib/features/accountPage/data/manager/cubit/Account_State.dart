







import '../../model/questionModel.dart';
import '../../model/updateUserDataModel.dart';

abstract class AccountState {}

final class AccountInitial extends AccountState {}

class QuestionLoading extends AccountState {}

class QuestionSuccess extends AccountState {
  final List<QuestionModel> question;



  QuestionSuccess( this.question);
}

class QuestionFailure extends AccountState {
  final String errorMessage;

  QuestionFailure(this.errorMessage);
}
//////////////
class editUserProfileLoading extends AccountState {}

class editUserProfileSuccess extends AccountState {
  final String userName;
  final String userPhoto;
  final String userPhone;


  editUserProfileSuccess(this.userName,this.userPhoto,this.userPhone);
}

class editUserProfileFailure extends AccountState {
  final String errorMessage;

  editUserProfileFailure(this.errorMessage);
}
/////// Image_video /////
class Image_videoloading extends AccountState {}
class Image_videoSuccess extends AccountState {
  final String Image_videoLink;


  Image_videoSuccess( this.Image_videoLink);
}

class Image_videoFailure extends AccountState {
  final String errorMessage;

  Image_videoFailure(this.errorMessage);
}