import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000, // 20 seconds
        receiveTimeout: 20 * 1000, // 20 seconds
        headers: {
          'content_type': 'application/json',
        }));
  }

  static Future<Response> getRequest(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    return await dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> postRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? data,
  }) async {
    return await dio.post(path, queryParameters: queryParameters, data: data);
  }

  static Future<Response> putRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? data,
  }) async {
    return await dio.put(path, queryParameters: queryParameters, data: data);
  }

  static Future<Response> patchRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? data,
  }) async {
    return await dio.patch(path, queryParameters: queryParameters, data: data);
  }

  static Future<Response> deleteRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.delete(path, queryParameters: queryParameters, data: {});
  }
}
