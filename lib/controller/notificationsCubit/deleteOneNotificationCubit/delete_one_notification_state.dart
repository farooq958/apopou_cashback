part of 'delete_one_notification_cubit.dart';

enum DeleteOneNotificationsStatus { initial, loading, success, error }

class DeleteOneNotificationsState extends Equatable {
  final DeleteOneNotificationsStatus status;
  final String error;
  DeleteOneNotificationsState({
    required this.status,
    required this.error,
  });

  factory DeleteOneNotificationsState.init() {
    return DeleteOneNotificationsState(
        status: DeleteOneNotificationsStatus.initial, error: "");
  }

  DeleteOneNotificationsState copyWith({
    DeleteOneNotificationsStatus? status,
    String? error,
  }) {
    return DeleteOneNotificationsState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'NotificationsState(status: $status, error: $error)';

  @override
  List<Object> get props => [status, error];
}
