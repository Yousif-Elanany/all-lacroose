import 'package:lacrosse/features/eventsPage/data/model/team.dart';

import '../../../../ActivitesPage/data/models/userAttendenceModel.dart';

import '../../model/eventModel.dart';
import '../../model/experienceModel.dart';
import '../../model/natinalityModel.dart';
import '../../model/player_model.dart';
import '../../model/reservationsNodel.dart';

abstract class ManagerStates {}

/////////////  register /////////////
final class manager_initial extends ManagerStates {}

class addUserLoading extends ManagerStates {}

class addUserSuccess extends ManagerStates {}

class addUserFailure extends ManagerStates {
  final String errorMessage;

  addUserFailure(this.errorMessage);
}

class addClubLoading extends ManagerStates {}

class addClubSuccess extends ManagerStates {}

class addClubFailure extends ManagerStates {
  final String errorMessage;

  addClubFailure(this.errorMessage);
}

class getAttendenceRequestsLoading extends ManagerStates {}

class getAttendenceRequestsSuccess extends ManagerStates {
  final List<UserAttendenceModel> userRequests;

  getAttendenceRequestsSuccess(this.userRequests);
}

class getAttendenceRequestsFailure extends ManagerStates {
  final String errorMessage;

  getAttendenceRequestsFailure(this.errorMessage);
}

class acceptOrRejectUserRequestLoading extends ManagerStates {}

class acceptOrRejectUserRequestSuccess extends ManagerStates {}

class acceptOrRejectUserRequestFailure extends ManagerStates {
  final String errorMessage;

  acceptOrRejectUserRequestFailure(this.errorMessage);
}

///////
class AddNewsEventLoading extends ManagerStates {}

class AddNewsEventSuccess extends ManagerStates {}

class AddNewsEventFailure extends ManagerStates {
  final String errorMessage;

  AddNewsEventFailure(this.errorMessage);
}

////////////////////CreateExperience/////////////
class CreateExperienceLoading extends ManagerStates {}

class CreateExperienceSuccess extends ManagerStates {}

class CreateExperienceFailure extends ManagerStates {
  final String errorMessage;

  CreateExperienceFailure(this.errorMessage);
}

//////////////////// Get teExperience/////////////
class GetExperienceLoading extends ManagerStates {}

class GetExperienceSuccess extends ManagerStates {
  final List<ExperiencesModel> listModel;

  GetExperienceSuccess(this.listModel);
}

class GetExperienceFailure extends ManagerStates {
  final String errorMessage;

  GetExperienceFailure(this.errorMessage);
}

//////////////////// Get teExperience/////////////
class GetExperienceReservationsLoading extends ManagerStates {}

class GetExperienceReservationsSuccess extends ManagerStates {
  final ReservationModel model;

  GetExperienceReservationsSuccess(this.model);
}

class GetExperienceReservationsFailure extends ManagerStates {
  final String errorMessage;

  GetExperienceReservationsFailure(this.errorMessage);
}

//////////////DeleteExperience////////
class DeleteExperienceLoading extends ManagerStates {}

class DeleteExperienceSuccess extends ManagerStates {}

class DeleteExperienceFailure extends ManagerStates {
  final String errorMessage;

  DeleteExperienceFailure(this.errorMessage);
}

///////
class AddNewEventLoading extends ManagerStates {}

class AddNewEventSuccess extends ManagerStates {

}

class AddNewEventFailure extends ManagerStates {
  final String errorMessage;

  AddNewEventFailure(this.errorMessage);
}

//////
/////// Image_video /////
class Image_videoloading extends ManagerStates {}

class Image_videoSuccess extends ManagerStates {
  final String Image_videoLink;

  Image_videoSuccess(this.Image_videoLink);
}

class Image_videoFailure extends ManagerStates {
  final String errorMessage;

  Image_videoFailure(this.errorMessage);
}

/////// players /////
class PlayerLoading extends ManagerStates {}

class PlayerSuccess extends ManagerStates {
  final List<PlayerModel> playerData;

  PlayerSuccess(this.playerData);
}

class PlayerFailure extends ManagerStates {
  final String errorMessage;

  PlayerFailure(this.errorMessage);
}

/////// Trainer /////
class TrainerLoading extends ManagerStates {}

class TrainerSuccess extends ManagerStates {
  final List<PlayerModel> TrainerData;

  TrainerSuccess(this.TrainerData);
}

class TrainerFailure extends ManagerStates {
  final String errorMessage;

  TrainerFailure(this.errorMessage);
}

//////// team //
class fetch_team2_success extends ManagerStates {
  final List<TeamMMModel> Team;

  fetch_team2_success({required this.Team});
}

class AddEventLoading extends ManagerStates {}

class AddEventSuccess extends ManagerStates {
  AddEventSuccess();
}

class AddEventFailure extends ManagerStates {
  final String errorMessage;

  AddEventFailure(this.errorMessage);
}
class UpdateExperienceLoading extends ManagerStates {}

class UpdateExperienceSuccess extends ManagerStates {}

class UpdateExperienceError extends ManagerStates {
  final String error;
  UpdateExperienceError(this.error);
}

