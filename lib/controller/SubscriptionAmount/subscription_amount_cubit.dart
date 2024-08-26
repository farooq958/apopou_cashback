import 'package:bloc/bloc.dart';
import 'package:cashback/controller/SubscriptionAmount/services/amountServices.dart';
import 'package:meta/meta.dart';

part 'subscription_amount_state.dart';

class SubscriptionAmountCubit extends Cubit<SubscriptionAmountState> {
  SubscriptionAmountCubit() : super(SubscriptionAmountInitial());

  getSubscriptionAmountData()
  async {
    // if(check2=="fromnottap") {
    //   emit(AllCouponPremiumLoading());
    // }

    var temp= await SubscriptionAmountServices().loadSubscriptionAmount();
    if(temp==200) {

      emit(SubscriptionAmountLoaded());
      return 200;
    }
    else if(temp==10)
    {
      emit(SubscriptionAmountInternetError());
      return 10;
    }
    else
    {
      emit(SubscriptionAmountUnknownError());
      return 0;
    }

  }
}
