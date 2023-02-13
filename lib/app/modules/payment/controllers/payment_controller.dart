import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/enum/payment_method.dart';
import 'package:tien_duong/app/core/utils/motion_toast_service.dart';
import 'package:tien_duong/app/data/repository/request_model/vnpay_url_model.dart';
import 'package:tien_duong/app/data/repository/vnpay_req.dart';
import 'package:tien_duong/app/network/exceptions/base_api_exception.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class PaymentController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();

  final depositController = TextEditingController();

  final depositFocusNode = FocusNode();
  var depositHasFocus = false;
  var isEmpty = true;
  bool get isShowClear => depositHasFocus && !isEmpty;

  PaymentMethod selectedPaymentMethod = PaymentMethod.vnpay;
  String? depositText;

  int accountBalance = -1;
  bool get hasAccountBalance {
    return accountBalance >= 0;
  }

  var accountBalanceIsLoading = false.obs;
  var submitIsLoading = false.obs;

  String get accountBalanceVND => accountBalance.toVND();

  final VnPayReq _vnpayRepo = Get.find(tag: (VnPayReq).toString());

  Future<void> reload() async {
    await _authController.reloadAccount();
    accountBalance = _authController.account!.balance!;
  }

  @override
  void onInit() {
    depositFocusNode.addListener(_onFocusChange);
    depositController.addListener(_onTextChange);
    // accountBalance = AuthController.instance.account!.balance!;
    accountBalance = 10000;
    super.onInit();
  }

  @override
  void onClose() {
    depositFocusNode.removeListener(_onFocusChange);
    depositFocusNode.dispose();
    depositController.removeListener(_onTextChange);
    depositController.dispose();
    super.onClose();
  }

  void _onFocusChange() {
    depositHasFocus = depositFocusNode.hasFocus;
    update();
  }

  void _onTextChange() {
    isEmpty = depositController.text.isEmpty;
    update();
  }

  void changeDeposit(String value) {
    depositController.text = value;
    depositController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: depositController.text.length,
      ),
    );
    formKey.currentState!.validate();
  }

  void changePaymentMethod(PaymentMethod value) {
    selectedPaymentMethod = value;
    update();
  }

  int getInt(String value) {
    return int.tryParse(value.replaceAll('.', '')) ?? 0;
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    submitIsLoading.value = true;

    int depositValue = getInt(depositText!);

    var ipAddress = IpAddress(type: RequestType.json);

    submitIsLoading.value = false;

    if (selectedPaymentMethod == PaymentMethod.paypal) {
      // Get.toNamed(
      //   Routes.PAYPAL,
      //   arguments: {'id': result},
      // );
    } else if (selectedPaymentMethod == PaymentMethod.momo) {
      // Get.toNamed(
      //   Routes.MOMO,
      //   arguments: {'initialUrl': result},
      // );5
    } else if (selectedPaymentMethod == PaymentMethod.vnpay) {
      VnpayUrlModel model = VnpayUrlModel(
        amount: depositValue,
        accountId: _authController.account!.id!,
        // accountId: '0ec0a943-50d2-4f87-b44d-08daf498a55e',
        ip: '192.168.123.123',
      );
      var vnpayApi = _vnpayRepo.getVnPayUrl(model);
      callDataService<String>(vnpayApi, onSuccess: (result) {
        Get.toNamed(
          Routes.VNPAY,
          arguments: {'initialUrl': result},
        );
      }, onStart: () {
        submitIsLoading.value = true;
      }, onComplete: () {
        submitIsLoading.value = false;
      }, onError: ((exception) {
        if (exception is BaseApiException) {
          MotionToastService.showError(exception.message);
        }
      }));
    }
  }
}
