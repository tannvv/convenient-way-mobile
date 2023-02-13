import 'package:get/get.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/map_location_controller.dart';
import 'package:tien_duong/app/core/controllers/pickup_file_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapLocationController>(() => MapLocationController(),
        fenix: true);
    Get.lazyPut<PickUpFileController>(() => PickUpFileController(),
        fenix: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
