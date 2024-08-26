import 'package:bloc/bloc.dart';
import 'package:cashback/controller/services/premiun_service_api.dart';
import 'package:cashback/model/premium/premium_user_model.dart';
import 'package:meta/meta.dart';

part 'premium_user_state.dart';

class PremiumUserCubit extends Cubit<PremiumUserState> {
  PremiumUserCubit() : super(PremiumUserInitial());

  getPremiumUserData()async
  {
    await Future.delayed(Duration.zero);
    emit(PremiumUserLoading());
    try{
      var dto = await PremiumCheck.getPremiumUserData();

if(dto != null)
  {
    emit(PremiumUserSuccess(premiumData: dto));
  }
else
  {
    emit(PremiumUserError());
  }



    }
        catch(e)
    {

      emit(PremiumUserError());

    }



  }

}
