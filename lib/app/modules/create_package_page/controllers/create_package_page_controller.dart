import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/create_package_model.dart';
import 'package:tien_duong/app/modules/create_package_page/models/create_product_model.dart';

class CreatePackagePageController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();
  final GoongReq _goongRepo = Get.find(tag: (GoongReq).toString());
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  final GlobalKey<FormState> receiverFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pickupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> productsFormKey = GlobalKey<FormState>();

  final formKey = GlobalKey<FormState>();

  final int maxStep = 2;
  final Rx<int> _currentStep = 0.obs;
  int get currentStep => _currentStep.value;
  set currentStep(int value) => _currentStep.value = value;

  String startAddress = '';
  double startLongitude = 0;
  double startLatitude = 0;
  String destinationAddress = '';
  double destinationLongitude = 0;
  double destinationLatitude = 0;
  String receivedName = '';
  String receivedPhone = '';
  double distance = 0;
  double volume = 0;
  double weight = 0;
  double priceShip = 0;
  String note = '';
  RxList<CreateProductModel> products = <CreateProductModel>[].obs;

  final TextEditingController pickupTxtCtrl = TextEditingController();
  final TextEditingController senderTxtCtrl = TextEditingController();
  @override
  void onInit() {
    receivedName = _authController.account?.infoUser?.firstName ?? '';
    receivedPhone = _authController.account?.infoUser?.phone ?? '';
    super.onInit();
  }

  Future<List<ResponseGoong>> queryLocation(String query) async {
    return _goongRepo.getList(query);
  }

  void selectedPickupLocation(ResponseGoong response) {
    if (response.name == null ||
        response.longitude == null ||
        response.latitude == null) {
      ToastService.showError('Địa chỉ không hợp lệ');
    } else {
      startAddress = response.name!;
      startLongitude = response.longitude!;
      startLatitude = response.latitude!;
    }
  }

  void selectedSendLocation(ResponseGoong response) {
    if (response.name == null ||
        response.longitude == null ||
        response.latitude == null) {
      ToastService.showError('Địa chỉ không hợp lệ');
    } else {
      destinationAddress = response.name!;
      destinationLongitude = response.longitude!;
      destinationLatitude = response.latitude!;
    }
  }

  void changeStep(int step) {
    currentStep = step;
  }

  void nextStep() {
    switch (currentStep) {
      case 0:
        if (pickupFormKey.currentState!.validate()) currentStep++;
        break;
      case 1:
        if (receiverFormKey.currentState!.validate()) currentStep++;
        break;
    }
  }

  void previousStep() {
    currentStep--;
  }

  void createProductToList() {
    products.add(CreateProductModel());
  }

  void deleteProductToList(int index) {
    products.removeAt(index);
  }

  void submit() {
    if (!productsFormKey.currentState!.validate()) return;
    MaterialDialogService.showConfirmDialog(onConfirmTap: () {
      CreatePackageModel createPackageModel = CreatePackageModel(
        startAddress: startAddress,
        startLongitude: startLongitude,
        startLatitude: startLatitude,
        destinationAddress: destinationAddress,
        destinationLongitude: destinationLongitude,
        destinationLatitude: destinationLatitude,
        receiverName: receivedName,
        receiverPhone: receivedPhone,
        distance: distance,
        volume: volume,
        weight: weight,
        photoUrl: '',
        priceShip: 20000,
        note: note,
        senderId: _authController.account?.id,
        products: products,
      );

      var future = _packageRepo.create(createPackageModel);
      callDataService(future, onSuccess: (data) {
        ToastService.showSuccess('Tạo đơn hàng thành công');
        Get.back();
      }, onError: showError, onStart: showOverlay, onComplete: hideOverlay);
    });
  }
}
