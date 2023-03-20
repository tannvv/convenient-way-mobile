import 'package:get/get.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/tabs/cancel_tab/cancel_tab_controller.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/tabs/refund_failed_tab/refund_failed_tab_controller.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/tabs/refund_success_tab/refund_success_tab_controller.dart';
import 'package:tien_duong/app/modules/package_cancel_and_refund/tabs/sender_cancel_tab/sender_cancel_tab_controller.dart';

import '../controllers/package_cancel_and_refund_controller.dart';

class PackageCancelAndRefundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageCancelAndRefundController>(
      () => PackageCancelAndRefundController(),
    );
    initTabsController();
  }

  void initTabsController() {
    Get.lazyPut<CancelTabController>(() => CancelTabController());
    Get.lazyPut<SenderCancelTabController>(() => SenderCancelTabController());
    Get.lazyPut<RefundFailedTabController>(() => RefundFailedTabController());
    Get.lazyPut<RefundSuccessTabController>(() => RefundSuccessTabController());
  }
}
