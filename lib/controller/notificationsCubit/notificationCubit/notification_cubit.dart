import 'package:bloc/bloc.dart';
import 'package:cashback/controller/repository/notifications_repo.dart';
import 'package:cashback/model/notifications/notification.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationsState> {
  final NotificationRepo notificationRepo;

  NotificationCubit({required this.notificationRepo})
      : super(NotificationsState.init());

  var currentPage;

  Future<NotificationModel> getNotifications(String pageNumber) async {
    if (pageNumber == "1") {
      emit(state.copyWith(
          status: NotificationsStatus.loading,
          list: NotificationModel(
              data: [],
              meta: NotificationMetaModel(
                  pagination: NotificationPaginationModel())),
          error: ""));
    }
    try {
      var res = await notificationRepo.getNotifications(pageNumber);
      currentPage = res.meta!.pagination!.currentPage!;
      emit(state.copyWith(
          status: NotificationsStatus.success, list: res, error: ""));
      return res;
    } catch (e) {
      emit(state.copyWith(
          status: NotificationsStatus.error,
          list: NotificationModel(
              data: [],
              meta: NotificationMetaModel(
                  pagination: NotificationPaginationModel())),
          error: e.toString()));
      return NotificationModel(
          data: [],
          meta:
              NotificationMetaModel(pagination: NotificationPaginationModel()));
    }
  }
}
