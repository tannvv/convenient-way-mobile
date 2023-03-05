import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/services/firebase_messaging_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/widgets/custom_overlay.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/login_model.dart';
import 'package:tien_duong/app/modules/register/models/args_register_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';
import 'package:loader_overlay/loader_overlay.dart';

class VerifyOtpController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();
  ArgsRegisterModel argsRegister = Get.arguments as ArgsRegisterModel;
  final RxBool isLoadingResend = false.obs;

  String _otpField = '';
  String _verificationId = '';
  String _phone = '';
  int? _resendToken;
  set setOtpField(String value) {
    _otpField = value;
  }

  String get phone => _phone;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());

  @override
  void onInit() {
    _verificationId = argsRegister.verificationId;
    _resendToken = argsRegister.resendToken;
    _phone = argsRegister.createAccountModel.phone!;
    super.onInit();
  }

  Future<void> verifyOTP(String value) async {
    Get.context?.loaderOverlay.show(
        widget: const CustomOverlay(
      content: 'Đang xác thực',
    ));
    await FirebaseAuth.instance
        .signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: value,
      ),
    )
        .then((value) async {
      await FirebaseAuth.instance.signOut();
      await createAccount();
    }).catchError((error) {
      ToastService.showError('OTP không đúng');
    }).whenComplete(() => Get.context?.loaderOverlay.hide());
  }

  Future<void> createAccount() async {
    var future = _accountRepo.create(argsRegister.createAccountModel);
    await callDataService(future, onSuccess: (data) {
      ToastService.showSuccess('Đăng ký thành công');
      login();
    }, onError: (ex) {
      if (ex is BaseException) {
        ToastService.showError(ex.message);
      } else {
        ToastService.showError('Tạo tài khoản thất bại');
      }
    });
  }

  Future<void> login() async {
    LoginModel loginModel = LoginModel(
      userName: argsRegister.createAccountModel.userName,
      password: argsRegister.createAccountModel.password,
      registrationToken: await FirebaseMessagingService.getToken(),
    );
    await _authController.login(loginModel,
        onStart: () => Get.context?.loaderOverlay.show(
                widget: const CustomOverlay(
              content: 'Đang đăng nhập...',
            )),
        onComplete: () => Get.context?.loaderOverlay.hide());
  }

  Future<bool> resendOTP() async {
    isLoadingResend.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        isLoadingResend.value = false;
      },
      verificationFailed: (FirebaseAuthException e) {
        ToastService.showError("Gửi lại OTP bị lỗi!");
        isLoadingResend.value = false;
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
        isLoadingResend.value = false;
        ToastService.showSuccess('Đã gửi lại OTP');
      },
      timeout: const Duration(seconds: 25),
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = _verificationId;
        isLoadingResend.value = false;
      },
    );
    debugPrint("_verificationId: $_verificationId");
    return true;
  }
}
