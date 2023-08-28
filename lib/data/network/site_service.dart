import 'package:columnist/data/local/shared_preference.dart';
import 'package:columnist/data/models/sites/sites_model.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SiteService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeOut),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeOut),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeOut),
    ),
  );

  SiteService() {
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

  Future<UniversalData> getSites() async {
    Response response;
    try {
      response = await _dio.get("/sites");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(
          data: (response.data['data'] as List?)
                  ?.map((e) => SiteModel.fromJson(e))
                  .toList() ??
              [],
        );
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

  Future<UniversalData> createSite({required SiteModel siteModel}) async {
    Response response;
    _dio.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dio.post(
        '/sites',
        data: await siteModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return UniversalData(error: e.toString());
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getSiteById(int id) async {
    Response response;
    try {
      response = await _dio.get('/sites/$id');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: SiteModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return UniversalData(error: e.toString());
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
