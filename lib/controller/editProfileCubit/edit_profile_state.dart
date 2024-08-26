// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_profile_cubit.dart';

enum EditProfileStatus {
  initial,
  loading,
  success,
  error,
}

class EditProfileState extends Equatable {
  final EditProfileStatus status;
  EditProfileState({
    required this.status,
  });

  factory EditProfileState.initial() {
    return EditProfileState(status: EditProfileStatus.initial);
  }

  @override
  List<Object?> get props => [status];

  EditProfileState copyWith({
    EditProfileStatus? status,
  }) {
    return EditProfileState(
      status: status ?? this.status,
    );
  }
}
