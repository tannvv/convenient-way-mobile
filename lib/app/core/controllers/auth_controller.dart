import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/services/background_service_notification.dart';
import 'package:tien_duong/app/core/services/firebase_messaging_service.dart';
import 'package:tien_duong/app/core/utils/motion_toast_service.dart';
import 'package:tien_duong/app/data/constants/prefs_memory.dart';
import 'package:tien_duong/app/data/local/preference/preference_manager.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/login_model.dart';
import 'package:tien_duong/app/data/repository/response_model/authorize_response_model.dart';
import 'package:tien_duong/app/network/exceptions/base_exception.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class AuthController extends BaseController {
  final RxBool _isReload = false.obs;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());
  final PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());

  String? _token;
  final Rx<Account?> _account = Rx<Account?>(null);

  Account? get account => _account.value;
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

  @override
  void onInit() {
    super.onInit();
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
            BackgroundNotificationService.initializeService();
          },
          onError: (exception) {
            if (exception is BaseException) {
              MotionToastService.showError((exception).message);
            }
          },
          onStart: () => _isReload.value = true,
          onComplete: () => _isReload.value = false);
    }
  }

  Future<bool> login(LoginModel model) async {
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
      }, onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError((exception).message);
        }
      });

      if (token != null) {
        _token = token;
        result = true;
        if (_account.value?.status == "NO_ROUTE") {
          Get.offAndToNamed(Routes.CREATE_ROUTE);
        } else {
          Get.offAndToNamed(Routes.HOME);
        }
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
        return _account.value;
      }
    }
    return null;
  }

  Future<void> logout() async {
    BackgroundNotificationService.stopService();
    await FirebaseMessagingService.unregisterNotification(_account.value!.id!);
    await clearToken();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> clearToken() async {
    _token = null;
    _account.value = null;
    await SharedPreferences.getInstance().then((prefs) {
      prefs.remove(PrefsMemory.token);
      prefs.remove(PrefsMemory.userJson);
    });
  }
}
