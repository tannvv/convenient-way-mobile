import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/create_package_model.dart';
import 'package:tien_duong/app/modules/create_package_page/models/create_product_model.dart';
import 'package:uuid/uuid.dart';

class CreatePackagePageController extends BaseController {
  final Package? _package = Get.arguments as Package?;

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

  String? startAddress;
  double? startLongitude;
  double? startLatitude;
  String? destinationAddress;
  double? destinationLongitude;
  double? destinationLatitude;
  String receivedName = '';
  String receivedPhone = '';
  double distance = 0;
  double? length;
  double? width;
  double? height;
  double? weight;
  int priceShip = 0;
  String note = '';
  RxList<CreateProductModel> products = <CreateProductModel>[].obs;

  final TextEditingController pickupTxtCtrl = TextEditingController();
  final TextEditingController senderTxtCtrl = TextEditingController();
  @override
  void onInit() {
    setDataReCreate();
    receivedName = _authController.account?.infoUser?.firstName ?? '';
    receivedPhone = _authController.account?.infoUser?.phone ?? '';
    super.onInit();
  }

  void setDataReCreate() {
    if (_package == null) return;
    startAddress = _package!.startAddress ?? '';
    pickupTxtCtrl.text = startAddress ?? '';
    startLongitude = _package!.startLongitude ?? 0;
    startLatitude = _package!.startLatitude ?? 0;
    destinationAddress = _package!.destinationAddress ?? '';
    senderTxtCtrl.text = destinationAddress ?? '';
    destinationLongitude = _package!.destinationLongitude ?? 0;
    destinationLatitude = _package!.destinationLatitude ?? 0;
    receivedName = _package!.receiverName ?? '';
    receivedPhone = _package!.receiverPhone ?? '';
    distance = _package!.distance ?? 0;
    length = _package!.length ?? 0;
    width = _package!.width ?? 0;
    height = _package!.height ?? 0;
    weight = _package!.weight ?? 0;
    priceShip = _package!.priceShip ?? 0;
    note = _package!.note ?? '';
    if (_package!.products != null) {
      products =
          RxList(_package!.products!.map((e) => e.toCreateModel()).toList());
    }
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
    MaterialDialogService.showConfirmDialog(
        msg: 'Bạn chắc chắn muốn tạo gói hàng này?',
        onConfirmTap: () {
          distance = Geolocator.distanceBetween(startLatitude!, startLatitude!,
              destinationLatitude!, destinationLongitude!);
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
            length: length,
            width: width,
            height: height,
            weight: weight,
            photoUrl: const Uuid().v4(),
            priceShip: 20000,
            note: note,
            senderId: _authController.account?.id,
            products: products,
          );

          var future = _packageRepo.create(createPackageModel);
          callDataService(future, onSuccess: (data) {
            ToastService.showSuccess('Tạo đơn hàng thành công');
            Get.back(); // return waiting screen
          }, onError: showError, onStart: showOverlay, onComplete: hideOverlay);
        });
  }
}
