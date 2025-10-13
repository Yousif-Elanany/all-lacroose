import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_states.dart';
import 'package:lacrosse/features/auth/data/model/Login_model.dart';
import 'package:lacrosse/features/eventsPage/data/model/player_model.dart';
import 'package:lacrosse/features/eventsPage/data/model/team.dart';
import '../../../../../data/remote/dio.dart';
import '../../../../ActivitesPage/data/models/userAttendenceModel.dart';
import '../../model/IntentityNewsModel.dart';
import '../../model/eventModel.dart';
import '../../model/experienceModel.dart';
import '../../model/natinalityModel.dart';
import '../../model/registerModel.dart';
import '../../model/reservationsNodel.dart';
import 'manager_states.dart';

class managerCubit extends Cubit<ManagerStates> {
  final DioService dioService;

  managerCubit(this.dioService) : super(manager_initial());

  AddEventModel? model;

  Future<void> addUserByManager({
    required String email,
    required String pass,
    required String name,
    required String birthdate,
    required String phone,
    required String city,
    required String area,
    required String address,
    required int type,
    required int teamId,
    required int nationality_id,
    File? file,
  }) async {
    emit(addUserLoading());
    try {
      FormData formData = FormData.fromMap({
        "Image": "",
        'Email': email,
        'Password': pass,
        'ConfirmPassword': pass,
        'Type': type,
        'displayName': name,
        'BirthDate': birthdate,
        'PhoneNumber': phone,
        'TeamId': teamId, //'3',
        'NationalityId': nationality_id, //'1',
        'City': city, //
        'Area': area, //'
        'Address': address, //

        "file": await MultipartFile.fromFile(
          file!.path,
          filename: file.path.split('/').last,
        ),
      });
      final response = await dioService
          .postWithTokenForUploadImages("api/Auth/addUser", formData: formData);

      // AddEventModel model = AddEventModel.fromJson(response.data);
      print("from method");

      // print(response.data["file"]);
      print(response.data);
      emit(addUserSuccess());

      print("addUser successful: ${response.statusCode}");
      print("addUser successful:: ${response.data}");
    } on DioException catch (e) {
      print("/////addUser////////${e.response!.data}////////////////");
      print("////////addUser/////////////////////");
      emit(addUserFailure(e.response!.data.toString()));
    }
  }

  Future<void> addClubByManager({
    required String name,
    required File? file,
    String image = "",
  }) async {
    emit(addClubLoading());
    try {
      FormData formData = FormData.fromMap({
        "Image": "",
        'Name': name,
        "file": file != null
            ? await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              )
            : ""
      });
      final response = await dioService
          .postWithTokenForUploadImages("api/Team/Create", formData: formData);

      print("from method");

      print(response.data);
      emit(addClubSuccess());

      print(" addClubByManager successful: ${response.statusCode}");
      print(" addClubByManager successful:: ${response.data}");
    } on DioException catch (e) {
      print(
          "///// addClubByManager////////${e.response!.data}////////////////");
      print("//////// addClubByManager/////////////////////");
      emit(addClubFailure(e.response!.data.toString()));
    }
  }

  // Future<void> addUserByManager({
  //   required String email,
  //   required String pass,
  //   required String name,
  //   required String birthdate,
  //   required String phone,
  //   required String city,
  //   required String area,
  //   required String address,
  //   required int type,
  //   required int teamId,
  //   required int nationality_id,
  //   File? file,
  //   String image = "",
  // }) async {
  //   emit(addUserLoading());
  //   try {
  //     final response = await dioService.postWithTokenFromManager(
  //       "api/Auth/addUser",
  //       data: {
  //         "Image": "",
  //         'Email': email,
  //         'Password': pass,
  //         'ConfirmPassword': pass,
  //         'Type': type,
  //         'displayName': name,
  //         'BirthDate': birthdate,
  //         'PhoneNumber': phone,
  //         'TeamId': teamId, //'3',
  //         'NationalityId': nationality_id, //'1',
  //         'City': city, //
  //         'Area': area, //'
  //         'Address': address, //
  //         "file": file
  //       },
  //     );
  //     // RegisterModel model = RegisterModel.fromJson(response.data);
  //     // print(model.displayName);
  //     // CacheHelper.saveData(key: "accessToken", value: model.accessToken);
  //     // CacheHelper.saveData(key: "roles", value: model.roles[0]);
  //     // print(CacheHelper.getData(key: "accessToken"));
  //
  //
  //     print("Registration successful://////////////////////////////////");
  //     print("add done successful: ${response.data}");
  //     emit(addUserSuccess());
  //   } on DioException catch (e) {
  //     print("//////Registration///////////////////////");
  //     print("///////Registration//////${e.response!.statusMessage}////////////////");
  //     print("///////////Registration//////////////////");
  //     print("DioException occurred:");
  //     print("Status Code: ${e.response?.statusCode ?? 'Unknown'}");
  //     // print("Error Data: ${e.response?.data ?? 'No additional error data'}");
  //     print("Message: ${e.message}");
  //     emit(addUserFailure(e.response!.data.toString()));
  //   } catch (e) {
  //     print("An unexpected error occurred: $e");
  //   }
  // }
  // Future<void> addClubByManagerxxxx({
  //   required String name,
  //   required File? file,
  //   String image = "",
  // }) async {
  //   emit(addUserLoading());
  //   try {
  //
  //     final response = await dioService.postWithTokenFromManager(
  //       "api/Team/Create",
  //       data: {"Image": "",
  //         'Name': name,
  //         "file":
  //         file ?? ""},
  //     );
  //     print("add done successful: ${response.data}");
  //     emit(addUserSuccess());
  //   } on DioException catch (e) {
  //     print(
  //         "///////Registration//////${e.response!.statusMessage}////////////////");
  //
  //     emit(addUserFailure(e.response!.data.toString()));
  //   } catch (e) {
  //     print("An unexpected error occurred: $e");
  //   }
  // }

  Future<void> allreguestsAboutEventByManager({
    required int EventId,
    required int classification,
  }) async {
    emit(getAttendenceRequestsLoading());
    try {
      final response = await dioService.GetWithTokenFromManager(
        "api/InternalEvent/allUsersInEvent",
        param: {"EventId": EventId, "classification": classification},
        data: {},
      );
      List<dynamic> data = response.data;
      final List<UserAttendenceModel> UserAttendenceModelList =
          data.map((json) => UserAttendenceModel.fromJson(json)).toList();
      print("add done successful: ${response.data}");
      emit(getAttendenceRequestsSuccess(UserAttendenceModelList));
    } on DioException catch (e) {
      print(
          "///////Registration//////${e.response!.statusMessage}////////////////");

      emit(getAttendenceRequestsFailure(e.response!.data.toString()));
    } catch (e) {
      print("An unexpected error occurred: $e");
    }
  }

  Future<void> approveOrRejectAttendenceRequestFromManager({
    required String userId,
    required int eventId,
    required bool status,
    String? absenceReason,
  }) async {
    emit(addUserLoading());
    try {
      final response = await dioService.postWithTokenFromManagerForEdit(
        "api/InternalEvent/attendanceRegister",
        param: {
          "userId": userId,
          "eventId": eventId,
          "status": status,
          "absenceReason": absenceReason
        },
        data: {},
      );
      print("add done successful: ${response.data}");
      emit(addUserSuccess());
    } on DioException catch (e) {
      print(
          "///////Registration//////${e.response!.statusMessage}////////////////");

      emit(addUserFailure(e.response!.data.toString()));
    } catch (e) {
      print("An unexpected error occurred: $e");
    }
  }

  /////Add matchEvent
  Future<void> addNewMatchEvent({
    required int eventType,
    required String startDate_Time,
    required String endDate_Time,
    required String location,
    required String eventName,
    required int teamType,
    required String description,
    required int firstTeamId,
    required int secondTeamId,
    required List<ApplicationUserInternalEvent> listApplicationPlayers,
    required List<InternalEventFile> listApplicationLink,
  }) async {
    emit(AddNewEventLoading());
    try {
      // يعرض التاريخ بنفس التنسيق
      final response = await dioService.postWithToken(
        "api/InternalEvent/CreateInternalEvent",
        data: {
          "eventType": eventType,
          "eventName": eventName,
          "from": startDate_Time, // "2025-01-04T21:02:17.427Z",
          "to": endDate_Time, //"2025-01-04T21:02:17.427Z",
          "eventLocation": location,
          "teamType": teamType,

          "description": description,
          "firstTeamId": firstTeamId, //firstTeamId,//3,
          "secondTeamId": secondTeamId, //secondTeamId,// 6,
          "applicationUserInternalEvents": toJsonList(listApplicationPlayers),
          "internalEventFiles":
              listApplicationLink, //toJsonList2(listApplicationLink),
          // "applicationUserInternalEvents": [
          //   {
          //     "applicationUserId": "bbcb4864-28fd-4f09-ac73-097a65062d6e",
          //     "internalEventId": 0
          //   }
          // ],
          // "internalEventFiles": [
          //   {
          //     "internalEventId": 0,
          //     "file": "Images\InternalEventImage\e2836b14-58c0-4d48-b81a-26b5e09b6514.jpg"
          //     //"ImagesInternalEventImagee2836b14-58c0-4d48-b81a-26b5e09b6514.jpg"
          //   //  Images\\InternalEventImage\\5a16d19c-e49b-4b80-853f-1ee2fd50ae34.jpg"
          // //    Images\\InternalEventImage\\e78d393c-cabe-41ac-8392-992f8796d66a.png
          //    // Images\InternalEventImage\5a16d19c-e49b-4b80-853f-1ee2fd50ae34.jpg
          //   }
          // ]
        },
      );

      AddEventModel model = AddEventModel.fromJson(response.data);
      print(model.description);
      print(response.data);

      print("AddEvent successful://////////////");
      print("AddEvent successful: ${response}");
      emit(AddNewEventSuccess());
    } on DioException catch (e) {
      print("/////AddEvent////////${e.response!.data}////////////////");
      print("////////AddEvent/////////////////////");
      emit(AddNewEventFailure(e.response!.data.toString()));
    }
  }

  /////Add trainerEvent //////////////
  Future<void> addNewTrainingEvent({
    required int eventType,
    required String startDate_Time,
    required String endDate_Time,
    required String location,
    required String eventName,
    required String description,
    required int teamType,
    required List<ApplicationUserInternalEvent> listApplicationPlayers,
    required List<InternalEventFile> listApplicationLink,
  }) async {
    emit(AddNewEventLoading());
    try {
      final response = await dioService.postWithToken(
        "api/InternalEvent/CreateInternalEvent",
        data: {
          "eventType": eventType,
          "eventName": eventName,
          "from": startDate_Time, // "2025-01-04T21:02:17.427Z",
          "to": endDate_Time, //"2025-01-04T21:02:17.427Z",
          "eventLocation": location,
          "description": description,
          "teamType": teamType,
          "applicationUserInternalEvents": toJsonList(listApplicationPlayers),

          "internalEventFiles": toJsonList2(listApplicationLink)
        },
      );

      print(response.data);

      print("AddEvent successful://////////////");
      print("AddEvent successful: ${response}");
        emit(AddNewEventSuccess());
    } on DioException catch (e) {
      print("/////AddEvent////////${e.response!.data}////////////////");
      print("////////Login/////////////////////");
      emit(AddNewEventFailure(e.response!.data.toString()));
    }
  }

  /////Add trainerEvent //////////////
  Future<void> addEvent({
    required String Name,
    required String Description,
    required String Location,
    required String FromDay,
    required String ToDay,
    required String FromTime,
    required String ToTime,
    File? file,
  }) async {
    emit(AddEventLoading());
    try {
      final formData = FormData.fromMap({
        "LangId": CacheHelper.getData(key: "lang") ?? 1,
        "Name": Name,
        "MapLink": "Try to add map link",
        "Notes": "Try to add notes",
        "FromDay": FromDay, // ex: "2025-01-04"
        "ToDay": ToDay, // ex: "2025-01-05"
        "FromTime": FromTime, // ex: "14:30"
        "ToTime": ToTime, // ex: "18:00"
        "Description": Description,
        "Location": Location,
        "file": (file != null)
            ? await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              )
            : "",
      });
      final response = await dioService.postWithToken(
        "api/Event/Create",
        data: formData,
      );
      if (response.statusCode == 200) {
        print(response.data);
        emit(AddEventSuccess());
      } else if (response.statusCode == 400)
        print("AddEvent successful://////////////");
      print("AddEvent successful: ${response}");
    } on DioException catch (e) {
      print("/////AddEvent////////${e.response!.data}////////////////");
      print("////////Login/////////////////////");
      emit(AddEventFailure(e.response!.data.toString()));
    }
  }

  /////Add News
  Future<void> addNewsEvent({
    required String image,
    required String title,
    required String description,
    required List<NewsDetailModel> listNewsDetails,
  }) async {
    emit(AddNewsEventLoading());
    try {

      FormData formData = FormData.fromMap({
        "LangId": 1,
        "File": image == "" ? null : image,
        "Title": title,
        "Description": description,
        "NewsDetails": detailsToJsonList(listNewsDetails),
      });
      final response = await dioService.postWithToken(
        "api/News/Create",
        data:formData,
      );

      print(response.data);

      print("AddEvent successful://////////////");
      print("AddEvent successful: ${response}");
      emit(AddNewsEventSuccess());
    } on DioException catch (e) {
      print("/////AddEvent////////${e.response!.data}////////////////");
      print("////////Login/////////////////////");
      emit(AddNewsEventFailure(e.response!.data.toString()));
    }
  }

  ///// CreateExperience
  Future<void> createExperience({
    required String appointment,
    required String fromTime,
    required String toTime,
    required String longitude,
    required String latitude,
  }) async {
    emit(CreateExperienceLoading());
    try {
      final response = await dioService.postWithToken(
        "api/Experience/CreateExperience",
        data: {
          "appointment": appointment,
          "fromTime": fromTime,
          "toTime": toTime,
          "longitude": longitude,
          "latitude": latitude
        },
      );

      print(response.data);

      print("CreateExperience successful://////////////");
      print("CreateExperience successful: ${response}");
      emit(CreateExperienceSuccess());
    } on DioException catch (e) {
      print("/////CreateExperience////////${e.response!.data}////////////////");
      print("////////CreateExperience/////////////////////");
      emit(CreateExperienceFailure(e.response!.data.toString()));
    }
  }

///////// players /////  String encodedFile = encodeFileToBase64(file);
  /////upload image_Video
  Future<void> uploadImage_video({
    required File file,
  }) async {
    emit(Image_videoloading());
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });
      final response = await dioService.postWithTokenForUploadImages(
          "api/InternalEvent/UploadFile(Image/Video)",
          formData: formData);

      // AddEventModel model = AddEventModel.fromJson(response.data);
      print("from method");

      print(response.data["file"]);

      print("image_Video successful://////////////");
      print("image_Video successful: ${response.data}");
      emit(Image_videoSuccess(response.data["file"]));
    } on DioException catch (e) {
      print("/////image_Video////////${e.response!.data}////////////////");
      print("////////image_Video/////////////////////");
      emit(Image_videoFailure(e.response!.data.toString()));
    }
  }

/////////
  Future<void> uploadImage_video2({
    required File file,
  }) async {
    emit(Image_videoloading());
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });
      final response = await dioService.postWithTokenForUploadImages(
          "api/InternalEvent/UploadFile(Image/Video)",
          formData: formData);

      // AddEventModel model = AddEventModel.fromJson(response.data);
      print("from method");

      print(response.data["file"]);

      print("image_Video successful://////////////");
      print("image_Video successful: ${response.data}");
      emit(Image_videoSuccess(response.data["file"]));
    } on DioException catch (e) {
      print("/////image_Video////////${e.response!.data}////////////////");
      print("////////image_Video/////////////////////");
      emit(Image_videoFailure(e.response!.data.toString()));
    }
  }

  //////////// fetch players ////////////
  Future<void> fetchAllPlayerData() async {
    emit(PlayerLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Player/getPlayers",
      );
      List<dynamic> data = response.data;

      List<PlayerModel> players =
          data.map((json) => PlayerModel.fromJson(json)).toList();

      print(response.data);
      print("player successful://////////////");

      print(CacheHelper.getData(key: "accessToken"));
      emit(PlayerSuccess(players));
    } on DioException catch (e) {
      print("/////player////////${e.response!.data}////////////////");
      print("////////player/////////////////////");
      emit(PlayerFailure(e.response!.data.toString()));
    }
  }

  //////////// fetch Trainer ////////////
  Future<void> fetchAllTrainerData() async {
    emit(TrainerLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Player/getTrainers",
      );
      List<dynamic> data = response.data;

      List<PlayerModel> trainer =
          data.map((json) => PlayerModel.fromJson(json)).toList();

      print(response.data);
      print("trainer successful://////////////");

      print(CacheHelper.getData(key: "accessToken"));
      emit(TrainerSuccess(trainer));
    } on DioException catch (e) {
      print("/////trainer////////${e.response!.data}////////////////");
      print("////////trainer/////////////////////");
      emit(TrainerFailure(e.response!.data.toString()));
    }
  }

  ///////tems ////////
  Future<void> fetchAllTeams() async {
    try {
      final response = await dioService.getWithoutToken(
        "api/Team/GetAllTeams",
      );
      List<dynamic> data = response.data;
      final List<TeamMMModel> teams =
          data.map((json) => TeamMMModel.fromJson(json)).toList();
      print("  team done ///////////////////");
      print(teams);
      print(response.data);

      emit(fetch_team2_success(Team: teams));
    } catch (e) {
      print(" none ///////////////////");
      // emit(NewsFailure(e.toString()));
    }
  }

  /////////////////  getExperiences //////////////////////////
  Future<void> getExperiences({
    required String date,

    // (http://app774.uat.toq.sa/LacrosseApi/api/Experience/GetExperiences?date=2025-02-25)
  }) async {
    // emit(InternalEventLoading());

    try {
      final response = await dioService.getWithToken(
        "api/Experience/GetExperiences",
        queryParameters: {
          "date":date,
        //    token: accessToken,
        },
      );
      List<dynamic> data = response.data;
      final List<ExperiencesModel> Exp =
          data.map((json) => ExperiencesModel.fromJson(json)).toList();
      // print(response.data);

      print("GetExperiencesSuccessful: ${response.data}");
      emit(GetExperienceSuccess(Exp));
    } on DioException catch (e) {
      print("/////GetExperiences////////////////////////");
      print("/////GetExperiences////////${e.response!}////////////////");

      // emit(InternalEventFailure(e.response!.data.toString()));
    }
  }

  //(http://app774.uat.toq.sa/LacrosseApi/api/Experience/GetExperienceReservations?experienceId=1 )
//////////////////// GetExperienceReservations //////////////////
  Future<void> getExperienceReservations({
    required int experienceId,
  }) async {
    // emit(InternalEventLoading());

    print("/////send date////////////////////////");
    try {
      final response = await dioService.getWithToken(
        "api/Experience/GetExperienceReservations",
        queryParameters: {"experienceId": experienceId},
        //    token: accessToken,
      );
      print(
          "GetExperienceReservationsSuccessful:///////////////////////////////////////// ${response.data}");
      // List<dynamic> data = response.data;
      // final List<ReservationModel> res =
      // data.map((json) => ReservationModel.fromJson(json)).toList();

      print(response.data);
      emit(GetExperienceReservationsSuccess(
          ReservationModel.fromJson(response.data)));
      print("GetExperienceReservationsSuccessful: ${response.data}");
    } on DioException catch (e) {
      print("/////GetExperienceReservations////////////////////////");
      print(
          "/////GetExperienceReservations////////${e.response!}////////////////");

      // emit(InternalEventFailure(e.response!.data.toString()));
    }
  }
  ////////////////DeleteExperience /////////

  Future<void> deleteExperience({
    required int experienceId,
  }) async {
    emit(DeleteExperienceLoading());

    print("/////DeleteExperience////////////////////////");
    try {
      final response = await dioService.deleteWithToken(
        "api/Experience/DeleteExperience",
        queryParameters: {"id": experienceId},
        //    token: accessToken,
      );
      print(
          "DeleteExperienceSuccessful:///////////////////////////////////////// ${response.data}");
      // List<dynamic> data = response.data;
      // final List<ReservationModel> InternalEvent =
      // data.map((json) => ReservationModel.fromJson(json)).toList();
      print(response.data);
      emit(DeleteExperienceSuccess());
      print("DeleteExperienceSuccessful: ${response.data}");
    } on DioException catch (e) {
      print("/////DeleteExperience////////////////////////");
      print("/////DeleteExperience////////${e.response!}////////////////");

      emit(DeleteExperienceFailure(e.response!.data.toString()));
    }
  }

  Future<void> updateExperience({
    required int experienceId,
    required String appointment,
    required String fromTime,
    required String toTime,
    required String longitude,
    required String latitude,
  }) async {
    emit(UpdateExperienceLoading());

    print("/////DeleteExperience////////////////////////");
    try {
      final response = await dioService.putWithToken(
        "api/Experience/UpdateExperience",
        data: {
          "id": experienceId,
          "appointment": appointment,
          "fromTime": fromTime,
          "toTime": toTime,
          "longitude": longitude,
          "latitude": latitude
        },
        //    token: accessToken,
      );
      print(
          "DeleteExperienceSuccessful:///////////////////////////////////////// ${response.data}");
      // List<dynamic> data = response.data;
      // final List<ReservationModel> InternalEvent =
      // data.map((json) => ReservationModel.fromJson(json)).toList();
      print(response.data);
      emit(UpdateExperienceSuccess());
      getExperiences(date: DateTime.now().toString().split(" ").first);
      print("DeleteExperienceSuccessful: ${response.data}");
    } on DioException catch (e) {
      print("/////DeleteExperience////////////////////////");
      print("/////DeleteExperience////////${e.response!}////////////////");

      emit(UpdateExperienceError(e.response!.data.toString()));
    }
  }
}
