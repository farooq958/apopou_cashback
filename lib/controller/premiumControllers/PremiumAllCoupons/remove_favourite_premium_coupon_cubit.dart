import 'package:bloc/bloc.dart';
import 'package:cashback/controller/premiumControllers/Services/all_coupon_services.dart';
import 'package:meta/meta.dart';



class RemoveFavouritePremiumCouponCubit extends Cubit<String> {
  RemoveFavouritePremiumCouponCubit() : super('');

  removePremiumCoupon(couponId)
  async {
    emit("loading");
    var temp= await ServicesAllCoupons().removePremiumCouponData(couponId);
    if(temp==200) {

      emit("success");
      //return 200;
    }
    else if(temp==10)
    {
      emit("internetError");
      //return 10;
    }
    else
    {
      emit("unknownError");
      //return 0;
    }

  }
}
