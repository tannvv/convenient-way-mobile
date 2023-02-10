import 'package:tien_duong/app/data/local/preference/preference_manager.dart';
import 'package:tien_duong/app/data/local/preference/preference_manager_impl.dart';
import 'package:get/get.dart';

class LocalBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceManager>(() => PreferenceManagerImpl(),
        tag: (PreferenceManager).toString(), fenix: true);
  }
}
