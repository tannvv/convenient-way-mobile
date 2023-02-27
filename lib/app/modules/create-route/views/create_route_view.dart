import 'package:tien_duong/app/core/values/app_animation_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/button_styles.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/custom_body_scaffold.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/core/widgets/hyper_button.dart';
import 'package:tien_duong/app/modules/create-route/controllers/create_route_controller.dart';
import 'package:tien_duong/app/modules/create-route/widgets/route_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CreateRouteView extends GetView<CreateRouteController> {
  const CreateRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBodyScaffold(
        header: _header(),
        body: _body(),
      ),
    );
  }

  Widget _header() {
    return const HeaderScaffold(title: 'Tạo lộ trình đầu tiên!', isBack: true);
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: ShadowStyles.map,
            ),
            child: Lottie.asset(
              AppAnimationAssets.inputMap,
              width: 100.w,
              height: 100.h,
            ),
          ),
        ),
        Container(
            width: 300.w,
            height: 340.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: ShadowStyles.map,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Form(
              key: controller.formKey,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RouteInfo(),
                      SizedBox(
                        height: 40.h,
                      ),
                      saveRouteButton(),
                    ],
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget saveRouteButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyles.primaryMedium().copyWith(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 8.h),
            ),
            backgroundColor: MaterialStateProperty.all(AppColors.blue),
          ),
          onPressed: () async {
            controller.formKey.currentState!.save();
            bool validateForm = controller.formKey.currentState!.validate();
            if (validateForm) {
              await controller.registerRoute();
            }
          },
          child: HyperButton.childWhite(
            status: controller.isLoading,
            loadingText: 'Đang lưu...',
            child: Text(
              'Lưu lộ trình',
              style: buttonBold.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
