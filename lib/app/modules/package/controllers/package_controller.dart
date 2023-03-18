import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../tabs/delivered_failed_tab/delivered_failed_tab_view.dart';
import '../tabs/delivered_success_tab/delivered_success_tab_view.dart';
import '../tabs/pickup_success_tab/pickup_success_tab_view.dart';
import '../tabs/selected_tab/selected_package_tab_view.dart';

class PackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  List<String> tabsTitle = const [
    'Chờ lấy hàng',
    'Chờ giao hàng',
    'Giao hàng thành công',
    'Giao hàng thất bại',
  ];

  final List<Widget> _screens = const [
    SelectedPackageTabView(),
    PickupSuccessTabView(),
    DeliveredSuccessTabView(),
    DeliveredFailedTabView(),
  ];

  List<Widget> get screens => _screens;

  PageStorageBucket bucket = PageStorageBucket();
  final indexScreen = 0.obs;
  Widget get currentScreen => _screens[indexScreen.value];

  void changeTab(int index) {
    indexScreen.value = index;
  }

  @override
  void onInit() {
    tabController = TabController(length: 7, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
