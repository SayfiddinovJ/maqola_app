import 'dart:io';

import 'package:columnist/data/local/shared_preference.dart';
import 'package:columnist/data/models/articles/article_model.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ArticleService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeOut),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeOut),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeOut),
    ),
  );

  ArticleService() {
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

  Future<UniversalData> getAllArticles() async {
    Response response;
    try {
      response = await _dio.get("/articles");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(
          data: (response.data['data'] as List?)
                  ?.map((e) => ArticleModel.fromJson(e))
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

  Future<UniversalData> getArticleById(int id) async {
    Response response;
    try {
      response = await _dio.get("/articles/$id");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UniversalData(
            data: ArticleModel.fromJson(response.data['data']));
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

  Future<UniversalData> createArticle(
      {required ArticleModel articleModel}) async {
    Response response;
    _dio.options.headers = {
      "Accept": "application/form-data",
    };
    try {
      response = await _dio.post(
        '/articles',
        data: articleModel.toJson(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on SocketException catch (e) {
      return UniversalData(error: e.toString());
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
