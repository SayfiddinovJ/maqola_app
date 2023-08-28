import 'package:columnist/data/local/shared_preference.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:columnist/data/network/auth_service.dart';

class AuthRepository {
  final AuthService apiService;

  AuthRepository({required this.apiService});

  Future<UniversalData> verifyViaGmail(
          {required String gmail, required String password}) async =>
      await apiService.verifyViaGmail(gmail: gmail, password: password);

  Future<UniversalData> checkTheCode({required String code}) async =>
      await apiService.checkTheCode(code: code);

  Future<UniversalData> register({required UserModel userModel}) async =>
      await apiService.register(userModel: userModel);

  Future<UniversalData> login(
          {required String gmail, required String password}) async =>
      await apiService.login(gmail: gmail, password: password);

  String getToken() => StorageRepository.getString("token");

  Future<bool?> deleteToken() async => StorageRepository.deleteString("token");

  Future<void> setToken(String newToken) async =>
      StorageRepository.putString("token", newToken);
}
