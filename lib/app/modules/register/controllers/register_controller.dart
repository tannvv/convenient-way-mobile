import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/utils/alert_quick_service.dart';
import 'package:tien_duong/app/core/utils/motion_toast_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/constants/role_name.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/create_account_model.dart';
import 'package:tien_duong/app/data/repository/request_model/is_valid_account_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import 'package:tien_duong/app/modules/register/models/args_register_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormState>();

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());

  String _userName = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  final String _photoUrl =
      'https://cdn-icons-png.flaticon.com/512/147/147144.png';
  final _gender = 'OTHER'.obs;
  String _email = '';
  Rx<bool> isConfirmPhone = false.obs;
  Rx<LatLng?> homeLocation = Rx<LatLng?>(null);
  Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);

  String? get password => _password;
  String? get gender => _gender.value;
  set setUserName(String value) {
    _userName = value;
  }

  set setPassword(String value) {
    _password = value;
  }

  set setFirstName(String value) {
    _firstName = value;
  }

  set setLastName(String value) {
    _lastName = value;
  }

  set setPhone(String value) {
    _phone = value;
  }

  set setGender(String value) {
    _gender.value = value;
  }

  set setEmail(String value) {
    _email = value;
  }

  Future<void> registerAccount() async {
    IsValidAccountModel isValidAccount =
        IsValidAccountModel(phone: '+84$_phone', userName: _userName);
    Future<SimpleResponseModel> future =
        _accountRepo.isValidAccount(isValidAccount);
    await callDataService<SimpleResponseModel>(future, onSuccess: (data) async {
      verifyPhone();
    }, onError: (error) {
      if (error is BaseException) {
        ToastService.showError(error.message);
      } else {
        ToastService.showError('Thông tin không hợp lệ');
      }
    });
  }

  Future<void> gotoSignIn() async {
    await Get.offAndToNamed(Routes.LOGIN);
  }

  void back() {
    Get.back();
  }

  Future<void> verifyPhone() async {
    debugPrint('Phone number: 0$_phone');
    _phone = '+84$_phone';
    isLoading = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phone,
      timeout: const Duration(seconds: 20),
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint('Auth Completed! \nCredential: $credential');
      },
      verificationFailed: (FirebaseAuthException e) {
        isLoading = false;
        if (e.message != null) {
          if (e.message!.contains('block')) {
            ToastService.showError(
                'Số điện thoại đã bị tạm khóa do gửi OTP quá nhiều');
          } else {
            ToastService.showError('${e.message}');
          }
        } else {
          ToastService.showError('Gửi OTP bị lỗi! \n ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        isLoading = false;
        debugPrint(
            'Đã gửi mã OTP \nResendToken: $resendToken, VerificationId: $verificationId');
        CreateAccountModel createAccountModel = CreateAccountModel(
            userName: _userName,
            password: _password,
            email: _email,
            firstName: _firstName,
            lastName: _lastName,
            phone: _phone,
            photoUrl: _photoUrl,
            role: RoleName.user,
            gender: _gender.value);
        ArgsRegisterModel argsRegisterModel = ArgsRegisterModel(
            createAccountModel: createAccountModel,
            verificationId: verificationId,
            resendToken: resendToken);
        await Get.toNamed(Routes.VERIFY_OTP, arguments: argsRegisterModel);
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        debugPrint('Auto Retrieval Timeout! \nVerificationId: $verificationId');
      },
    );
  }
}
