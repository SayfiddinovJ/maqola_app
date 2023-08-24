import 'package:columnist/cubits/auth/auth_state.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:columnist/data/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitialState());
  final AuthRepository authRepository;

  Future<void> checkLoginState() async {
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('TOKEN: ${authRepository.getToken()}');
    if (authRepository.getToken().isEmpty) {
      emit(UnAuthenticatedState());
    } else {
      emit(AuthLoggedState());
    }
  }

  Future<void> verifyViaGmail(String gmail, String password) async {
    emit(AuthLoadingState());

    UniversalData universalData =
        await authRepository.verifyViaGmail(gmail: gmail, password: password);

    if (universalData.error.isEmpty) {
      emit(AuthVerifySuccessState());
    } else {
      emit(AuthErrorState(error: universalData.error));
    }
  }

  Future<void> checkTheIncomingCode(String code) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.checkTheCode(code: code);

    if (universalData.error.isEmpty) {
      emit(AuthVerifySuccessState());
    } else {
      emit(AuthErrorState(error: universalData.error));
    }
  }

  Future<void> registerUser(UserModel userModel) async {
    emit(AuthLoadingState());
    UniversalData universalData =
        await authRepository.register(userModel: userModel);
    if (universalData.error.isEmpty) {
      debugPrint("TOKEN ${universalData.data}");
      await authRepository.setToken(universalData.data as String);
      emit(AuthLoggedState());
    } else {
      emit(AuthErrorState(error: universalData.error));
    }
  }

  Future<void> login({
    required String gmail,
    required String password,
  }) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.login(
      gmail: gmail,
      password: password,
    );
    if (universalData.error.isEmpty) {
      debugPrint("TOKEN ${universalData.data}");
      await authRepository.setToken(universalData.data as String);
      emit(AuthLoggedState());
    } else {
      emit(AuthErrorState(error: universalData.error));
    }
  }

  Future<void> logOut() async {
    emit(AuthLoadingState());
    debugPrint('TOKEN DELETED: ${authRepository.getToken()}');
    bool? isDeleted = await authRepository.deleteToken();
    if (isDeleted != null) {
      emit(UnAuthenticatedState());
    }
  }
}
