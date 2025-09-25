import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_states.dart';
import 'package:lacrosse/features/auth/data/model/Login_model.dart';
import 'package:lacrosse/features/auth/data/model/team.dart';
import '../../../../../data/remote/dio.dart';
import '../../model/natinalityModel.dart';
import '../../model/ordelModel.dart';
import '../../model/registerModel.dart';

class AuthCubit extends Cubit<AuthStates> {
  final DioService dioService;

  AuthCubit(this.dioService) : super(Auth_initial());
  Future<void> registerUserData(
      {
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
        String image = "",

      }
      ) async {
    emit(RegisterLoading());
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

        "file": (file!=null)?await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ):"",
      });
      final response = await dioService.postWithTokenForUploadImages(

          "api/Auth/register",

          formData: formData


      );

      // AddEventModel model = AddEventModel.fromJson(response.data);
      print("from method");

      print(response.data["file"]);
      print(response.data);
      emit(RegisterSuccess());

      print("Registration successful: ${response.statusCode}");
      print("Registration successful:: ${response.data}");
      emit((response.data["file"]));
    } on DioException catch (e) {
      print("/////Registration////////${e.response!.data}////////////////");
      print("////////Registration/////////////////////");
      emit(RegisterFailure(e.response!.data.toString()));
    }
  }
  // Future<void> registerUserData({
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
  //   emit(RegisterLoading());
  //   try {
  //     final response = await dioService.postWithoutTokenForRegister(
  //       "api/Auth/register",
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
  //     print("Registration successful: ${response.statusCode}");
  //     emit(RegisterSuccess());
  //   } on DioException catch (e) {
  //     print("//////Registration///////////////////////");
  //     print("///////Registration//////${e.response!.data}////////////////");
  //     print("///////////Registration//////////////////");
  //     print("DioException occurred:");
  //     print("Status Code: ${e.response?.statusCode ?? 'Unknown'}");
  //     // print("Error Data: ${e.response?.data ?? 'No additional error data'}");
  //     print("Message: ${e.message}");
  //     emit(RegisterFailure(e.response!.data.toString()));
  //   } catch (e) {
  //     print("An unexpected error occurred: $e");
  //   }
  // }
  LoginModel ? model;
  ///Login
  Future<void> loginUser({
    required String email,
    required String pass,
  }) async {
    emit(LoginLoading());
    try {
      // إرسال طلب تسجيل الدخول
      final response = await dioService.postWithoutToken(
        "api/Auth/login",
        data: {
          'email': email,
          'password': pass,
        },
      );

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // معالجة بيانات تسجيل الدخول
        LoginModel model = LoginModel.fromJson(response.data);
        await CacheHelper.saveData(key: "accessToken", value: model.accessToken);
        await CacheHelper.saveData(key: "refreshTokenExpiration", value: model.refreshTokenExpiration);
        await CacheHelper.saveData(key: "UserName", value: model.displayName);
        await CacheHelper.saveData(key: "UserPhone", value: model.phoneNumber);
        await CacheHelper.saveData(key: "UserPhoto", value: model.image ?? "");
        await CacheHelper.saveData(key: "roles", value: model.roles[0] ?? "");
        print("توكن بعد تسجيل الدخول: ${model.accessToken}");

        print("Login successful://////////////");

        // استدعاء الـ API الثاني بعد تسجيل الدخول بنجاح
        await RegisterFcmToken();

        emit(LoginSuccess());
      } else {
        // إذا كانت حالة الاستجابة ليست 200
        emit(LoginFailure("Unexpected response status: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      print("/////Login Error////////////////////////");
      print("/////Login////////${e.response?.data}////////////////");
      print("////////Login/////////////////////");
      emit(LoginFailure(e.response?.data.toString() ?? "Unknown error occurred"));
    }
  }

  Future<void> RegisterFcmToken() async {
    try {
      emit(NotificationLoading());
      print(CacheHelper.getData(key: "FcmToken"));
      String token =  CacheHelper.getData(key: "FcmToken")??"";
     print(token);
      final response = await dioService.postWithToken(

        "api/Notifications/RegisterToken",

        data: {
          'token' :token

        },


      );
      if (response.statusCode == 200) {
        print("======Done=====");

      } else {
        print("Failed to fetch user data: ${response.statusCode}");
      }

      print("Mission successful: ${response.data}");
      emit(NotificationSuccess());
    } on DioException catch (e) {
      print("/////Mission Error////////${e.response!.data}////////////////");

      emit(LoginFailure(e.response!.data.toString()));
    }
  }
  // Future<void> RegisterFcmToken() async {
  //   try {
  //     emit(NotificationLoading());
  //
  //     final response = await dioService.postWithTokenFromManager(
  //
  //         "api/Notifications/RegisterToken",
  //         data: {
  //           "token" :   CacheHelper.getData(key: "FCMToken")
  //
  //         }
  //     );
  //     if (response.statusCode == 200) {
  //       print("User data fetched successfully: ${response.data}");
  //     } else {
  //       print("Failed to fetch user data: ${response.statusCode}");
  //     }
  //
  //     print("Mission successful: ${response.data}");
  //     emit(NotificationSuccess());
  //   } on DioException catch (e) {
  //     print("/////Mission Error////////${e.response!.data}////////////////");
  //
  //     emit(NotificationFailure(e.response!.data.toString()));
  //   }
  // }
  /////////////// changePassword //////////////////
  Future<void> changePassword({
    required String email,
    required String current,
    required String newPass,
  }) async {
    emit(ChangPassLoading());
    try {
      final response = await dioService.postWithToken(
          "api/Auth/changePassword", //    http://app774.uat.toq.sa/LacrosseApi/api/Auth/register
          data: {
            "email": email,
            "currentPassword": current,
            "newPassword": newPass
          }
        //    token: accessToken,

      );
      print("changePassword successful://////////////");
      print("changePassword successful: $response");
      emit(ChangPassSuccess());
    } on DioException catch (e) {
      print("/////changePassword////////////////////////");
      print("/////changePassword////////${e.response!.data}////////////////");
      print("////////changePassword/////////////////////");
      emit(LoginFailure(e.response!.data.toString()));
    }
  }
  // /////fetcOrdrs
  // Future<void> fetchOrders({
  //   required int userType,
  //
  // }) async {
  //   emit(LoginLoading());
  //   try {
  //     final response = await dioService.getWithToken(
  //       "api/Auth/gerAllUsersRequest",// http://app774.uat.toq.sa/LacrosseApi/api/Auth/gerAllUsersRequest?userType=1
  //       queryParameters: {
  //         'userType': userType,
  //
  //       },
  //       //    token: accessToken,
  //     );
  //
  //     List<dynamic> data = response.data;
  //     final List<OrderModel> orders =
  //     data.map((json) => OrderModel.fromJson(json)).toList();
  //     if(userType==0){
  //       emit(Fetch_PlayersOrderSuccess(orders));
  //     }else
  //       emit(Fetch_TrainerOrderSuccess(orders));
  //     print("fetchOrders successful: ${response.data}");
  //
  //   } on DioException catch (e) {
  //     print("/////fetchOrders////////////////////////");
  //     print("/////fetchOrders////////${e.response!.data}////////////////");
  //
  //     emit(FetchOrderFailure(e.response!.data.toString()));
  //   }
  // }
  /////Approve order
  // Future<void> approveOrder({
  //   required String email,
  //
  // }) async {
  //
  //   try {
  //     final response = await dioService.putWithToken(
  //       "api/Auth/approveUserRequest",// http://app774.uat.toq.sa/LacrosseApi/api/Auth/gerAllUsersRequest?userType=1
  //       queryParameters: {
  //         'email': email,
  //
  //       },
  //       //    token: accessToken,
  //     );
  //
  //     print("approveOrder successful: ${response.data}");
  //
  //   } on DioException catch (e) {
  //     print("/////approveOrder////////////////////////");
  //     print("/////approveOrder////////${e.response!.data}////////////////");
  //
  //     emit(FetchOrderFailure(e.response!.data.toString()));
  //   }
  // }
  /////regect order
//   Future<void> rejectOrder({
//     required String email,
//
//   }) async {
//
//     try {
//       final response = await dioService.deleteWithToken(
//         "api/Auth/rejectUserRequest",// http://app774.uat.toq.sa/LacrosseApi/api/Auth/gerAllUsersRequest?userType=1
//         queryParameters: {
//           'email': email,
//
//         },
//
//       );
//
//       print("rejectOrder successful: ${response.data}");
//
//     } on DioException catch (e) {
//       print("/////rejectOrder////////////////////////");
//       print("/////rejectOrder////////${e.response!.data}////////////////");
//
//       emit(RejectOrderFailure(e.response!.data.toString()));
//     }
//
//
//
//
// }
  ///////////////////////
  Future<void> fetchAllTeams() async {
    try {
      final response = await dioService.getWithoutToken(
        "api/Team/GetAllTeams",
      );
      List<dynamic> data = response.data;
      final List<TeamModel> teams =
      data.map((json) => TeamModel.fromJson(json)).toList();
      print("  team done ///////////////////");
      // print(response.data);

      emit(fetch_team_success(teams));
    } catch (e) {
      print(" none ///////////////////");
      // emit(NewsFailure(e.toString()));
    }
  }

  Future<void> fetchAllNationality() async {
    try {
      final response = await dioService.getWithoutToken(
        "api/Team/GetAllNationalities",
      );
      List<dynamic> data = response.data;
      final List<NationalityModel> nationlity =
      data.map((json) => NationalityModel.fromJson(json)).toList();
      // print(" Natinality done ///////////////////");
      // print(response.data);

      emit(fetch_Nationality_success(nationlity));
    } catch (e) {
      print("////// none ///////////////////");
      // emit(NewsFailure(e.toString()));
    }
  }

}
