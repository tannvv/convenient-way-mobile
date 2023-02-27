import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/title_scroll_navigation.dart';
import 'package:tien_duong/app/core/values/app_animation_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/modules/sender_package/controllers/sender_package_controller.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class SenderPackageView extends GetView<SenderPackageController> {
  const SenderPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(flex: 1, child: _header()),
                Expanded(
                  flex: 11,
                  child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: TitleScrollNavigation(
                        identiferStyle: const NavigationIdentiferStyle(
                            color: AppColors.primary900),
                        showIdentifier: true,
                        barStyle: TitleNavigationBarStyle(
                          style: subtitle2.copyWith(
                              color: AppColors.primary800,
                              fontWeight: FontWeights.medium),
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 12),
                          spaceBetween: 40,
                          background: AppColors.white,
                        ),
                        titles: controller.tabsTitle,
                        pages: controller.screens,
                      )),
                )
              ],
            ),
          ),
          _btnCreate()
        ],
      )),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, top: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Các gói hàng của bạn',
            style: h6.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }

  // Widget _btnCreate() {
  //   return Positioned(
  //       bottom: 0.h,
  //       right: 0.w,
  //       child: ElevatedButton(
  //         onPressed: () {
  //           Get.toNamed(Routes.CREATE_PACKAGE_PAGE);
  //         },
  //         style: ButtonStyle(
  //             backgroundColor:
  //                 MaterialStateProperty.all(AppColors.purple.withOpacity(0.2)),
  //             shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(20.r),
  //                     bottomLeft: Radius.circular(20.r))))),
  //         child: Row(
  //           children: [
  //             Lottie.asset(AppAnimationAssets.createPackage,
  //                 height: 40.h, width: 40.w),
  //             const Text('Tạo gói hàng',
  //                 style: TextStyle(color: AppColors.white))
  //           ],
  //         ),
  //       ));
  // }
  Widget _btnCreate() {
    return Positioned(
        bottom: 0.h,
        right: 0.w,
        child: ColorButton('Thêm gói hàng',
            height: 40.h,
            backgroundColor: AppColors.primary900,
            textColor: AppColors.primary900,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r)),
            icon: Icons.folder, onPressed: () {
          Get.toNamed(Routes.CREATE_PACKAGE_PAGE);
        }));
  }
}
