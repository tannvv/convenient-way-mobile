import 'package:get/get.dart';

import '../controllers/pickup_failed_controller.dart';

class PickupFailedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickupFailedController>(
      () => PickupFailedController(),
    );
  }
}
