import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/services/background_service_notification.dart';
import 'package:tien_duong/app/core/services/firebase_messaging_service.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/widgets/custom_overlay.dart';
import 'package:tien_duong/app/data/constants/prefs_memory.dart';
import 'package:tien_duong/app/data/local/preference/preference_manager.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/balance_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/login_model.dart';
import 'package:tien_duong/app/data/repository/request_model/logout_model.dart';
import 'package:tien_duong/app/data/repository/response_model/authorize_response_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class AuthController extends BaseController {
  final RxBool _isReload = false.obs;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());
  final PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());

  String? _token;
  final Rx<Account?> _account = Rx<Account?>(null);
  final Rx<BalanceModel?> _balanceAvailable = Rx<BalanceModel?>(null);
  final RxBool _isLoadingAvailableBalance = false.obs;

  Account? get account => _account.value;
  int get availableBalance => _balanceAvailable.value?.balance ?? 0;
  bool get isNewAccount => _balanceAvailable.value?.isNewAccount ?? false;
  bool get isLoadingAvailableBalance => _isLoadingAvailableBalance.value;
  set setAccount(Account value) {
    _account.value = value;
  }

  bool get isReload => _isReload.value;

  String? get token {
    if (!isTokenValidDateTime(_token)) {
      return null;
    }
    return _token;
  }

  bool isTokenValidDateTime(String? token) {
    if (token == null) return false;
    Map<String, dynamic> payload = Jwt.parseJwt(_token.toString());
    DateTime? exp = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    if (exp.compareTo(DateTime.now()) <= 0) {
      return false;
    }
    return true;
  }

  Future<String?> getKeyToken(String key) async {
    String? result;
    String token = await prefs.getString(PrefsMemory.token);
    if (token.isNotEmpty) {
      Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
      result = payload[key];
    }
    return result;
  }

  Future<void> reloadAccount() async {
    if (_account.value != null) {
      var accountService = _accountRepo.getAccountId(_account.value!.id!);
      await callDataService<Account?>(accountService,
          onSuccess: (Account? response) async {
            _account.value = response;
            PreferenceManager prefs =
                Get.find(tag: (PreferenceManager).toString());
            prefs.setString(PrefsMemory.userJson, jsonEncode(response));
            loadBalance();
            // BackgroundNotificationService.initializeService();
          },
          onError: (exception) {
            if (exception is BaseException) {
              ToastService.showError((exception).message);
            }
          },
          onStart: () => _isReload.value = true,
          onComplete: () => _isReload.value = false);
    }
  }

  Future<bool> login(LoginModel model,
      {Function? onStart, Function? onComplete}) async {
    bool result = false;
    try {
      String? token;
      var loginService = _accountRepo.login(model);
      await callDataService(loginService,
          onSuccess: (AuthorizeResponseModel response) async {
        token = response.token;
        _account.value = response.account;
        PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
        prefs.setString(PrefsMemory.token, token!);
        prefs.setString(PrefsMemory.userJson, jsonEncode(response.account));
        await BackgroundNotificationService.initializeService();
        await FirebaseMessagingService.registerNotification(
            _account.value!.id!);
        loadBalance();
      }, onError: (exception) {
        if (exception is BaseException) {
          ToastService.showError((exception).message);
        }
      }, onStart: onStart, onComplete: onComplete);

      if (token != null) {
        _token = token;
        result = true;
        Get.offAndToNamed(Routes.HOME);
        // if (_account.value?.status == "NO_ROUTE") {
        //   Get.offAndToNamed(Routes.CREATE_ROUTE);
        // } else {
        //   Get.offAndToNamed(Routes.HOME);
        // }
      }
    } catch (e) {
      debugPrint('Unable to connect');
    }
    return result;
  }

  void setDataPrefs() {
    PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
    if (token != null) {
      prefs.setString(PrefsMemory.token, _token!);
    }
    if (account != null) {
      prefs.setString(PrefsMemory.userJson, jsonEncode(_account));
    }
  }

  Future<Account?> isLoginBefore() async {
    PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
    String? token = await prefs.getString(PrefsMemory.token);
    if (token.isNotEmpty) {
      _token = token;
      String? userJson = await prefs.getString(PrefsMemory.userJson);
      if (userJson.isNotEmpty) {
        _account.value = Account.fromJson(jsonDecode(userJson));
        loadBalance();
        return _account.value;
      }
    }
    return null;
  }

  Future<void> logout() async {
    Get.context?.loaderOverlay.show(
        widget: const CustomOverlay(
      content: 'Đang đăng xuất',
    ));
    // BackgroundNotificationService.stopService();
    await FirebaseMessagingService.unregisterNotification(_account.value!.id!);
    var future =
        _accountRepo.logout(LogoutModel(accountId: _account.value!.id!));
    await callDataService(future, onError: showError);
    await clearToken();
    Get.context?.loaderOverlay.hide();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> loadBalance() async {
    if (_account.value != null) {
      var future = _accountRepo.getAvailableBalance(_account.value!.id!);
      await callDataService(future,
          onSuccess: (BalanceModel response) {
            _balanceAvailable.value = response;
          },
          onError: showError,
          onStart: () {
            _isLoadingAvailableBalance.value = true;
          },
          onComplete: () {
            _isLoadingAvailableBalance.value = false;
          });
    }
  }

  Future<void> clearToken() async {
    _token = null;
    _account.value = null;
    await SharedPreferences.getInstance().then((prefs) {
      prefs.remove(PrefsMemory.token);
      prefs.remove(PrefsMemory.userJson);
    });
  }

  Future<bool> requireCreateRoute() async {
    bool? result = false;
    if (account?.status == "NO_ROUTE") {
      await MaterialDialogService.showConfirmDialog(
          msg: 'Bạn có muốn tạo tuyến đường để có thể nhận gói hàng?',
          closeOnFinish: false,
          onConfirmTap: () async {
            result = await Get.toNamed(Routes.CREATE_ROUTE) as bool?;
            Get.back();
            return false;
          });
    } else {
      result = true;
    }
    return result ?? false;
  }
}
