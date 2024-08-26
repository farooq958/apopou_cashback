import 'package:bloc/bloc.dart';
import 'package:cashback/controller/premiumControllers/Services/all_coupon_services.dart';
import 'package:cashback/controller/premiumControllers/Services/premium_controllers.dart';
import 'package:meta/meta.dart';



class AddToFavouritePremiumCubit extends Cubit<String> {
  AddToFavouritePremiumCubit() : super("");

  addPremiumCoupon(couponId)
  async {
    emit("loading");
    var temp= await ServicesAllCoupons().addPremiumCouponData(couponId);
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
