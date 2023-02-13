import 'package:get/get.dart';
import 'package:tien_duong/app/bindings/controller_binding.dart';
import 'package:tien_duong/app/bindings/local_bindings.dart';
import 'package:tien_duong/app/bindings/repository_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RepositoryBindings().dependencies();
    LocalBindings().dependencies();
    ControllerBindings().dependencies();
  }
}
