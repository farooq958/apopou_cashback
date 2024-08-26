import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cashback/controller/VivaWallet/services/walletControllers.dart';
import 'package:cashback/controller/VivaWallet/services/wallet_services.dart';
import 'package:cashback/model/WalletModel/wallet_url_model.dart';
import 'package:meta/meta.dart';

part 'wallet_url_state.dart';

class WalletUrlCubit extends Cubit<WalletUrlState> {
  WalletUrlCubit() : super(WalletUrlInitial());

  getWalletUrl()
  async {
    // if(check2=="fromnottap") {
    //   emit(AllCouponPremiumLoading());
    // }
     Future.delayed(Duration(milliseconds: 16));
emit(WalletUrlLoading());
    var temp= await WalletServices().loadUrlForWeb();
    print(temp);
    if(temp==200) {
log("datafrom${walletUrlController.data}");
      emit(WalletUrlLoaded(walletUrlController:walletUrlController));
      return 200;
    }
    else if(temp==10)
    {
      emit(WalletUrlInternetError());
      return 10;
    }
    else
    {
      emit(WalletUrlUnknownError());
      return 0;
    }

  }
}
