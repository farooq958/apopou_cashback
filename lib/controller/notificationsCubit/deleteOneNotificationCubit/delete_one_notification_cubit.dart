import 'package:bloc/bloc.dart';
import 'package:cashback/controller/repository/notifications_repo.dart';
import 'package:equatable/equatable.dart';

part 'delete_one_notification_state.dart';

class DeleteOneNotificationCubit extends Cubit<DeleteOneNotificationsState> {
  final NotificationRepo notificationRepo;

  DeleteOneNotificationCubit({required this.notificationRepo})
      : super(DeleteOneNotificationsState.init());

  Future<bool> deleteNotification({int? id}) async {
    emit(state.copyWith(
        status: DeleteOneNotificationsStatus.loading, error: ""));

    try {
      var res = await notificationRepo.deleteOneNotification(id: id);
      emit(state.copyWith(
          status: DeleteOneNotificationsStatus.success, error: ""));
      return res;
    } catch (e) {
      emit(state.copyWith(
          status: DeleteOneNotificationsStatus.error, error: e.toString()));
      return false;
    }
  }
}
