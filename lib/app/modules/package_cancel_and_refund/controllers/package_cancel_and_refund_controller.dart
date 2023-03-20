import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/models/package_count_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/tabs/sender_cancel_tab/sender_cancel_tab_view.dart';

import '../tabs/cancel_tab/cancel_tab_view.dart';
import '../tabs/refund_failed_tab/refund_failed_tab_view.dart';
import '../tabs/refund_success_tab/refund_success_tab_view.dart';

class PackageCancelAndRefundController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageReq = Get.find(tag: (PackageReq).toString());

  final RxList<String> tabsTitle = [
    'Hoàn trả thành công (0)',
    'Hoàn trả thất bại (0)',
    'Đã hủy (0)',
    'Người gửi hủy (0)',
  ].obs;

  final List<Widget> _screens = const [
    RefundSuccessTabView(),
    RefundFailedTabView(),
    CancelTabView(),
    SenderCancelTabView(),
  ];

  List<Widget> get screens => _screens;

  final indexScreen = 0.obs;
  Widget get currentScreen => _screens[indexScreen.value];

  void changeTab(int index) {
    indexScreen.value = index;
  }

  @override
  void onInit() {
    fetchPackageCount();
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> fetchPackageCount() async {
    if (_authController.account != null) {
      var future = _packageReq.getPackageCount(_authController.account!.id!);
      await callDataService<PackageCount>(
        future,
        onSuccess: (response) {
          tabsTitle.value = [];
          List<String> newCount = [];
          newCount.add(
              'Hoàn trả thành công (${response.refundToWarehouseSuccess})');
          newCount
              .add('Hoàn trả thất bại (${response.refundToWarehouseFailed})');
          newCount.add('Đã hủy (${response.deliverCancel})');
          newCount.add('Người gửi hủy (${response.senderCancel})');
          tabsTitle.value = newCount;
        },
        onError: showError,
      );
    }
  }
}
