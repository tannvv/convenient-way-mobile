import 'package:flutter/material.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/create_feedback_model.dart';

class FeedbackForDeliverController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();
  Package package = Get.arguments as Package;

  String? customerTripId;
  String? driverId;
  Rx<String?> photoUrl = ''.obs;
  Rx<String?> gender = ''.obs;
  final TextEditingController messageController = TextEditingController();
  bool backToHome = false;

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Rx<double> feedBackPoint = 0.0.obs;

  void changePoint(double point) {
    feedBackPoint.value = point;
  }

  Rx<String> feedBackEmotion = ''.obs;

  void changeFeedBackEmotion(String value) {
    feedBackEmotion.value = value;
  }

  void submit() async {
    CreateFeedbackModel model = CreateFeedbackModel();
    model.accountId = _authController.account!.id;
    model.content = messageController.text;
    model.feedbackFor = 'DELIVER';
    model.rating = feedBackPoint.value;
    model.packageId = package.id;
    var future = _packageRepo.createFeedback(model);
    await callDataService(future, onSuccess: (_) {
      ToastService.showSuccess('Tạo phản hồi thành công');
      Get.back();
    }, onError: showError);
  }
}
