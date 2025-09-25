import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/data/endPoints/endpoint.dart';
import 'package:meta/meta.dart';

import '../../../../../data/remote/dio.dart';
import '../../../../eventsPage/data/model/experienceModel.dart';
import '../../models/InternalEvent.dart';
import '../../models/activityModel.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final DioService dioService;

  ActivitiesCubit(this.dioService) : super(ActivitiesInitial());

  /////fetcInternalEvent
  Future<void> getInternalEventForCurrentUser({
    required DateTime date,
  }) async {
    // emit(InternalEventLoading());

    // String inputDate = "2025-01-07 14:29:30";//"2024-12-25 18:30:45";
    // DateTime parsedDate = DateTime.parse(inputDate);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    pragma(formattedDate);
    print("/////send date////////////////////////");
    try {
      final response = await dioService.getWithToken(
        "api/InternalEvent/getInternalEventForCurrentUser",
        queryParameters: {"date": formattedDate},
        //    token: accessToken,
      );
      print(
          "fetchEventsuccessful:///////////////////////////////////////// ${response.data}");
      List<dynamic> data = response.data;
      final List<InternalEventModel> InternalEvent =
          data.map((json) => InternalEventModel.fromJson(json)).toList();
      print(response.data);
      emit(InternalEventSuccess(InternalEvent));
      print("fetchEventsuccessful: ${response.data}");
    } on DioException catch (e) {
      print("/////fetchEvent////////////////////////");
      print("/////fetchEvent////////${e.response!}////////////////");

      emit(InternalEventFailure(e.response!.data.toString()));
    }
  }

  Future<void> getInternalEventDataById(int eventID) async {
    emit(InternalEventByIdLoading());
    try {
      final response = await dioService.getWithToken(
        "api/InternalEvent/getById",
        queryParameters: {
          "id": eventID
          //activityId
        },
      );
      //  print(response);
      dynamic data = response.data;
      final InternalEventModel eventByID = InternalEventModel.fromJson(data);
      // data.map((json) => EventModel.fromJson(json)).toList();
      print(eventByID.eventName);
      emit(InternalEventByIdSuccess(eventByID));
    } catch (e) {
      emit(InternalEventFailure(e.toString()));
    }
  }

  ///////////////////  getAllInternalEventsForNationalTeam ///////////
  //LacrosseApi/api/InternalEvent/getAllInternalEventsForNationalTeam
  Future<void> getAllInternalEventsForNationalTeam() async {
    // emit(InternalEventLoading());

    try {
      final response = await dioService.getWithoutToken(
        "api/InternalEvent/getAllInternalEventsForNationalTeam",
      );
      print(
          "getAllInternalEventsForNationalTeamSuccessful:///////////////////////////////////////// ${response.data}");
      List<dynamic> data = response.data;
      final List<InternalEventModel> InternalEvent =
          data.map((json) => InternalEventModel.fromJson(json)).toList();
      print(response.data);
      emit(GetAllInternalEventsForNationalTeamSuccess(InternalEvent));
      // print(response.data);

      print("getAllInternalEventsForNationalTeamSuccessful: ${response.data}");
      // emit(GetExperienceSuccess(Exp));
    } on DioException catch (e) {
      print("/////getAllInternalEventsForNationalTeam////////////////////////");
      print(
          "/////getAllInternalEventsForNationalTeam////////${e.response!}////////////////");

      // emit(InternalEventFailure(e.response!.data.toString()));
    }
  }

  ///// AddInternalEventReservation
  Future<void> addInternalEventReservation({
    required int internalEventId,
    required String name,
    required String phoneNumber,
  }) async {
    emit(AddInternalEventReservationLoading());
    try {
      final response = await dioService.postWithToken(
          "api/InternalEventReservation/AddInternalEventReservation",
          data: {
            "internalEventId": internalEventId,
            "name": name,
            "phoneNumber": "+966$phoneNumber"
          });

      print(response.data);

      print("AddInternalEventReservation successful://////////////");

      emit(AddInternalEventReservationSuccess());
    } on DioException catch (e) {
      print(
          "/////AddInternalEventReservation////////${e.response!.data}////////////////");
      print("////////AddInternalEventReservation/////////////////////");
      emit(AddInternalEventReservationFailure(e.message!));
    }
  }

  ///// addExperienceReservation   ////////////////
  Future<void> addExperienceReservation({
    required int experienceId,
    required String name,
    required String phoneNumber,
  }) async {
    emit(AddExperienceReservationLoading());
    try {
      final response = await dioService.postWithoutToken(
          "api/Experience/SubmitExperienceReservation",
          data: {
            "experienceId": experienceId,
            "name": name,
            "phoneNumber": "+966$phoneNumber"
          });

      print(response.data);

      print("AddExperienceReservation successful://////////////");

      emit(AddExperienceReservationSuccess());
    } on DioException catch (e) {
      print(
          "/////AddExperienceReservation////////${e.response!.data}////////////////");
      print("////////AddExperienceReservation/////////////////////");
      emit(AddExperienceReservationFailure(e.message!));
    }
  }

  ///////////  ///////////////
  /////////////////  getExperiences //////////////////////////
  Future<void> getAllExperiences() async {
    emit(GetAllExperienceLoading());

    // print("/////send date////////////////////////${date.toLocal().toString().split(' ')[0]}");
    try {
      final response = await dioService.getWithToken(
        "api/Experience/GetAllExperiences",

        //    token: accessToken,
      );
      print(
          "GetExperiencesSuccessful:///////////////////////////////////////// ${response.data}");
      List<dynamic> data = response.data;
      final List<ExperiencesModel> Exp =
          data.map((json) => ExperiencesModel.fromJson(json)).toList();
      // print(response.data);

      print("GetExperiencesSuccessful: ${response.data}");
      emit(GetAllExperienceSuccess(Exp));
    } on DioException catch (e) {
      print("/////GetExperiences////////////////////////");
      print("/////GetExperiences////////${e.response!}////////////////");

      // emit(InternalEventFailure(e.response!.data.toString()));
    }
  }

  ///////////////////get location name ///////////////////
  Future<String> getLocationName(double lat, double lon) async {
    try {
      // Perform reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.locality}, ${place.country}"; // Example: "Cairo, Egypt"
      } else {
        return "noLocation".tr();
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }

  ///////////////////deleteInternalEvent ///////////////////
  Future<void> deleteInternalEvent(int id) async {
    emit(DeleteInternalEventLoading());

    try {
      final response = await dioService.deleteWithToken(
          "api/InternalEvent/deleteInternalEvent",
          queryParameters: {"id": id}
        //    token: accessToken,
      );
      print(
          "DeleteEventResponse:///////////////////////////////////////// ${response
              .data}");
      // print(response.data);

      print("GetExperiencesSuccessful: ${response.data}");
      emit(DeleteInternalEventSuccess());
    } on DioException catch (e) {
      print("/////GetExperiences////////////////////////");
      print("/////GetExperiences////////${e.response!}////////////////");

      emit(DeleteInternalEventFailure(e.response!.data.toString()));
    }


  }
  Future<void> getFutureEvents({BuildContext?
   context}) async {
    emit(GetEventsLoading());

    // print("/////send date////////////////////////${date.toLocal().toString().split(' ')[0]}");
    try {
      final response = await dioService.getWithToken(
        "api/Event",
        queryParameters: {
          "langid":context?.locale.languageCode == 'ar'?1:context?.locale.languageCode == "en" ? 2:1 ,
        }

        //    token: accessToken,
      );
      print(
          "GetExperiencesSuccessful:///////////////////////////////////////// ${response
              .data}");
      List<dynamic> data = response.data;
      final List<EventModel> Exp =
      data.map((json) => EventModel.fromJson(json)).toList();
      // print(response.data);

      print("GetExperiencesSuccessful: ${response.data}");
      emit(GetEventsSuccess(Exp));
    } on DioException catch (e) {
      print("/////GetExperiences////////////////////////");
      print("/////GetExperiences////////${e.response!}////////////////");

      emit(GetEventsFailure(e.response!.data.toString()));
    }
  }
}
