import 'package:get/get.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/map_location_controller.dart';
import 'package:tien_duong/app/core/controllers/pickup_file_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<MapLocationController>(MapLocationController(), permanent: true);
    Get.lazyPut<PickUpFileController>(() => PickUpFileController(),
        fenix: true);
  }
}
