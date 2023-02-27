import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/utils/material_dialog_service.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/account_rating_model.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/user_info.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

abstract class SenderTabBaseController<T> extends BasePagingController<T> {
  AccountRating? deliverRating;

  final RxBool _isLoadingInfo = false.obs;

  String? reason;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());

  void showInfoDeliver(Account deliver) async {
    var future = _accountRepo.getRating(deliver.id!);
    callDataService<AccountRating>(
      future,
      onSuccess: (data) {
        deliverRating = data;
        if (data.totalRatingDeliver == 0) {
          ToastService.showInfo('Chưa có đánh giá nào');
        }
      },
      onError: (exception) => showError(exception),
      onStart: () => _isLoadingInfo.value = true,
      onComplete: () => _isLoadingInfo.value = false,
    );
    MaterialDialogService.showEmptyDialog(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(info: deliver.infoUser!),
          Gap(24.h),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  text: 'Số điện thoại: ',
                  style: subtitle2.copyWith(fontWeight: FontWeights.regular)),
              TextSpan(text: deliver.infoUser!.phone, style: subtitle2),
            ],
          )),
          Gap(8.h),
          Obx(() => _isLoadingInfo.value
              ? Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  child: Container(
                    width: 200.w,
                    height: 32.h,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: deliverRating!.averageRatingDeliver!,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      ignoreGestures: true,
                      onRatingUpdate: (_) {},
                    ),
                  ],
                ))
        ],
      ),
    ));
  }

  Future<dynamic> reCreatePackage(Package package) async {
    return await Get.toNamed(Routes.CREATE_PACKAGE_PAGE, arguments: package);
  }

  Future<void> gotoDetail(Package package) async {
    await Get.toNamed(Routes.PACKAGE_DETAIL, arguments: package);
  }

  Future<void> cancelPackageDialog(Function() callback) async {
    await Dialogs.materialDialog(
        context: Get.context!,
        customView: _cancelWidget(),
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
            text: 'Hủy',
            iconData: Icons.check,
            color: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  Widget _cancelWidget() {
    return Container(
      padding: EdgeInsets.only(top: 40.h),
      height: 100.h,
      width: 220.w,
      child: TextField(
        onChanged: (value) {
          reason = value;
        },
        autofocus: true,
        decoration: InputStyles.reasonCancel(labelText: 'Lý do hủy'),
      ),
    );
  }
}
