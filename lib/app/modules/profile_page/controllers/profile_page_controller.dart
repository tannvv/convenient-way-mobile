import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/pickup_file_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/update_account_model.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

enum FieldUpdate { firstName, phone, image }

class ProfilePageController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();
  final photoUrl = ''.obs;
  final PickUpFileController _pickup = Get.find<PickUpFileController>();
  final AccountRep _accountRep = Get.find(tag: (AccountRep).toString());

  Rx<String> phoneField = ''.obs;
  Rx<String> firstNameField = ''.obs;
  String get accountBalanceVND =>
      _authController.account?.balance.toVND() ?? '-';
  String get initName =>
      '${account?.infoUser?.firstName ?? '-'} ${account?.infoUser?.lastName ?? '-'}';
  String get initPhone => '${account?.infoUser!.phone!}';
  String get initGender => account?.infoUser?.gender ?? 'OTHER';
  String get initEmail => account?.infoUser?.email ?? '-';
  Account? get account => _authController.account;
  @override
  void onInit() {
    phoneField.value = initPhone;
    firstNameField.value = initName;
    photoUrl.value = account?.infoUser?.photoUrl! ?? '-';
    super.onInit();
  }

  void gotoTransactions() {
    Get.toNamed(Routes.TRANSACTION);
  }

  Future<void> signOut() async {
    MaterialDialogService.showConfirmDialog(
      title: 'Đăng xuất',
      msg: 'Bạn có muốn đăng xuất không?',
      onConfirmTap: () => _authController.logout(),
    );
  }

  Future<void> uploadImage() async {
    XFile? image = await _pickup.pickImage();
    if (image != null) {
      photoUrl.value = await _pickup.uploadImageToFirebase(
              image, 'user/avatar/${account?.id}') ??
          'https://thuvienplus.com/themes/cynoebook/public/images/default-user-image.png';
      updateAccount(FieldUpdate.image, photoUrl.value);
    }
  }

  Future<void> updateFirstName() async {
    if (firstNameField.value != initName) {
      updateAccount(FieldUpdate.firstName, firstNameField.value);
    }
  }

  Future<void> updateAccount(FieldUpdate field, String value) async {
    switch (field) {
      case FieldUpdate.firstName:
        account?.infoUser?.firstName = value;
        break;
      case FieldUpdate.phone:
        account?.infoUser?.phone = value;
        break;
      case FieldUpdate.image:
        account?.infoUser?.photoUrl = value;
        break;
    }
    UpdateAccount model = UpdateAccount.fromAccount(account!);
    var future = _accountRep.updateAccount(model);
    callDataService<Account>(future, onSuccess: (data) {
      _authController.setAccount = data;
      _authController.setDataPrefs();
      ToastService.showSuccess('Cập nhật thành công');
    }, onStart: showOverlay, onComplete: hideOverlay);
  }
}
