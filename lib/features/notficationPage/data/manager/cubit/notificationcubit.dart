

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../../data/Local/sharedPref/sharedPref.dart';
import '../../../../../data/remote/dio.dart';
import '../../model/notificationModel.dart';
import 'notificationStates.dart';

class NotififcationsCubit extends Cubit<NotififcationsStates> {
  final DioService dioService;

  NotififcationsCubit(this.dioService) : super(notification_initial());



  Future<void> RegisterFcmToken({
    required String email,

  }) async {
    try {
      emit(NotificationLoading());

      final response = await dioService.postWithTokenFromManager(

        "api/Notifications/RegisterToken",
        data: {
          "token" :   CacheHelper.getData(key: "FCMToken")

      }
      );

      print("rejectOrder successful: ${response.data}");
      emit(NotificationSuccess());
    } on DioException catch (e) {
      print("/////rejectOrder////////////////////////");
      print("/////rejectOrder////////${e.response!.data}////////////////");

      emit(NotificationFailure(e.response!.data.toString()));
    }
  }

  /////get all notifications
  Future<void> GetUserNotificationsWithUnReadCount(


  ) async {
    emit(GetAllNotificationLoading());
    try {
      final response = await dioService.getWithToken(
        "api/Notifications/GetUserNotificationsWithUnReadCount",


        //    token: accessToken,
      );
    //  print(response.data);

       List<dynamic> data = response.data["notifications"];
      final List<NotificationModel> notificationslist =
      data.map((json) => NotificationModel.fromJson(json)).toList();
      // if (userType == 0) {
      //   emit(Fetch_PlayersOrderSuccess(orders));
      // } else
         emit(GetAllNotificationSuccess(notificationslist));
      print("fetch notification successful:////////////////////");
       print("fetch notification successful: ${response.data["notifications"]}");
    } on DioException catch (e) {
      print("/////notification////////////////////////");
      print("/////notification////////${e.response!.data}////////////////");

      emit(GetAllNotificationFailure(e.response!.data.toString()));
    }
  }
  /////mark notifications as read by id
  Future<void> MarkNotificationAsReadByID({
    required int notificationId,

  }) async {
    emit(GetAllNotificationLoading());
    try {
      final response = await dioService.postWithToken(
        "api/Notifications/MarkNotificationAsRead",

        queryParameters: {
          'notificationId': notificationId,

        },
        //    token: accessToken,
      );
      print(response.data);

      // List<dynamic> data = response.data;
      // final List<OrderModel> orders =
      // data.map((json) => OrderModel.fromJson(json)).toList();
      // if (userType == 0) {
      //   emit(Fetch_PlayersOrderSuccess(orders));
      // } else
      //   emit(Fetch_TrainerOrderSuccess(orders));
      print("////////ttttttttt");
      print("MarkNotificationAsReadByID notification successful: ${response.data}");
    } on DioException catch (e) {
      print("/////MarkNotificationAsReadByID////////////////////////");
      print("/////MarkNotificationAsReadByID////////${e.response!.data}////////////////");

      emit(GetAllNotificationFailure(e.response!.data.toString()));
    }
  }

  /////mark markAllNotificationsAsReadAsync a ////////
  Future<void> markAllNotificationsAsReadAsync()
  async {
   // emit(GetAllNotificationLoading());
    try {
      final response = await dioService.postWithToken(
        "api/Notifications/markAllNotificationsAsReadAsync",


      );
      print(response.data);


      print("markAllNotificationsAsReadAsync  successful: ${response.data}");
    } on DioException catch (e) {
      print("/////markAllNotificationsAsReadAsync////////////////////////");
      print("/////markAllNotificationsAsReadAsync////////${e.response!.data}////////////////");

      emit(GetAllNotificationFailure(e.response!.data.toString()));
    }
  }
}