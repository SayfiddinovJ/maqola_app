import 'package:columnist/cubits/profile/profile_state.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:columnist/data/repositories/profile_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepository}) : super(ProfileInitial()){
    getUser();
  }

  final ProfileRepository profileRepository;

  getUser() async {
    emit(ProfileLoadingState());
    UniversalData response = await profileRepository.getUser();
    debugPrint('Cubit: ${response.data}');
    if (response.error.isEmpty) {
      emit(ProfileSuccessState(userModel: response.data as UserModel));
    } else {
      emit(ProfileErrorState(error: response.error));
    }
  }
}
