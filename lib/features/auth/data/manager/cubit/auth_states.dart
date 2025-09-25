import '../../model/natinalityModel.dart';
import '../../model/ordelModel.dart';
import '../../model/team.dart';

abstract class AuthStates {}
/////////////  register /////////////
final class Auth_initial extends AuthStates {}

class RegisterLoading extends AuthStates {}

class RegisterSuccess extends AuthStates {

}

class RegisterFailure extends AuthStates {
  final String errorMessage;

  RegisterFailure(this.errorMessage);

}
///////////// log in /////////////
class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  // final String accessToken;
  //
  // LoginSuccess(this.accessToken);

}

class LoginFailure extends AuthStates {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

/////////////////fcmToken///////

///////////// notificationsTokenStates /////////////
class NotificationLoading extends AuthStates {}

class NotificationSuccess extends AuthStates {}

class NotificationFailure extends AuthStates {
  final String errorMessage;

  NotificationFailure(this.errorMessage);
}

///////////// chang pass /////////////

class ChangPassLoading extends AuthStates {}

class ChangPassSuccess extends AuthStates {


}

class ChangPassFailure extends AuthStates {
  final String errorMessage;

  ChangPassFailure(this.errorMessage);
}
///////////// Order /////////////
// class Fetch_PlayersOrderSuccess extends AuthStates {
//   final List<OrderModel> playerOrderData;
//
//
//   Fetch_PlayersOrderSuccess( this.playerOrderData);
//
// }
// class Fetch_TrainerOrderSuccess extends AuthStates {
//   final List<OrderModel> trainerOrderData;
//
//
//   Fetch_TrainerOrderSuccess( this.trainerOrderData);
//
// }
// class FetchOrderFailure extends AuthStates {
//   final String errorMessage;
//
//   FetchOrderFailure(this.errorMessage);
// }
///////////// ApproveOrder /////////////
class ApproveOrderSuccess extends AuthStates {


}
class ApproveOrderFailure extends AuthStates {
  final String errorMessage;

  ApproveOrderFailure(this.errorMessage);
}
///////////// RejectOrderOrder /////////////
class RejectOrderSuccess extends AuthStates {

}
class RejectOrderFailure extends AuthStates {
  final String errorMessage;

  RejectOrderFailure(this.errorMessage);
}
///////////// teams /////////////
class fetch_team_success extends AuthStates {
  final List<TeamModel> TeamData;


  fetch_team_success( this.TeamData);

}
class fetch_Nationality_success extends AuthStates {
  final List<NationalityModel> NationalityData;


  fetch_Nationality_success( this.NationalityData);

}

