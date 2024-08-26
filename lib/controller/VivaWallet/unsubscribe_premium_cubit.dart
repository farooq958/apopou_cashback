import 'package:bloc/bloc.dart';
import 'package:cashback/controller/VivaWallet/services/wallet_services.dart';
import 'package:cashback/model/WalletModel/unsubsribe_premium_model.dart';
import 'package:meta/meta.dart';

part 'unsubscribe_premium_state.dart';

class UnsubscribePremiumCubit extends Cubit<UnsubscribePremiumState> {
  UnsubscribePremiumCubit() : super(UnsubscribePremiumInitial());

unSubscribeFromPremium()
async {
  await Future.delayed( const Duration(milliseconds: 17));
  emit(UnsubscribePremiumLoading());
 var dto= await WalletServices().unSubscribePremium();
  if(dto.runtimeType != int)
    {
      UnsubscribeModel data=dto;
      print(data.message);
      if(data.message=="Un Subscribed Successfully."){
      emit(UnsubscribePremiumLoaded(data: data));

      }
    }
  else {
    emit(UnsubscribePremiumError());
  }

}

}
