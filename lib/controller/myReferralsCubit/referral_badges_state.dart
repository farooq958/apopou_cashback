// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'referral_badges_cubit.dart';

enum ReferralBadgesStatus {
  initial,
  loading,
  success,
  error,
}

class ReferralBadgesState extends Equatable {
  final ReferralBadgesStatus status;
  final UserReferralBadgesModel model;
  ReferralBadgesState({
    required this.status,
    required this.model,
  });

  factory ReferralBadgesState.initial() {
    return ReferralBadgesState(
      status: ReferralBadgesStatus.initial,
      model: UserReferralBadgesModel(),
    );
  }

  @override
  List<Object?> get props => [status, model];

  ReferralBadgesState copyWith({
    ReferralBadgesStatus? status,
    UserReferralBadgesModel? model,
  }) {
    return ReferralBadgesState(
      status: status ?? this.status,
      model: model ?? this.model,
    );
  }
}
