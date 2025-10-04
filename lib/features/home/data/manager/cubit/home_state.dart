  part of 'home_cubit.dart';

@immutable
sealed class HomeStates {}

final class HomeInitial extends HomeStates {}

///////////////////////////*****Advertisement States**/////////////////////////////////
class AdvertisementDataLoading extends HomeStates {}

class AdvertisementDataSuccess extends HomeStates {
  final List<AdvertisementModel> AdvertisementData;

  AdvertisementDataSuccess(this.AdvertisementData);
}

class AdvertisementDataFailure extends HomeStates {
  final String errorMessage;

  AdvertisementDataFailure(this.errorMessage);
}

///////////////////////////*****DetailsModel States**/////////////////////////////////
class DetailsDataLoading extends HomeStates {}

class DetailsDataSuccess extends HomeStates {
  final DetailsModel DetailsData;

  DetailsDataSuccess(this.DetailsData);
}

class DetailsDataFailure extends HomeStates {
  final String errorMessage;

  DetailsDataFailure(this.errorMessage);
}

///////////////////////////*****Gamereule States**/////////////////////////////////
class GameRuleDataLoading extends HomeStates {}

class GameRuleDataSuccess extends HomeStates {
  final List<GameRuleModel> GameRuleData;

  GameRuleDataSuccess(this.GameRuleData);
}

class GameRuleDataFailure extends HomeStates {
  final String errorMessage;

  GameRuleDataFailure(this.errorMessage);
}

///////////////////////////*****AboutUnion States**/////////////////////////////////
class AboutUnionDataLoading extends HomeStates {}

class AboutUnionDataSuccess extends HomeStates {
  final AboutUnionModel AboutUnionData;

  AboutUnionDataSuccess(this.AboutUnionData);
}

class AboutUnionDataFailure extends HomeStates {
  final String errorMessage;

  AboutUnionDataFailure(this.errorMessage);
}

///////////////////////////*****Home States**/////////////////////////////////
class HomeDataLoading extends HomeStates {}

class HomeDataSuccess extends HomeStates {
  final HomeModel homeData;

  HomeDataSuccess(this.homeData);
}

class HomeDataFailure extends HomeStates {
  final String errorMessage;

  HomeDataFailure(this.errorMessage);
}

///////////////////////////*****Player States**/////////////////////////////////
class PlayerDataLoading extends HomeStates {}

class PlayerDataSuccess extends HomeStates {
  final List<PlayerModel> playerData;

  PlayerDataSuccess(this.playerData);
}

class PlayerDataFailure extends HomeStates {
  final String errorMessage;

  PlayerDataFailure(this.errorMessage);
}
////////////////////////////////////trainers//////////////////////

class TrainerDataLoading extends HomeStates {}

class TrainerDataSuccess extends HomeStates {
  final List<PlayerModel> trainerData;

  TrainerDataSuccess(this.trainerData);
}

class TrainerDataFailure extends HomeStates {
  final String errorMessage;

  TrainerDataFailure(this.errorMessage);
}
///////////*********************************************////////
class MatchLoading extends HomeStates {}

class MatchSuccess extends HomeStates {
  final List<MatchModel> matchData;

  MatchSuccess(this.matchData);
}

class MatchFailure extends HomeStates {
  final String errorMessage;

  MatchFailure(this.errorMessage);
}
class getPlayerDataLoading extends HomeStates {}

class getPlayerDataSuccess extends HomeStates {
  final PlayerModel playerData;

  getPlayerDataSuccess(this.playerData);
}
class fetch_team_loading extends HomeStates {}

class fetch_team_success extends HomeStates {
  final List<TeamModel> TeamData;
  fetch_team_success(this.TeamData);
}

class fetch_team_failure extends HomeStates {
  final String errorMessage;
  fetch_team_failure(this.errorMessage);
}
class fetch_Nationality_loading extends HomeStates {}

class fetch_Nationality_success extends HomeStates {
  final List<NationalityModel> NationalityData;
  fetch_Nationality_success(this.NationalityData);
}

class fetch_Nationality_failure extends HomeStates {
  final String errorMessage;
  fetch_Nationality_failure(this.errorMessage);
}

class getPlayerDataFailure extends HomeStates {
  final String errorMessage;

  getPlayerDataFailure(this.errorMessage);
}

////////Teams //////////
class TeamsLoading extends HomeStates {}

class TeamsDataSuccess extends HomeStates {
  final List<teamModels> teamsData;

  TeamsDataSuccess(this.teamsData);
}

class TeamsFailure extends HomeStates {
  final String errorMessage;

  TeamsFailure(this.errorMessage);
}
////////LocationMarkerModel //////////
class NearestPlaygroundsLoading extends HomeStates {}

class NearestPlaygroundsDataSuccess extends HomeStates {
  final List<LocationMarkerModel> markersList;

  NearestPlaygroundsDataSuccess(this.markersList);
}

class NearestPlaygroundsFailure extends HomeStates {
  final String errorMessage;

  NearestPlaygroundsFailure(this.errorMessage);
}


class EditPlayerLoaded extends HomeStates {
  final PlayerModel player;
  final List<TeamModel> teams;
  final List<NationalityModel> nationalities;

  EditPlayerLoaded({
    required this.player,
    required this.teams,
    required this.nationalities,
  });
}

class UpdatePlayerLoading extends HomeStates {}

class UpdatePlayerSuccess extends HomeStates {

}

class UpdatePlayerFailure extends HomeStates {
  final String errorMessage;
  UpdatePlayerFailure(this.errorMessage);
}

// Loading
class FetchPlayGroundLoading extends HomeStates {}

// Success
class FetchPlayGroundSuccess extends HomeStates {
  final List<PlayGroundModel> playGrounds;
  FetchPlayGroundSuccess(this.playGrounds);
}

// Failure
class FetchPlayGroundFailure extends HomeStates {
  final String errorMessage;
  FetchPlayGroundFailure(this.errorMessage);
}

// Loading
class AddPlayGroundLoading extends HomeStates {}

// Success
class AddPlayGroundSuccess extends HomeStates {

}

// Failure
class AddPlayGroundFailure extends HomeStates {
  final String errorMessage;
  AddPlayGroundFailure(this.errorMessage);
}
class EditPlayGroundLoading extends HomeStates {}

// Success
class EditPlayGroundSuccess extends HomeStates {

}

// Failure
class EditPlayGroundFailure extends HomeStates {
  final String errorMessage;
  EditPlayGroundFailure(this.errorMessage);
}

class EditMatchLoading extends HomeStates {}

// Success
class EditMatchSuccess extends HomeStates {

}

// Failure
class EditMatchFailure extends HomeStates {
  final String errorMessage;
  EditMatchFailure(this.errorMessage);
}

class EditTeamLoading extends HomeStates {}

// Success
class EdiTeamSuccess extends HomeStates {

}

// Failure
class EditTeamFailure extends HomeStates {
  final String errorMessage;
  EditTeamFailure(this.errorMessage);
}
  class DeletePlayerLoading extends HomeStates {}

  class DeletePlayerSuccess extends HomeStates {}

  class DeletePlayerFailure extends HomeStates {
    final String error;
    DeletePlayerFailure(this.error);
  }
  class GetHomeEventsLoading extends HomeStates {}

  class GetHomeEventsSuccess extends HomeStates {
    final List<EventModel> listModel;

    GetHomeEventsSuccess(this.listModel);
  }

  class GetHomeEventsFailure extends HomeStates {
    final String errorMessage;

    GetHomeEventsFailure(this.errorMessage);
  }