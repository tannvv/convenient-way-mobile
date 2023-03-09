import 'dart:async';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:tien_duong/app/core/base/sender_tab_base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/controllers/pickup_file_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';

class DeliverPickupTabController extends SenderTabBaseController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.DELIVER_PICKUP,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> accountConfirmPackage(String packageId) async {
    if (await PickUpFileController().scanQR() == packageId.split('-')[0]) {
      MaterialDialogService.showConfirmDialog(
        msg: 'Xác nhân đã đưa hàng cho đúng người lấy hàng giùm?',
        closeOnFinish: false,
        onConfirmTap: () async {
          _packageRepo.confirmPackage(packageId).then((response) async {
            Get.back();
            onRefresh();
            _authController.reloadAccount();
          }).catchError((error) {
            Get.back();
            ToastService.showError(error.messages[0]);
          });
        },
      );
    }
  }

  Future<void> confirmPackage(String packageId) async {
    _packageRepo.confirmPackage(packageId).then((response) async {
      Get.back();
      onRefresh();
      _authController.reloadAccount();
    }).catchError((error) {
      Get.back();
      ToastService.showError(error.messages[0]);
    });
  }

  Future<void> senderConfirmCode(String packageId) async {
    confirmCode(() => {confirmCodeFromQR(packageId)});
  }

  Future<void> confirmCodeFromQR(String packageId) async {
    if (code == null || code != packageId.split('-')[0]) {
      ToastService.showError('Mã số sai, vui lòng quét mã QR và kiểm tra lại!',
          seconds: 5);
      return;
    }
    if (code == packageId.split('-')[0]) {
      await _packageRepo.deliverySuccess(packageId).then((response) async {
        Get.back();
        onRefresh();
        _authController.reloadAccount();
      }).catchError((error) {
        Get.back();
        ToastService.showError(error.messages[0]);
      });
      ToastService.showSuccess(
          'Xác nhận đã đưa gói hàng cho người lấy hàng giùm!');
      refresh();
    }
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
            'Dùng mã này để xác nhận người lấy hàng giùm.',
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
              'Mã xác nhận: ${packageId.split('-')[0]}',
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
                          ' Dùng mã này để xác nhận với người nhận lấy hàng giùm.',
                      style: caption.copyWith(decoration: TextDecoration.none))
                ])),
          ]),
        ],
      ),
    );
  }
}
