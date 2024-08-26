import 'package:bloc/bloc.dart';
import 'package:cashback/controller/services/edit_profile.dart';
import 'package:equatable/equatable.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileService profileService;
  EditProfileCubit({
    required this.profileService,
  }) : super(EditProfileState.initial());

  Future<bool> editProfile(
    int id,
    String email,
    String fname,
    // String lname,
    // var country,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    try {
      var res = await profileService.updateProfile(
        id, email, fname,
        // country
      );
      emit(state.copyWith(status: EditProfileStatus.success));
      return res;
    } catch (e) {
      emit(state.copyWith(status: EditProfileStatus.error));
      return false;
    }
  }
}
