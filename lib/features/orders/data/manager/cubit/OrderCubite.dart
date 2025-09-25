

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lacrosse/features/orders/data/manager/cubit/OrderStates.dart';

import '../../../../../data/remote/dio.dart';
import '../../model/ordelModel.dart';

class OrderCubit extends Cubit<OrderStates> {
  final DioService dioService;

  OrderCubit(this.dioService) : super(Order_initial());


/////fetcOrdrs
  Future<void> fetchOrders({
    required int userType,

  }) async {
    emit(Fetch_OrderLoading());
    try {
      final response = await dioService.getWithToken(
        "api/Auth/gerAllUsersRequest",
        // http://app774.uat.toq.sa/LacrosseApi/api/Auth/gerAllUsersRequest?userType=1
        queryParameters: {
          'userType': userType,

        },
        //    token: accessToken,
      );
      print(response.data);

      List<dynamic> data = response.data;
      final List<OrderModel> orders =
      data.map((json) => OrderModel.fromJson(json)).toList();
      if (userType == 0) {
        emit(Fetch_PlayersOrderSuccess(orders));
      } else
        emit(Fetch_TrainerOrderSuccess(orders));
      print("fetchOrders successful: ${response.data}");
    } on DioException catch (e) {
      print("/////fetchOrders////////////////////////");
      print("/////fetchOrders////////${e.response!.data}////////////////");

      emit(FetchOrderFailure(e.response!.data.toString()));
    }
  }

/////Approve order
  Future<void> approveOrder({
    required String email,

  }) async {
    emit(ApproveOrderLoading());
    try {
      final response = await dioService.putWithToken(
        "api/Auth/approveUserRequest",
        // http://app774.uat.toq.sa/LacrosseApi/api/Auth/gerAllUsersRequest?userType=1
        queryParameters: {
          'email': email,

        },
        //    token: accessToken,
      );

      print("approveOrder successful: ${response.data}");
    } on DioException catch (e) {
      print("/////approveOrder////////////////////////");
      print("/////approveOrder////////${e.response!.data}////////////////");

      emit(FetchOrderFailure(e.response!.data.toString()));
    }
  }

/////regect order
  Future<void> rejectOrder({
    required String email,

  }) async {
    emit(RejectOrderLoading());
    try {
      final response = await dioService.deleteWithToken(
        "api/Auth/rejectUserRequest",
        // http://app774.uat.toq.sa/LacrosseApi/api/Auth/gerAllUsersRequest?userType=1
        queryParameters: {
          'email': email,

        },

      );

      print("rejectOrder successful: ${response.data}");
    } on DioException catch (e) {
      print("/////rejectOrder////////////////////////");
      print("/////rejectOrder////////${e.response!.data}////////////////");

      emit(RejectOrderFailure(e.response!.data.toString()));
    }
  }
}