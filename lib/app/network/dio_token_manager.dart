import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';

import '../routes/app_pages.dart';

class TokenManager extends Interceptor {
  final AuthController _authController = Get.find<AuthController>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = _authController.token;
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var response = err.response;
    if (response?.statusCode == 401) {
      _authController.clearToken();
      Get.offAllNamed(Routes.LOGIN);
    }
    super.onError(err, handler);
  }
}
