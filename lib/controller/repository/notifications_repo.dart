import 'package:cashback/controller/services/notification_services.dart';
import 'package:cashback/model/notifications/notification.dart';

class NotificationRepo {
  final NotificationServices notificationServices;
  NotificationRepo({
    required this.notificationServices,
  });

  Future<NotificationModel> getNotifications(String pageNumber) async {
    try {
      var res = await notificationServices.getNotifications(pageNumber);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteOneNotification({int? id}) async {
    try {
      var res = await notificationServices.deleteOneNotification(id: id);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
