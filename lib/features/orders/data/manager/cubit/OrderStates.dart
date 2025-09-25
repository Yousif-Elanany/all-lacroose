
import '../../model/ordelModel.dart';

abstract class OrderStates {}

final class Order_initial extends OrderStates {}


///////////// Order /////////////
class Fetch_OrderLoading extends OrderStates {}

class Fetch_PlayersOrderSuccess extends OrderStates {
  final List<OrderModel> playerOrderData;


  Fetch_PlayersOrderSuccess( this.playerOrderData);

}
class Fetch_TrainerOrderSuccess extends OrderStates {
  final List<OrderModel> trainerOrderData;


  Fetch_TrainerOrderSuccess( this.trainerOrderData);

}
class FetchOrderFailure extends OrderStates {
  final String errorMessage;

  FetchOrderFailure(this.errorMessage);
}
///////////// ApproveOrder /////////////
class ApproveOrderSuccess extends OrderStates {


}
class ApproveOrderLoading extends OrderStates {


}
class ApproveOrderFailure extends OrderStates {
  final String errorMessage;

  ApproveOrderFailure(this.errorMessage);
}
///////////// RejectOrderOrder /////////////
class  RejectOrderLoading extends OrderStates {


}
class RejectOrderSuccess extends OrderStates {

}
class RejectOrderFailure extends OrderStates {
  final String errorMessage;

  RejectOrderFailure(this.errorMessage);
}
///////////// teams /////////////