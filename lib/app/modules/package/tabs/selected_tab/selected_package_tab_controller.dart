import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/alert_quick_service.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/modules/location_package/controllers/location_package_controller.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/repository/request_model/cancel_package_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import '../../../../core/controllers/pickup_file_controller.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:material_dialogs/dialogs.dart';
import '../../../../core/values/font_weight.dart';
import 'package:tien_duong/app/core/base/processing_tab_base_controller.dart';

class SelectedPackageTabController extends ProcessingTabBaseController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final LocationPackageController _locationPackageController =
      Get.find<LocationPackageController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  RxList<String> packageIdsWarning = <String>[].obs;
  String? reason;
  String? code;

  Future<void> acceptDeliveryPackage(String packageId) async {
    var future = _packageRepo.pickupSuccess(packageId);
    await callDataService(future, onStart: showOverlay, onComplete: hideOverlay,
        onSuccess: (response) {
      packageIdsWarning.value = getPackageIdsNearPackage(
          dataApis.firstWhere((element) => element.id == packageId), dataApis);
      Get.back();
      Get.back();
      if (packageIdsWarning.isNotEmpty) {
        ToastService.showInfo(
            'Còn ${packageIdsWarning.length} gói hàng cần lấy ở gần nơi này');
      } else {
        ToastService.showSuccess('Đã lấy hàng để đi giao');
        Get.back();
      }
      hideOverlay();
      onRefresh();
      _authController.reloadAccount();
      _locationPackageController.fetchPackages();
    }, onError: ((exception) {
      showError(exception);
      Get.back();
    }));
  }

  Future<void> deliverConfirmPackage(String packageId) async {
    if (await PickUpFileController().scanQR() ==
        (packageId.split('-')[1] + packageId.split('-')[2])) {
      MaterialDialogService.showConfirmDialog(
          msg: 'Bạn chắc chắn muốn nhận gói hàng này để đi giao?',
          closeOnFinish: false,
          onConfirmTap: () async {
            var future = _packageRepo.pickupSuccess(packageId);
            await callDataService(future,
                onStart: showOverlay,
                onComplete: hideOverlay, onSuccess: (response) {
              packageIdsWarning.value = getPackageIdsNearPackage(
                  dataApis.firstWhere((element) => element.id == packageId),
                  dataApis);
              Get.back();
              Get.back();
              if (packageIdsWarning.isNotEmpty) {
                ToastService.showInfo(
                    'Còn ${packageIdsWarning.length} gói hàng cần lấy ở gần nơi này');
              } else {
                ToastService.showSuccess('Đã lấy hàng để đi giao');
                Get.back();
              }
              hideOverlay();
              onRefresh();
              _authController.reloadAccount();
              _locationPackageController.fetchPackages();
            }, onError: ((exception) {
              showError(exception);
              Get.back();
            }));
          });
    } else {
      ToastService.showError('QR Code không đúng vui lòng kiểm tra lại!');
    }
  }

  @override
  Future<void> fetchDataApi() async {
    super.fetchDataApi();
    PackageListModel requestModel = PackageListModel(
        deliverId: _authController.account!.id,
        status: PackageStatus.SELECTED,
        pageSize: pageSize,
        pageIndex: pageIndex);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> reportPackage(String packageId) async {
    await MaterialDialogService.showDeleteDialog(
        title: 'Báo xấu',
        msg: 'Bạn chắc chắn muốn báo xấu và hủy gói hàng này?',
        confirmIconData: Icons.check,
        onConfirmTap: () async {
          dynamic result = await Get.toNamed(Routes.CANCEL_PACKAGE,
              arguments: {'packageId': packageId});
          if (result != null && result == true) {
            await QuickAlertService.showSuccess('Huỷ gói hàng thành công',
                duration: 3);
            onRefresh();
          }
        });
  }

  List<String> getPackageIdsNearPackage(Package package, List<Package> list) {
    List<String> packageIds = [];
    List<Package> packages =
        list.where((element) => element.id != package.id).toList();
    for (int i = 0; i < packages.length; i++) {
      double distance = Geolocator.distanceBetween(
          package.startLatitude!,
          package.startLongitude!,
          packages[i].startLatitude!,
          packages[i].startLongitude!);
      debugPrint(
          'Distance package 1: ${package.startLatitude!} - ${package.startLongitude!} ');
      debugPrint(
          'Distance package 2: ${packages[i].startLatitude!} - ${packages[i].startLongitude!} ');
      debugPrint(
          'Distance packageIds:  ${package.id} - ${packages[i].id} : $distance');
      if (distance < 50) {
        packageIds.add(packages[i].id!);
      }
    }
    return packageIds;
  }

  Future<void> cancelPackageDialog(Package package) async {
    // await Dialogs.materialDialog(
    //     context: Get.context!,
    //     customView: _cancelWidget(),
    //     actions: [
    //       IconsButton(
    //         onPressed: () {
    //           Get.back();
    //         },
    //         text: 'Thoát',
    //         iconData: Icons.arrow_back_ios_new,
    //         color: const Color.fromARGB(255, 204, 203, 203),
    //         textStyle: const TextStyle(color: Colors.black38),
    //         iconColor: Colors.black38,
    //       ),
    //       IconsButton(
    //         onPressed: () {
    //           deliverCancelPackage(packageId);
    //         },
    //         text: 'Hủy đơn',
    //         iconData: Icons.check,
    //         color: Colors.red,
    //         textStyle: const TextStyle(color: Colors.white),
    //         iconColor: Colors.white,
    //       ),
    //     ]);
    MaterialDialogService.showDeleteDialog(
      onConfirmTap: () {
        deliverCancelPackage(package.id!);
      },
      title: 'Hủy đơn hàng',
      msg:
          'Bạn chắc chắn muốn hủy đơn hàng này, bạn sẽ bị mất số tiền đã cọc trước đó (${package.getTotalPrice().toVND()}) ?',
      confirmIconData: Icons.check,
    );
  }

  Future<void> deliverCancelPackage(String packageId) async {
    CancelPackageModel requestModel = CancelPackageModel(
      packageId: packageId,
      reason: reason!,
    );
    Future<SimpleResponseModel> future =
        _packageRepo.deliverCancel(requestModel);
    await callDataService<SimpleResponseModel>(future, onSuccess: (data) {
      ToastService.showSuccess('Hủy gói hàng thành công!');
      Get.back();
      refresh();
    }, onError: showError, onStart: showOverlay, onComplete: hideOverlay);
  }

  Future<void> onPickupFailed(Package package) async {
    bool? result =
        await Get.toNamed(Routes.PICKUP_FAILED, arguments: package) as bool?;
    onRefresh();
  }

  Future<void> deliverConfirmCode(String packageId) async {
    confirmCode(() => {confirmCodeFromQR(packageId)});
  }

  Widget _confirmCodeWidget() {
    return Container(
      padding: EdgeInsets.only(top: 40.h),
      height: 100.h,
      width: 220.w,
      child: TextField(
        onChanged: (value) {
          code = value;
        },
        autofocus: true,
        decoration: InputStyles.reasonCancel(labelText: 'Nhập mã xác nhận'),
      ),
    );
  }

  Future<void> confirmCode(Function() callback) async {
    await Dialogs.materialDialog(
        context: Get.context!,
        customView: _confirmCodeWidget(),
        actions: [
          IconsButton(
            onPressed: () {
              Get.back();
            },
            text: 'Thoát',
            iconData: Icons.arrow_back_ios_new,
            color: const Color.fromARGB(255, 204, 203, 203),
            textStyle: const TextStyle(color: Colors.black38),
            iconColor: Colors.black38,
          ),
          IconsButton(
            onPressed: () {
              callback();
              Get.back();
            },
            text: 'Xác nhận',
            iconData: Icons.check,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  Future<void> confirmCodeFromQR(String packageId) async {
    if (code == null ||
        code != (packageId.split('-')[1] + packageId.split('-')[2])) {
      ToastService.showError('Mã số sai, vui lòng quét mã QR và kiểm tra lại!',
          seconds: 5);
      return;
    }
    if (code == (packageId.split('-')[1] + packageId.split('-')[2])) {
      acceptDeliveryPackage(packageId);
      ToastService.showSuccess('Xác nhận gói hàng đã đến tay!');
      refresh();
    }
  }

  Future<void> showQRCode(String packageId) async {
    final svg = Barcode.qrCode().toSvg(packageId.split('-')[0]);
    await Dialogs.materialDialog(
        dialogWidth: 400.w,
        context: Get.context!,
        customView: _qrCodeWidget(svg, packageId.split('-')[0]));
  }

  Widget _qrCodeWidget(String svg, String packageId) {
    return Container(
      padding: EdgeInsets.only(top: 40.h, right: 40.w, left: 40.w),
      child: Column(
        children: [
          Text(
            'Dùng mã này để xác nhận người nhờ lấy hàng giùm.',
            style: subtitle2,
          ),
          Gap(4.h),
          RichText(
              text: TextSpan(
                  text: 'Chú ý:',
                  style: caption.copyWith(
                      color: Colors.red[600],
                      fontWeight: FontWeights.medium,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline),
                  children: [
                TextSpan(
                    text:
                        ' Tuyệt đối không chia sẽ mã này với người không liên quan.',
                    style: caption.copyWith(decoration: TextDecoration.none))
              ])),
          Gap(20.h),
          SizedBox(
            height: 200.h,
            width: 200.w,
            child: SvgPicture.string(
              svg,
              fit: BoxFit.cover,
            ),
          ),
          Gap(20.h),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ColorButton(
              'Mã xác nhận: $packageId',
              icon: Icons.verified,
              onPressed: () {},
              backgroundColor: AppColors.green,
              textColor: AppColors.green,
              radius: 8.sp,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            ),
            RichText(
                text: TextSpan(
                    text: 'Chú ý:',
                    style: caption.copyWith(
                        color: Colors.red[600],
                        fontWeight: FontWeights.medium,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline),
                    children: [
                  TextSpan(
                      text:
                          ' Dùng mã này để xác nhận với người nhờ lấy hàng giùm.',
                      style: caption.copyWith(decoration: TextDecoration.none))
                ])),
          ]),
        ],
      ),
    );
  }
}
