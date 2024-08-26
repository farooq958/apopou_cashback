// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'de_activate_cubit.dart';

enum DeactivateStatus {
  initial,
  loading,
  success,
  error,
}

class DeActivateState extends Equatable {
  final DeactivateStatus status;
  DeActivateState({
    required this.status,
  });

  factory DeActivateState.initial() {
    return DeActivateState(status: DeactivateStatus.initial);
  }
  @override
  List<Object?> get props => [status];

  DeActivateState copyWith({
    DeactivateStatus? status,
  }) {
    return DeActivateState(
      status: status ?? this.status,
    );
  }
}
