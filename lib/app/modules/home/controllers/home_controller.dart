// ignore_for_file: unused_field

import 'package:tien_duong/app/core/controllers/map_location_controller.dart';
import 'package:tien_duong/app/modules/location_package/controllers/location_package_controller.dart';
import 'package:tien_duong/app/modules/location_package/views/location_package_view.dart';
import 'package:tien_duong/app/modules/message_page/controllers/message_page_controller.dart';
import 'package:tien_duong/app/modules/notify_page/controllers/notify_page_controller.dart';
import 'package:tien_duong/app/modules/notify_page/views/notify_page_view.dart';
import 'package:tien_duong/app/modules/package/controllers/package_controller.dart';
import 'package:tien_duong/app/modules/package/views/package_view.dart';
import 'package:tien_duong/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:tien_duong/app/modules/profile_page/views/profile_page_view.dart';
import 'package:tien_duong/app/modules/suggest_package/controllers/suggest_package_controller.dart';
import 'package:tien_duong/app/modules/suggest_package/views/suggest_package_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late MessagePageController _messageController;
  late PackageController _packageController;
  late NotifyPageController _notifyController;
  late SuggestPackageController _suggestPackageController;
  late ProfilePageController _profileController;
  late LocationPackageController _locationPackageController;
  late MapLocationController _mapLocationController;

  final _selectedIndex = Get.arguments != null
      ? int.parse(Get.arguments['initialPageIndex']).obs
      : 0.obs;

  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) {
    _selectedIndex.value = value;
  }

  final count = 0.obs;

  final List<Widget> _widgetOptions = [
    SuggestPackageView(),
    const PackageView(),
    const NotifyPageView(),
    ProfilePageView(),
    const LocationPackageView()
  ];

  PageStorageBucket bucket = PageStorageBucket();
  Widget get currentScreen => _widgetOptions[_selectedIndex.value];

  void changeTab(int index) {
    _selectedIndex.value = index;
  }

  @override
  void onInit() {
    initController();
    super.onInit();
  }

  Future<void> initController() async {
    Get.put(MessagePageController(), permanent: true);
    _messageController = Get.find<MessagePageController>();
    Get.put(NotifyPageController(), permanent: true);
    _notifyController = Get.find<NotifyPageController>();
    Get.put(SuggestPackageController(), permanent: true);
    _suggestPackageController = Get.find<SuggestPackageController>();
    Get.put(ProfilePageController(), permanent: true);
    _profileController = Get.find<ProfilePageController>();
    Get.put(PackageController());
    _packageController = Get.find<PackageController>();
    Get.put(LocationPackageController());
    _locationPackageController = Get.find<LocationPackageController>();
    _mapLocationController = Get.find<MapLocationController>();
  }

  void demoBui() {}
}