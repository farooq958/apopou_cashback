part of 'notification_cubit.dart';

enum NotificationsStatus { initial, loading, success, error }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final NotificationModel list;
  final String error;
  NotificationsState({
    required this.status,
    required this.list,
    required this.error,
  });

  factory NotificationsState.init() {
    return NotificationsState(
        status: NotificationsStatus.initial,
        list: NotificationModel(),
        error: "");
  }

  NotificationsState copyWith({
    NotificationsStatus? status,
    NotificationModel? list,
    String? error,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      list: list ?? this.list,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'NotificationsState(status: $status, list: $list, error: $error)';

  @override
  List<Object> get props => [status, list, error];
}
