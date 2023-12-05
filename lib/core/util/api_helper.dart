import 'package:dio/dio.dart';
import 'package:ecommerce_test/config/base_url_config.dart';
import 'package:ecommerce_test/core/util/storage_helper.dart';
import 'package:ecommerce_test/dependency_injection.dart';

class ApiBaseHelper {
  static BaseOptions opts = BaseOptions(
    baseUrl: BaseUrlConfig.baseUrlDevelopment,
    connectTimeout: Duration(seconds: 50000),
    receiveTimeout: Duration(seconds: 50000),
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          String? token =
              await sl<LocalStorageService>().getStringFromDisk('token');

          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        }, onError: (DioError e, ErrorInterceptorHandler handler) async {
          return handler.next(e);
        }),
      );
  }

//
  static final dio = createDio();

  static final baseAPI = addInterceptors(dio);

  Future<Response?> get(String url) async {
    Response? response;

    response = await baseAPI.get(url);
    return response;
  }

  Future<Response?> post(String url, dynamic data,
      {Function(int count, int total)? onSendProgress}) async {
    Response? response;
    print('11111   $url and $data');
    response =
        await baseAPI.post(url, data: data, onSendProgress: ((count, total) {
      if (onSendProgress != null) {
        onSendProgress(count, total);
      }
    }));
    return response;
  }

  Future<Response?> put(String url, dynamic data) async {
    // try {
    Response? response = await dio.put(url, data: data);
    return response;
    // } on DioError catch (e) {
    //   print("put HTTP error happen check");
    //   print(e.message);
    // }
  }

  Future<Response?> patch(String url, dynamic data) async {
    Response? response = await dio.patch(url, data: data);
    return response;
  }

  Future<Response?> delete(String url) async {
    //  try {
    Response? response = await dio.delete(url);
    print(response);
    return response;
    // } on DioError catch (e) {
    //   print(e.response);
    //   return e.response;
    //}
  }
}
