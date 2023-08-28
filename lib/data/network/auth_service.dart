import 'package:columnist/data/local/shared_preference.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeOut),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeOut),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeOut),
    ),
  );

  AuthService() {
    init();
  }

  init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          debugPrint('On Error: ${error.message}');
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint('On Request: ${requestOptions.data}');
          requestOptions.headers
              .addAll({"token": StorageRepository.getString("token")});
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint('On Response: ${response.data}');
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalData> verifyViaGmail(
      {required String gmail, required String password}) async {
    Response response;
    try {
      response = await _dio
          .post("/gmail", data: {"gmail": gmail, "password": password});
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(data: response.data['message']);
      }
      return UniversalData(error: 'ERROR');
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data['message']);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (e) {
      debugPrint("Caught: $e");
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> checkTheCode({required String code}) async {
    Response response;
    try {
      response = await _dio.post("/password", data: {
        "checkPass": code,
      });
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(data: response.data['message']);
      }
      return UniversalData(error: 'ERROR');
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data['message']);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (e) {
      debugPrint("Caught: $e");
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> register({required UserModel userModel}) async {
    debugPrint('register');
    Response response;
    _dio.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response =
          await _dio.post("/register", data: await userModel.getFormData());
      debugPrint('Register response ${response.data}');
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        debugPrint('Register Response 200: ${response.data}');
        return UniversalData(data: response.data['data']);
      }
      return UniversalData(error: 'ERROR');
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data['message']);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (e) {
      debugPrint("Caught: $e");
      return UniversalData(error: e.toString());
    }
  }

  Future<UniversalData> login(
      {required String gmail, required String password}) async {
    Response response;
    try {
      response = await _dio
          .post("/login", data: {"gmail": gmail, "password": password});
      debugPrint('Register Response: ${response.data}');
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        debugPrint('Login Response 200: ${response.data}');
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: 'ERROR');
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data['message']);

      } else {
        return UniversalData(error: e.message!);
      }
    } catch (e) {
      debugPrint("Caught: $e");
      return UniversalData(error: e.toString());
    }
  }
}
