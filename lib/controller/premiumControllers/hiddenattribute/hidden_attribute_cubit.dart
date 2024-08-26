import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cashback/controller/premiumControllers/Services/all_coupon_services.dart';
import 'package:cashback/model/premium/all_coupon_model.dart';
import 'package:cashback/model/premium/all_coupon_model.dart';
import 'package:meta/meta.dart';

part 'hidden_attribute_state.dart';

class HiddenAttributeCubit extends Cubit<HiddenAttributeState> {
  HiddenAttributeCubit() : super(HiddenAttributeInitial());

getHiddenAttributes(couponId) async
{
  emit(HiddenAttributeLoading());
  var dto= await ServicesAllCoupons().getHiddenAttribute(couponId);
  log('hd $dto');
  if(dto.runtimeType != int)
  {
    HiddenAttrModel data=dto;
log('hd $dto');
      emit(HiddenAttributeLoaded(data: data));


  }
  else {
    emit(HiddenAttributeError());
  }



}

}
