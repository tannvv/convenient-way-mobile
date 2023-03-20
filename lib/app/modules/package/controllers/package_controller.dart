import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/models/package_count_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';

import '../tabs/delivered_failed_tab/delivered_failed_tab_view.dart';
import '../tabs/delivered_success_tab/delivered_success_tab_view.dart';
import '../tabs/pickup_success_tab/pickup_success_tab_view.dart';
import '../tabs/selected_tab/selected_package_tab_view.dart';

class PackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageReq = Get.find(tag: (PackageReq).toString());

  final RxList<String> tabsTitle = [
    'Chờ lấy hàng',
    'Chờ giao hàng',
    'Giao hàng thành công',
    'Giao hàng thất bại',
  ].obs;

  final List<Widget> _screens = const [
    SelectedPackageTabView(),
    PickupSuccessTabView(),
    DeliveredSuccessTabView(),
    DeliveredFailedTabView(),
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
          newCount.add('Chờ lấy hàng (${response.selected})');
          newCount.add('Chờ giao hàng (${response.pickupSuccess})');
          newCount.add('Giao hàng thành công (${response.deliveredSuccess})');
          newCount.add('Giao hàng thất bại (${response.deliveredFailed})');
          tabsTitle.value = newCount;
        },
        onError: showError,
      );
    }
  }
}
