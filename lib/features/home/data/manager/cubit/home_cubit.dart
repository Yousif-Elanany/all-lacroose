import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lacrosse/data/endPoints/endpoint.dart';
import 'package:lacrosse/features/home/data/models/PlayGroundModel.dart';
import 'package:lacrosse/features/home/data/models/aboutUnion.dart';
import 'package:lacrosse/features/home/data/models/gameReuleModel.dart';
import 'package:meta/meta.dart';

import '../../../../../data/Local/sharedPref/sharedPref.dart';
import '../../../../../data/remote/dio.dart';
import '../../../../ActivitesPage/data/models/activityModel.dart';
import '../../../../auth/data/model/team.dart';
import '../../../../eventsPage/data/model/natinalityModel.dart';
import '../../models/PlayerModel.dart';

import '../../models/advertisementModel.dart';
import '../../models/detailsModel.dart';
import '../../models/homeModel.dart';
import '../../models/markerModel.dart';
import '../../models/matchModel.dart';
import '../../models/model_team.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  final DioService dioService;

  HomeCubit(this.dioService) : super(HomeInitial());
//http://app774.uat.toq.sa/LacrosseApi/api/Home?langId=1

  List<TeamModel> teamsList = [];
  List<NationalityModel> nationalityList = [];
  Future<void> fetchAdvertisement() async {
    emit(AdvertisementDataLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Advertisement",
        queryParameters: {
          "langId": CacheHelper.getData(key: "lang") == "" ||
                  CacheHelper.getData(key: "lang") == null
              ? "1"
              : CacheHelper.getData(key: "lang")
        },
      );
      List<dynamic> data = response.data;
      final List<AdvertisementModel> advertise =
          data.map((json) => AdvertisementModel.fromJson(json)).toList();
      // print(advertise[0].img);

      emit(AdvertisementDataSuccess(advertise));
      //  print("ff");
    } catch (e) {
      emit(AdvertisementDataFailure(e.toString()));
    }
  }

  Future<void> fetchHomeData() async {
    //   emit(PlayerDataLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Home",
        queryParameters: {
          "langId": CacheHelper.getData(key: "lang") == "" ||
                  CacheHelper.getData(key: "lang") == null
              ? "1"
              : CacheHelper.getData(key: "lang")
        },
      );
      //  print("joooooooo11111");

      // print(response.data);
    } catch (e) {
      print("222222222222");

      print(e);

      //emit(PlayerDataFailure(e.toString()));
    }
  }

  Future<void> fetchGameRuleData() async {
    emit(GameRuleDataLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/GameRule",
        queryParameters: {
          "langId": CacheHelper.getData(key: "lang") == "" ||
                  CacheHelper.getData(key: "lang") == null
              ? "1"
              : CacheHelper.getData(key: "lang")
        },
      );

      List<GameRuleModel> list_Rolse = [];

      print(response.data);
      GameRuleModel model = GameRuleModel.fromJson(response.data);

      list_Rolse.add(model);
      emit(GameRuleDataSuccess(list_Rolse));

      print("GameRuleModel successful://////////////////////////////////");
    } catch (e) {
      print("GameRuleModel failure://////////////////////////////////");

      print(e);

      emit(GameRuleDataFailure(e.toString()));
    }
  }

  Future<void> fetchAboutUnionData() async {
    emit(AboutUnionDataLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/About",
        queryParameters: {
          "langId": CacheHelper.getData(key: "lang") == "" ||
                  CacheHelper.getData(key: "lang") == null
              ? "1"
              : CacheHelper.getData(key: "lang")
        },
      );

      AboutUnionModel model = AboutUnionModel.fromJson(response.data);
      emit(AboutUnionDataSuccess(model));

      // print(model.img);
      // print(model.title);
      // print(model.description1);
      // print(model.description2);
      // print(model.description3);
      print("fetchabout successful://////////////////////////////////");
    } catch (e) {
      print("fetchabout failure://////////////////////////////////");

      print(e);
    }
  }

  Future<void> fetchDetailsData() async {
    emit(DetailsDataLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Details",
        queryParameters: {
          "langId": CacheHelper.getData(key: "lang") == "" ||
                  CacheHelper.getData(key: "lang") == null
              ? "1"
              : CacheHelper.getData(key: "lang")
        },
      );
      print("fetch Details successful://////////////////////////////////");
      DetailsModel model = DetailsModel.fromJson(response.data);
      emit(DetailsDataSuccess(model));

      print(model.id);
      print(model.title);
      print(model.description);
      print(model.name);
    } catch (e) {
      print("fetch Details successful://////////////////////////////////");

      print(e);

      //emit(PlayerDataFailure(e.toString()));
    }
  }

  Future<void> fetchAllPlayerData() async {
    emit(PlayerDataLoading());
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
      emit(PlayerDataSuccess(players));
    } on DioException catch (e) {
      print("/////player////////${e.response!.data}////////////////");
      print("////////player/////////////////////");
      emit(PlayerDataFailure(e.response!.data.toString()));
    }
  }

  Future<void> fetchAllmatches() async {
    emit(MatchLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Match/getMatches",
      );
      print("////////matches/////////////////////");
      print(response.data);
      List<dynamic> data = response.data;
      final List<MatchModel> matches =
          data.map((json) => MatchModel.fromJson(json)).toList();
      print(matches);
      emit(MatchSuccess(matches));
    } catch (e) {
      print("////////matches/////////////////////");
      emit(MatchFailure(e.toString()));
    }
  }

  Future<void> fetchAlltEAMS() async {
    emit(TeamsLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Team/GetAllTeams",
        queryParameters: {
          "langId": CacheHelper.getData(key: "lang") == "" ||
                  CacheHelper.getData(key: "lang") == null
              ? "1"
              : CacheHelper.getData(key: "lang")
        },
      );
      print(response);
      List<dynamic> data = response.data;
      final List<teamModels> Teams =
          data.map((json) => teamModels.fromJson(json)).toList();
      print(Teams);
      emit(TeamsDataSuccess(Teams));
    } on DioException catch (e) {
      emit(TeamsFailure(e.toString()));
    }
  }

  Future<void> getNearestPlaygrounds({
    double? lat,
    double? long,
  }) async {
    emit(NearestPlaygroundsLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Playground/TheNearestPlaygrounds",
        queryParameters: {
          // "langId" :CacheHelper.getData(key: "lang") == "" ||CacheHelper.getData(key: "lang") == null  ? "1" :CacheHelper.getData(key: "lang"),
          "userLatitude": lat,
          "userLongitude": long,
        },
      );
      print(response);
      List<dynamic> data = response.data;
      final List<LocationMarkerModel> markers =
          data.map((json) => LocationMarkerModel.fromJson(json)).toList();
      print(markers[0].name);
      emit(NearestPlaygroundsDataSuccess(markers));
    } on DioException catch (e) {
      emit(TeamsFailure(e.toString()));
    }
  }

  Future<dynamic> fetchPlayerDataById(String playerId) async {
    emit(getPlayerDataLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Player/$playerId",
      );
      print(response.data);
      final PlayerModel playerData = PlayerModel.fromJson(response.data);

      print(playerData);
      emit(getPlayerDataSuccess(playerData));
      fetchAllTeams();
    } catch (e) {
      emit(getPlayerDataFailure(e.toString()));
    }
  }

  Future<dynamic> fetchAllTeams() async {
    emit(fetch_team_loading()); // اختياري لو عندك حالة لودنج
    try {
      final response = await dioService.getWithoutToken(
        "api/Team/GetAllTeams",
      );
      List<dynamic> data = response.data;
      final List<TeamModel> teams =
          data.map((json) => TeamModel.fromJson(json)).toList();

      print("team done ///////////////////");

      // خزنهم في cubit عشان تستخدمهم في الـ Dropdown
      teamsList = teams;

      emit(fetch_team_success(teams));
      fetchAllNationality();
    } catch (e) {
      print("none ///////////////////");
      emit(fetch_team_failure(e.toString()));
    }
  }

  Future<dynamic> fetchAllNationality() async {
    emit(fetch_Nationality_loading()); // اختياري لو عندك حالة لودنج
    try {
      final response = await dioService.getWithoutToken(
        "api/Team/GetAllNationalities",
      );
      List<dynamic> N = response.data;
      final List<NationalityModel> nationality =
          N.map((json) => NationalityModel.fromJson(json)).toList();

      print("Nationality done ///////////////////");

      nationalityList = nationality;

      emit(fetch_Nationality_success(nationality));
    } catch (e) {
      print("////// none ///////////////////");
      emit(fetch_Nationality_failure(e.toString()));
    }
  }

  Future<void> fetchAllEditPlayerData(String playerId) async {
    emit(getPlayerDataLoading());
    try {
      // 1- Player
      final playerResponse =
          await dioService.getWithoutToken("api/Player/$playerId");
      final PlayerModel playerData = PlayerModel.fromJson(playerResponse.data);

      // 2- Teams
      final teamsResponse =
          await dioService.getWithoutToken("api/Team/GetAllTeams");
      List<dynamic> teamJson = teamsResponse.data;
      final List<TeamModel> teams =
          teamJson.map((json) => TeamModel.fromJson(json)).toList();

      // 3- Nationalities
      final natResponse =
          await dioService.getWithoutToken("api/Team/GetAllNationalities");
      List<dynamic> natJson = natResponse.data;
      final List<NationalityModel> nationalities =
          natJson.map((json) => NationalityModel.fromJson(json)).toList();

      // ✅ رجّعهم كلهم مع بعض
      emit(EditPlayerLoaded(
        player: playerData,
        teams: teams,
        nationalities: nationalities,
      ));
    } catch (e) {
      emit(getPlayerDataFailure(e.toString()));
    }
  }

  Future<void> editPlayerData(String playerId) async {
    emit(getPlayerDataLoading());
    try {
      // 1- Player
      final playerResponse =
          await dioService.getWithoutToken("api/Player/$playerId");
      final PlayerModel playerData = PlayerModel.fromJson(playerResponse.data);

      // 2- Teams
      final teamsResponse =
          await dioService.getWithoutToken("api/Team/GetAllTeams");
      List<dynamic> teamJson = teamsResponse.data;
      final List<TeamModel> teams =
          teamJson.map((json) => TeamModel.fromJson(json)).toList();

      // 3- Nationalities
      final natResponse =
          await dioService.getWithoutToken("api/Team/GetAllNationalities");
      List<dynamic> natJson = natResponse.data;
      final List<NationalityModel> nationalities =
          natJson.map((json) => NationalityModel.fromJson(json)).toList();

      // ✅ رجّعهم كلهم مع بعض
      emit(EditPlayerLoaded(
        player: playerData,
        teams: teams,
        nationalities: nationalities,
      ));
    } catch (e) {
      emit(getPlayerDataFailure(e.toString()));
    }
  }

  Future<void> updatePlayerData({
    required String id,
    required String displayName,
    required String birthDate,
    required String city,
    required String area,
    required String address,
    required int teamId,
    required int nationalityId,
    File? imageFile, // نخلي الصورة اختيارية
  }) async {
    try {
      emit(UpdatePlayerLoading());

      final formData = FormData.fromMap({
        "Id": id,
        "DisplayName": displayName,
        "BirthDate": birthDate, // yyyy-MM-dd
        "City": city,
        "Area": area,
        "Address": address,
        "TeamId": teamId,
        "NationalityId": nationalityId,
        "Image": imageFile != null
            ? await MultipartFile.fromFile(
                imageFile.path,
                filename: imageFile.path.split('/').last,
              )
            : "", // لو مفيش صورة
      });

      final response = await dioService.putWithToken(
        "api/Player",
        data: formData,
      );

      if (response.statusCode == 200) {
        print("Player updated successfully");
        emit(UpdatePlayerSuccess());
        fetchAllPlayerData();
      } else if (response.statusCode == 400) {
        emit(UpdatePlayerFailure("لم يتم تعديل البيانات ❌"));
      } else {
        emit(UpdatePlayerFailure("حدث خطأ غير متوقع"));
      }
    } catch (e) {
      emit(UpdatePlayerFailure("مشكلة في الاتصال: $e"));
    }
  }

  Future<void> fetchPlayGround() async {
    emit(FetchPlayGroundLoading()); // حالة اللودنج
    try {
      final response = await dioService.getWithoutToken(
        "api/Playground/GetAllPlaygrounds",
      );

      // تحويل البيانات إلى موديل
      List<dynamic> data = response.data;
      final List<PlayGroundModel> playGrounds =
          data.map((json) => PlayGroundModel.fromJson(json)).toList();

      emit(FetchPlayGroundSuccess(playGrounds)); // حالة النجاح
    } catch (e) {
      emit(FetchPlayGroundFailure(
          "حدث خطأ أثناء جلب البيانات: $e")); // حالة الفشل
    }
  }

  Future<void> addPlayGround({String? name, String? lat, String? long}) async {
    // 1️⃣ حالة التحميل
    emit(AddPlayGroundLoading());

    try {
      final response = await dioService.postWithToken(
        "api/Playground/AddPlayground",
        data: {
          "name": name,
          "longitude": long,
          "latitude": lat,
        },
      );

      // 2️⃣ حالة النجاح
      if (response.statusCode == 200) {
        emit(AddPlayGroundSuccess());

        // ⬅ هنا استدعي جلب كل الملاعب لتحديث القائمة تلقائياً
        await fetchPlayGround();
      }
      // 3️⃣ حالة الفشل
      else {
        emit(AddPlayGroundFailure(
            "لم يتم إضافة الملعب، كود الحالة: ${response.statusCode}"));
      }
    } catch (e) {
      // 3️⃣ حالة الفشل عند حدوث استثناء
      emit(AddPlayGroundFailure("حدث خطأ أثناء العملية: $e"));
    }
  }

  Future<void> editPlayGround(
      {int? id, String? name, String? lat, String? long}) async {
    emit(EditPlayGroundLoading()); // حالة اللودنج
    try {
      final response = await dioService.putWithToken(
        "api/Playground/UpdatePlaygroundData",
        data: {
          "id": id,
          "name": name,
          "longitude": long,
          "latitude": lat,
        },
      );
      if (response.statusCode == 200) {
        print("Player updated successfully");
        emit(EditPlayGroundSuccess());
        fetchPlayGround();
      } else if (response.statusCode == 400) {
        emit(EditPlayGroundFailure("لم يتم تعديل البيانات ❌"));
      } else {
        emit(EditPlayGroundFailure("حدث خطأ غير متوقع"));
      }
    } catch (e) {
      emit(EditPlayGroundFailure("مشكلة في الاتصال: $e"));
    }
  }

  Future<void> fetchAllTrainersData() async {
    emit(TrainerDataLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Player/getTrainers",
      );
      List<dynamic> data = response.data;

      List<PlayerModel> trainers =
          data.map((json) => PlayerModel.fromJson(json)).toList();

      print(response.data);
      print("player successful://////////////");

      print(CacheHelper.getData(key: "accessToken"));
      emit(TrainerDataSuccess(trainers));
    } on DioException catch (e) {
      print("/////player////////${e.response!.data}////////////////");
      print("////////player/////////////////////");
      emit(TrainerDataFailure(e.response!.data.toString()));
    }
  }

  Future<void> editMatchScoresData({
    int? id,
    int? totalFirstTeamGoals,
    int? totalSecondTeamGoals,
    String? appointment,
  }) async {
    emit(EditMatchLoading());

    try {
      final response = await dioService.putWithToken(
        "api/Match/$id",
        data: {
          "totalFirstTeamGoals": totalFirstTeamGoals,
          "totalSecondTeamGoals": totalSecondTeamGoals,
          "appointment": appointment,
        },
      );

      // التحقق من status code
      if (response.statusCode == 200) {
        // هنا ممكن تعالج البيانات لو حابب
        print("تم تحديث المباراة بنجاح: ${response.data}");
        emit(EditMatchSuccess());
        fetchAllmatches(); // تحديث قائمة المباريات بعد التعديل
      } else if (response.statusCode == 400) {
        print("حدث خطأ في الطلب: ${response.data}");
        emit(EditMatchFailure("حدث خطأ: ${response.data}"));
      } else {
        // أي كود حالة آخر
        emit(EditMatchFailure("حدث خطأ غير متوقع: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      print("خطأ أثناء الاتصال بالـ API: ${e.response?.data}");
      emit(EditMatchFailure(
          "خطأ أثناء الاتصال بالـ API: ${e.response?.data ?? e.message}"));
    } catch (e) {
      emit(EditMatchFailure("خطأ غير متوقع: $e"));
    }
  }

  Future<void> editClub({
    int? id,
    String? name,
  }) async {
    emit(EditTeamLoading()); // حالة اللودنج
    try {
      FormData formData = FormData.fromMap({
        "Id": id,
        "Name": name,
      });
      final response = await dioService.putWithToken(
        "api/Team/Update",
        data: formData,
      );
      if (response.statusCode == 200) {
        print("Player updated successfully");
        emit(EdiTeamSuccess());
        fetchAlltEAMS();
      } else if (response.statusCode == 400) {
        emit(EditTeamFailure("لم يتم تعديل البيانات ❌"));
      } else {
        emit(EditTeamFailure("حدث خطأ غير متوقع"));
      }
    } catch (e) {
      emit(EditTeamFailure("مشكلة في الاتصال: $e"));
    }
  }

  Future<void> deletePlayer({String? id}) async {
    emit(DeletePlayerLoading()); // ✅ غيّر اسم الحالة لتعبّر عن الحذف
    try {
      final formData = FormData.fromMap({
        "id": id,
      });

      final response = await dioService.deleteWithTokenFormData(
        "api/Player", // ✅ لو الـ endpoint فعلاً لحذف اللاعب
        data: formData,
      );

      if (response.statusCode == 200) {
        print("✅ Player deleted successfully");
        emit(DeletePlayerSuccess());
        fetchAllPlayerData();
        fetchAllTrainersData();
      } else if (response.statusCode == 400) {
        emit(DeletePlayerFailure("لم يتم حذف اللاعب ❌"));
      } else {
        emit(DeletePlayerFailure("حدث خطأ غير متوقع ⚠️"));
      }
    } catch (e) {
      emit(DeletePlayerFailure("مشكلة في الاتصال: $e"));
    }
  }

  Future<void> getFutureEvents({context}) async {
    emit(GetHomeEventsLoading());

    // print("/////send date////////////////////////${date.toLocal().toString().split(' ')[0]}");
    try {
      final response =
          await dioService.getWithToken("api/Event", queryParameters: {
        "langId": CacheHelper.getData(key: "lang") == "" ||
          CacheHelper.getData(key: "lang") == null
          ? "1"
              : CacheHelper.getData(key: "lang")
      }

              //    token: accessToken,
              );
      print(
          "GetExperiencesSuccessful:///////////////////////////////////////// ${response.data}");
      List<dynamic> data = response.data;
      final List<EventModel> Exp =
          data.map((json) => EventModel.fromJson(json)).toList();
      // print(response.data);

      print("GetExperiencesSuccessful: ${response.data}");
      emit(GetHomeEventsSuccess(Exp));
    } on DioException catch (e) {
      print("/////GetExperiences////////////////////////");
      print("/////GetExperiences////////${e.response!}////////////////");

      emit(GetHomeEventsFailure(e.response!.data.toString()));
    }
  }
}
