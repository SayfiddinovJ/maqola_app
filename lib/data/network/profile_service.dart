import 'package:columnist/data/local/shared_preference.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/models/user/user_model.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ProfileService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeOut),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeOut),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeOut),
    ),
  );

  ProfileService() {
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
          debugPrint('On Response: ${response.statusCode}');
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalData> getUser() async {
    Response response;
    try {
      response = await _dio.get("/users");
      debugPrint('Service ${response.data}');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(data: UserModel.fromJson(response.data['data']));
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
