part of 'activities_cubit.dart';

@immutable
sealed class ActivitiesState {}

final class ActivitiesInitial extends ActivitiesState {}

class InternalEventLoading extends ActivitiesState {}

class InternalEventSuccess extends ActivitiesState {
  final List<InternalEventModel> InternalEvent;

  InternalEventSuccess(this.InternalEvent);
}

class InternalEventFailure extends ActivitiesState {
  final String errorMessage;

  InternalEventFailure(this.errorMessage);
}

///////////////
class InternalEventByIdLoading extends ActivitiesState {}

class InternalEventByIdSuccess extends ActivitiesState {
  final InternalEventModel internalEventData;

  InternalEventByIdSuccess(this.internalEventData);
}

class InternalEventByIdFailure extends ActivitiesState {
  final String errorMessage;

  InternalEventByIdFailure(this.errorMessage);
}

//////////
class GetAllInternalEventsForNationalTeamLoading extends ActivitiesState {}

class GetAllInternalEventsForNationalTeamSuccess extends ActivitiesState {
  final List<InternalEventModel> internalEventData;

  GetAllInternalEventsForNationalTeamSuccess(this.internalEventData);
}

class GetAllInternalEventsForNationalTeamFailure extends ActivitiesState {
  final String errorMessage;

  GetAllInternalEventsForNationalTeamFailure(this.errorMessage);
}

//////////////////// Get teExperience/////////////
class GetAllExperienceLoading extends ActivitiesState {}

class GetAllExperienceSuccess extends ActivitiesState {
  final List<ExperiencesModel> listModel;

  GetAllExperienceSuccess(this.listModel);
}

class GetAllExperienceFailure extends ActivitiesState {
  final String errorMessage;

  GetAllExperienceFailure(this.errorMessage);
}

/////////////////////// addExperienceReservation //////////////////
class AddExperienceReservationLoading extends ActivitiesState {}

class AddExperienceReservationSuccess extends ActivitiesState {}

class AddExperienceReservationFailure extends ActivitiesState {
  final String errorMessage;

  AddExperienceReservationFailure(this.errorMessage);
}

////////////////////InternalEventReservation ///////////////
class AddInternalEventReservationLoading extends ActivitiesState {}

class AddInternalEventReservationSuccess extends ActivitiesState {}

class AddInternalEventReservationFailure extends ActivitiesState {
  final String errorMessage;

  AddInternalEventReservationFailure(this.errorMessage);
}

class DeleteInternalEventLoading extends ActivitiesState {}

class DeleteInternalEventSuccess extends ActivitiesState {}

class DeleteInternalEventFailure extends ActivitiesState {
  final String errorMessage;

  DeleteInternalEventFailure(this.errorMessage);
}
class DeleteEventLoading extends ActivitiesState {}

class DeleteEventSuccess extends ActivitiesState {}

class DeleteEventFailure extends ActivitiesState {
  final String errorMessage;

  DeleteEventFailure(this.errorMessage);
}
class EditEventLoading extends ActivitiesState {}

class EditEventSuccess extends ActivitiesState {}

class EditEventFailure extends ActivitiesState {
  final String errorMessage;

  EditEventFailure(this.errorMessage);
}
class GetEventsLoading extends ActivitiesState {}

class GetEventsSuccess extends ActivitiesState {
  final List<EventModel> listModel;

  GetEventsSuccess(this.listModel);
}

class GetEventsFailure extends ActivitiesState {
  final String errorMessage;

  GetEventsFailure(this.errorMessage);
}



