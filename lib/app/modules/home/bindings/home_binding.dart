import 'package:tien_duong/app/modules/package/tabs/deliver_cancel_tab/deliver_cancel_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/delivered_tab/delivered_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/delivery_failed_tab/delivery_failed_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/delivery_tab/delivery_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/failed_tab/failed_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/received_tab/received_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/refund_failed_tab/refund_failed_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/sender_cancel_tab/sender_cancel_package_controller.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/modules/package/tabs/success_tab/success_package_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/approved_tab/approved_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/deliver_cancel_tab/deliver_cancel_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/deliver_pickup_tab/deliver_pickup_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivered_tab/delivered_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivery_failed_tab/delivery_failed_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/delivery_tab/delivery_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/reject_tab/reject_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/sender_cancel_tab/sender_cancel_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/success_tab/success_tab_controller.dart';
import 'package:tien_duong/app/modules/sender_package/tabs/waiting_tab/waiting_tab_controller.dart';
import '../../package/tabs/refund_success_tab/refund_success_package_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    deliverTabController();
    senderTabController();
  }

  void deliverTabController() {
    Get.lazyPut<ReceivedPackageController>(() => ReceivedPackageController());
    Get.lazyPut<DeliveryPackageController>(() => DeliveryPackageController());
    Get.lazyPut<DeliveredPackageController>(() => DeliveredPackageController());
    Get.lazyPut<DeliverCancelPackageController>(
        () => DeliverCancelPackageController());
    Get.lazyPut<SenderCancelPackageController>(
        () => SenderCancelPackageController());
    Get.lazyPut<FailedPackageController>(() => FailedPackageController());
    Get.lazyPut<SuccessPackageController>(() => SuccessPackageController());
    Get.lazyPut<DeliveryFailedPackageController>(
        () => DeliveryFailedPackageController());
    Get.lazyPut<RefundSuccessPackageController>(
        () => RefundSuccessPackageController());
    Get.lazyPut<RefundFailedPackageController>(
        () => RefundFailedPackageController());
  }

  void senderTabController() {
    Get.lazyPut<ApprovedTabController>(() => ApprovedTabController());
    Get.lazyPut<DeliverCancelTabController>(() => DeliverCancelTabController());
    Get.lazyPut<DeliverPickupTabController>(() => DeliverPickupTabController());
    Get.lazyPut<DeliveredTabController>(() => DeliveredTabController());
    Get.lazyPut<DeliveryFailedTabController>(
        () => DeliveryFailedTabController());
    Get.lazyPut<DeliveryTabController>(() => DeliveryTabController());
    Get.lazyPut<RejectTabController>(() => RejectTabController());
    Get.lazyPut<SenderCancelTabController>(() => SenderCancelTabController());
    Get.lazyPut<SuccessTabController>(() => SuccessTabController());
    Get.lazyPut<WaitingTabController>(() => WaitingTabController());
  }
}
