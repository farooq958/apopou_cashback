part of 'wallet_url_cubit.dart';

@immutable
abstract class WalletUrlState {}

class WalletUrlInitial extends WalletUrlState {}
class WalletUrlLoading extends WalletUrlState {}
class WalletUrlLoaded extends WalletUrlState {



 final WalletUrl walletUrlController;

 WalletUrlLoaded({required this.walletUrlController});

}
class WalletUrlInternetError extends WalletUrlState {}
class WalletUrlUnknownError extends WalletUrlState {}
