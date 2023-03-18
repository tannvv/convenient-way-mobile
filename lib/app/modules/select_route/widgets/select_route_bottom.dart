import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/box_decorations.dart';
import 'package:tien_duong/app/core/values/button_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/hyper_button.dart';
import 'package:tien_duong/app/modules/select_route/controllers/select_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/modules/select_route/widgets/select_route_info.dart';

class Bottom extends GetWidget<SelectRouteController> {
  const Bottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
        child: Container(
          height: 400.h,
          decoration: BoxDecorations.map(),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: _header()),
              Expanded(flex: 6, child: _stepper()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: Text(
        'Tạo lộ trình',
        style: subtitle1.copyWith(
            fontWeight: FontWeight.bold, color: AppColors.softBlack),
      ),
    );
  }

  Widget _pickupButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 14.h, left: 60.w, right: 60.w),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyles.primaryMedium().copyWith(
            backgroundColor: MaterialStateProperty.all(AppColors.primary300),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r)))),
        onPressed: () {},
        child: HyperButton.childWhite(
          loadingText: 'Đang thực hiện...',
          status: false,
          child: Text(
            'Tạo lộ trình',
            style: buttonBold.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Container _actionStep(ControlsDetails details) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 18.h),
        child: controller.currentStep.value == 0
            ? Container(
                padding: EdgeInsets.only(bottom: 14.h, left: 60.w, right: 60.w),
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyles.primaryMedium().copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primary300),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r)))),
                  onPressed: details.onStepContinue,
                  child: Text(
                    'Tiếp tục',
                    style: buttonBold.copyWith(color: AppColors.white),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyles.primaryMedium().copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.gray),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r)))),
                    onPressed: details.onStepCancel,
                    child: Text(
                      'Quay lại',
                      style: buttonBold.copyWith(color: AppColors.softBlack),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyles.primaryMedium().copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary300),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r)))),
                    onPressed: () {
                      controller.createRoute();
                    },
                    child: Obx(
                      () => HyperButton.childWhite(
                        loadingText: 'Đang thực hiện',
                        status: controller.isLoading,
                        child: Text(
                          'Tạo lộ trình',
                          style: buttonBold.copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ));
  }

  Widget _stepper() {
    return Obx(
      () => CupertinoStepper(
          type: StepperType.horizontal,
          controlsBuilder: (_, details) {
            return _actionStep(details);
          },
          currentStep: controller.currentStep.value,
          onStepCancel: () => controller.previousStep(),
          onStepContinue: () => controller.nextStep(),
          steps: [
            Step(
                title: Text(
                  'Chiều đi',
                  style: caption,
                ),
                content: const SelectRouteInfo(),
                isActive: controller.currentStep.value == 0,
                state: controller.currentStep.value == 0
                    ? StepState.editing
                    : StepState.indexed),
            Step(
                title: Text(
                  'Chiều về',
                  style: caption,
                ),
                content: const SelectRouteInfo(),
                isActive: controller.currentStep.value == 1,
                state: controller.currentStep.value == 1
                    ? StepState.editing
                    : StepState.indexed),
          ]),
    );
  }
}
