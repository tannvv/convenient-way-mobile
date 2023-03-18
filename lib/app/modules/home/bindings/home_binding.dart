import 'package:get/get.dart';
import 'package:tien_duong/app/modules/package/tabs/delivered_success_tab/delivered_success_tab_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/pickup_success_tab/pickup_success_tab_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/selected_tab/selected_package_tab_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/success_tab/success_package_controller.dart';

import '../../package/tabs/delivered_failed_tab/delivered_failed_tab_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    deliverTabController();
  }

  void deliverTabController() {
    Get.lazyPut<SelectedPackageTabController>(
        () => SelectedPackageTabController());
    Get.lazyPut<PickupSuccessTabController>(() => PickupSuccessTabController());
    Get.lazyPut<DeliveredSuccessTabController>(
        () => DeliveredSuccessTabController());
    Get.lazyPut<DeliveredFailedTabController>(
        () => DeliveredFailedTabController());

    Get.lazyPut<SuccessPackageController>(() => SuccessPackageController());
  }
}
