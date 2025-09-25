

import '../../model/notificationModel.dart';

abstract class NotififcationsStates {}

final class notification_initial extends NotififcationsStates {}


///////////// notificationsTokenStates /////////////
class NotificationLoading extends NotififcationsStates {}

class NotificationSuccess extends NotififcationsStates {}

class NotificationFailure extends NotififcationsStates {
  final String errorMessage;

  NotificationFailure(this.errorMessage);
}
//////get all notification ///////
class GetAllNotificationLoading extends NotififcationsStates {}


class GetAllNotificationSuccess extends NotififcationsStates {
  final List<NotificationModel> notificationslist;

  GetAllNotificationSuccess(this.notificationslist);
}

class GetAllNotificationFailure extends NotififcationsStates {
  final String errorMessage;

  GetAllNotificationFailure(this.errorMessage);
}