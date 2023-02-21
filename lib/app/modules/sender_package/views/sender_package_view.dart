import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/title_scroll_navigation.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/modules/sender_package/controllers/sender_package_controller.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class SenderPackageView extends GetView<SenderPackageController> {
  const SenderPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
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
          ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(Routes.CREATE_PACKAGE_PAGE);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)))),
              icon: const Icon(Icons.create_new_folder_outlined, color: AppColors.primary900),
              label: const Text('Tạo gói hàng', style: TextStyle(color: AppColors.primary900)))
        ],
      ),
    );
  }
}
