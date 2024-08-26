// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_referrals_cubit.dart';

enum MyReferralStatus {
  initial,
  loading,
  success,
  error,
}

class MyReferralsState extends Equatable {
  final MyReferralStatus status;
  final UserReferralModel model;
  MyReferralsState({
    required this.status,
    required this.model,
  });
  factory MyReferralsState.initial() {
    return MyReferralsState(
      status: MyReferralStatus.initial,
      model: UserReferralModel(),
    );
  }

  @override
  List<Object?> get props => [status, model];

  MyReferralsState copyWith({
    MyReferralStatus? status,
    UserReferralModel? model,
  }) {
    return MyReferralsState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
