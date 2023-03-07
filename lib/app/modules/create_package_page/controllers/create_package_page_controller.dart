import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/pickup_file_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/widgets/custom_overlay.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/create_package_model.dart';
import 'package:tien_duong/app/modules/create_package_page/models/create_product_model.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class CreatePackagePageController extends BaseController {
  final Package? _package = Get.arguments as Package?;

  final AuthController _authController = Get.find<AuthController>();
  final PickUpFileController _pickUpFileController =
      Get.find<PickUpFileController>();
  final GoongReq _goongRepo = Get.find(tag: (GoongReq).toString());
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  final GlobalKey<FormState> receiverFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> pickupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> productsFormKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> startLocationKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> endLocationKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> pickupNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> pickupPhoneKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> receiverNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> receiverPhoneKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> lengthKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> widthKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> heightKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> weightKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> noteKey = GlobalKey<FormFieldState>();

  final FocusNode focusStartLocationNode = FocusNode();
  final FocusNode focusEndLocationNode = FocusNode();
  final FocusNode focusPickupName = FocusNode();
  final FocusNode focusPickupPhone = FocusNode();
  final FocusNode focusReceiverPhone = FocusNode();
  final FocusNode focusReceiverName = FocusNode();
  final FocusNode focusLength = FocusNode();
  final FocusNode focusWidth = FocusNode();
  final FocusNode focusHeight = FocusNode();
  final FocusNode focusWeight = FocusNode();
  final FocusNode focusNote = FocusNode();

  final imagesController = MultiImagePickerController(
    maxImages: 10,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  Iterable<ImageFile> images = [];

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
  String pickupName = '';
  String pickupPhone = '';
  String receivedName = '';
  String receivedPhone = '';
  final RxDouble distance = 0.0.obs;
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
    listenFocusNode();
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
    distance.value = _package!.distance ?? 0;
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
      // distance.value = Geolocator.distanceBetween(startLatitude!,
      //         startLatitude!, destinationLatitude!, destinationLongitude!) /
      //     1000;
      distance.value = calculateDistance(startLatitude, startLongitude,
          destinationLatitude, destinationLongitude);
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
        onConfirmTap: () async {
          if(_authController.isNewAccount || (_authController.availableBalance < 50000)) {
            MaterialDialogService.showConfirmDialog(
              msg: 'Cần có tối thiểu 50.000 VNĐ trong tài khoản\nVui lòng nạp thêm tiền!',
              onConfirmTap: () async {
                Get.toNamed(Routes.PAYMENT);
              }
            );
          } else {
            uploadImageAndCreatePackage();
          }
        });
  }

  Future<void> uploadImageAndCreatePackage() async {
    String packageId = const Uuid().v4();

    List<String> urlsImage =
        await _pickUpFileController.uploadImagesToFirebase2(
      images: images,
      url: 'packages/$packageId',
      onComplete: Get.context!.loaderOverlay.hide,
      onStart: () => Get.context!.loaderOverlay.show(
          widget: const CustomOverlay(
        content: 'Đang tải ảnh lên...',
      )),
    );
    if (urlsImage.isEmpty) return;
    Get.context!.loaderOverlay.show(
        widget: const CustomOverlay(
      content: 'Đang tạo gói hàng...',
    ));
    distance.value = Geolocator.distanceBetween(startLatitude!, startLatitude!,
        destinationLatitude!, destinationLongitude!);
    CreatePackageModel createPackageModel = CreatePackageModel(
      id: packageId,
      startAddress: startAddress,
      startLongitude: startLongitude,
      startLatitude: startLatitude,
      destinationAddress: destinationAddress,
      destinationLongitude: destinationLongitude,
      destinationLatitude: destinationLatitude,
      pickupName: pickupName,
      pickupPhone: pickupPhone,
      receiverName: receivedName,
      receiverPhone: receivedPhone,
      distance: distance.value,
      length: length,
      width: width,
      height: height,
      weight: weight,
      photoUrl: urlsImage.first,
      priceShip: 20000,
      note: note,
      senderId: _authController.account?.id,
      products: products,
    );

    var future = _packageRepo.create(createPackageModel);
    callDataService(future, onSuccess: (data) {
      ToastService.showSuccess('Tạo đơn hàng thành công');
      Get.back(); // return waiting screen
    }, onError: showError, onComplete: hideOverlay);
  }

  int getPriceShip() {
    if (distance.value == 0.0) return 0;
    if (distance.value <= 10) {
      return 14000;
    } else if (distance.value <= 15) {
      return 17000;
    } else {
      return 20000;
    }
  }

  void listenFocusNode() {
    focusStartLocationNode.addListener(() {
      if (!focusStartLocationNode.hasFocus) {
        // startLocationKey.currentState?.validate();
        pickupFormKey.currentState?.validate();
      }
    });
    focusPickupPhone.addListener(() {
      if (!focusPickupPhone.hasFocus) {
        pickupPhoneKey.currentState?.validate();
      }
    });
    focusPickupName.addListener(() {
      if (!focusPickupName.hasFocus) {
        pickupNameKey.currentState?.validate();
      }
    });
    focusEndLocationNode.addListener(() {
      if (!focusEndLocationNode.hasFocus) {
        // endLocationKey.currentState?.validate();
        receiverFormKey.currentState?.validate();
      }
    });
    focusReceiverPhone.addListener(() {
      if (!focusReceiverPhone.hasFocus) {
        receiverPhoneKey.currentState?.validate();
      }
    });
    focusReceiverName.addListener(() {
      if (!focusReceiverName.hasFocus) {
        receiverNameKey.currentState?.validate();
      }
    });
    focusLength.addListener(() {
      if (!focusLength.hasFocus) {
        lengthKey.currentState?.validate();
      }
    });
    focusWidth.addListener(() {
      if (!focusWidth.hasFocus) {
        widthKey.currentState?.validate();
      }
    });
    focusHeight.addListener(() {
      if (!focusHeight.hasFocus) {
        heightKey.currentState?.validate();
      }
    });
    focusWeight.addListener(() {
      if (!focusWeight.hasFocus) {
        weightKey.currentState?.validate();
      }
    });
    focusNote.addListener(() {
      if (!focusNote.hasFocus) {
        noteKey.currentState?.validate();
      }
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
