import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/services/firebase_messaging_service.dart';
import 'package:tien_duong/app/data/repository/request_model/login_model.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  String userName = '';
  String password = '';
  final RxBool isSignupMode = false.obs;
  final RxDouble widthForgotPassword = 0.0.obs;
  set isSignupModeValue(bool value) => isSignupMode.value = value;

  set setUserName(String value) {
    userName = value;
  }

  set setPassword(String value) {
    password = value;
  }

  void back() {
    Get.back();
  }

  Future<void> gotoSignUp() async {
    await Get.offAndToNamed(Routes.REGISTER);
  }

  Future<void> login() async {
    isLoading = true;
    LoginModel loginModel = LoginModel(
      userName: userName,
      password: password,
      registrationToken: await FirebaseMessagingService.getToken(),
    );
    await AuthController.login(loginModel);
    isLoading = false;
  }
}