import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/approved_tab/approved_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/deliver_cancel_tab/deliver_cancel_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/deliver_pickup_tab/deliver_pickup_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivered_tab/delivered_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivery_failed_tab/delivery_failed_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivery_tab/delivery_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/reject_tab/reject_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/sender_cancel_tab/sender_cancel_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/success_tab/success_tab_view.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/waiting_tab/waiting_tab_view.dart';

class SenderPackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  List<String> tabsTitle = const [
    'Chờ xác nhận',
    'Đã xác nhận',
    'Đã được nhận',
    'Đang giao hàng',
    'Đã giao hàng',
    'Giao hàng thành công',
    'Giao hàng thất bại',
    'Quản trị viên hủy',
    'Người giao hủy',
    'Đã hủy',
  ];

  final List<Widget> _screens = const [
    WaitingTabView(),
    ApprovedTabView(),
    DeliverPickupTabView(),
    DeliveryTabView(),
    DeliveredTabView(),
    SuccessTabView(),
    DeliveryFailedTabView(),
    RejectTabView(),
    DeliverCancelTabView(),
    SenderCancelTabView(),
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
    tabController = TabController(length: 1, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
