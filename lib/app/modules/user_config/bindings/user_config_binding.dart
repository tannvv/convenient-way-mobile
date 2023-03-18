import 'package:get/get.dart';

import '../controllers/user_config_controller.dart';

class UserConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserConfigController>(
      () => UserConfigController(),
    );
  }
}
