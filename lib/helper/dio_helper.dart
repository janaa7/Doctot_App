import 'package:dio/dio.dart';
import 'package:doctor/core/const/ai_const.dart';
import 'cash_helper.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: APIConst.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    final token = CacheHelper.getToken();

    return await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    final token = CacheHelper.getToken();

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }
}