import 'package:bloc/bloc.dart';
import 'package:cashback/controller/premiumControllers/Services/all_coupon_services.dart';
import 'package:cashback/controller/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'all_coupon_premium_state.dart';

class AllCouponPremiumCubit extends Cubit<AllCouponPremiumState> {
  AllCouponPremiumCubit() : super(AllCouponPremiumInitial());
  loadPremiumMainData(int pageNo,id,check,isGuest,check2)
  async {
    // if(check2=="fromnottap") {
    //   emit(AllCouponPremiumLoading());
    // }
    if(isGuest==false)
      {
        try{
    ServicesAllCoupons.favouriteCoupons.clear();
   var dto = await  ServicesAllCoupons().getAllFavouriteCoupons();
if( dto.runtimeType != int)
  {

    ServicesAllCoupons.favouriteCoupons = await  ServicesAllCoupons().getAllFavouriteCoupons();
  }
        }
      catch(e)
    {
      print("in exception right");
      emit(AllCouponPremiumUnknownError());

    }
      }
    var temp= await ServicesAllCoupons().loadAllPremiumCouponData(pageNo,id,check);
    if(temp==200) {

      emit(AllCouponPremiumLoaded());
      return 200;
    }
    else if(temp==10)
    {
      emit(AllCouponPremiumInternetError());
return 10;
    }
    else
    {
      emit(AllCouponPremiumUnknownError());
return 0;
    }

  }

}
