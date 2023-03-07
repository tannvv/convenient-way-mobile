import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/deliver_cancel_tab/deliver_cancel_package_view.dart';
import 'package:tien_duong/app/modules/package/tabs/delivered_tab/delivered_package_view.dart';
import 'package:tien_duong/app/modules/package/tabs/delivery_tab/delivery_package_view.dart';
import 'package:tien_duong/app/modules/package/tabs/failed_tab/failed_package_view.dart';
import 'package:tien_duong/app/modules/package/tabs/received_tab/received_package_view.dart';
import 'package:tien_duong/app/modules/package/tabs/sender_cancel_tab/sender_cancel_package_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  List<String> tabsTitle = const [
    'Đã nhận',
    'Đang giao',
    'Giao hàng thành công',
    'Giao hàng thất bại',
    'Người gửi hủy',
    'Đã hủy'
  ];

  final List<Widget> _screens = const [
    ReceivedPackageView(),
    DeliveryPackageView(),
    DeliveredPackageView(),
    FailedPackageView(),
    SenderCancelPackageView(),
    DeliverCancelPackageView(),
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
