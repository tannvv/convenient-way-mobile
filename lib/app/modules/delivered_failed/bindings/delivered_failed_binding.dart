import 'package:get/get.dart';

import '../controllers/delivered_failed_controller.dart';

class DeliveredFailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveredFailedController>(
      () => DeliveredFailedController(),
    );
  }
}
