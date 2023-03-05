import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/custom_body_scaffold.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/location_pickup.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/product_info.dart';

import '../controllers/create_package_page_controller.dart';
import '../widgets/receiver_info.dart';

class CreatePackagePageView extends GetView<CreatePackagePageController> {
  const CreatePackagePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomBodyScaffold(
        header: _header(),
        body: _stepper(),
      ),
    );
  }

  Widget _header() {
    return const HeaderScaffold(
      title: 'Tạo gói hàng',
      isBack: true,
    );
  }

  Widget _stepper() {
    return Obx(
      () => CupertinoStepper(
          controlsBuilder: (context, details) {
            return _actionStep(details);
          },
          type: StepperType.horizontal,
          currentStep: controller.currentStep,
          onStepCancel: () => controller.previousStep(),
          onStepContinue: () => controller.nextStep(),
          steps: [
            Step(
                title: Text(
                  'Địa\nđiểm lấy\nhàng',
                  style: caption,
                ),
                content: const LocationPickup(),
                isActive: controller.currentStep > 0,
                state: controller.currentStep == 0
                    ? StepState.editing
                    : StepState.indexed),
            Step(
                title: Text(
                  'Thông tin\nngười\nnhận',
                  style: caption,
                ),
                content: const ReceivedInfo(),
                isActive: controller.currentStep > 1,
                state: controller.currentStep == 1
                    ? StepState.editing
                    : StepState.indexed),
            Step(
                title: Text(
                  'Thông tin\ncác sản\nphẩm',
                  style: caption,
                ),
                content: const ProductInfo(),
                isActive: controller.currentStep > 2,
                state: controller.currentStep == 2
                    ? StepState.editing
                    : StepState.indexed),
          ]),
    );
  }

  Container _actionStep(ControlsDetails details) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Obx(() => controller.currentStep > 0
              ? ElevatedButton.icon(
                  onPressed: details.onStepCancel,
                  label: const Text('Quay lại',
                      style: TextStyle(color: Colors.black54)),
                  icon: const Icon(Icons.next_plan, color: Colors.black54),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.black12)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                  ),
                )
              : const SizedBox()),
          Gap(8.w),
          Obx(() => controller.currentStep != controller.maxStep
              ? ElevatedButton.icon(
                  onPressed: details.onStepContinue,
                  label: const Text('Tiếp tục',
                      style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.next_plan, color: Colors.white),
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.green),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: () {
                    controller.submit();
                  },
                  label: const Text('Hoàn thành',
                      style: TextStyle(color: Colors.white)),
                  icon: const Icon(Icons.check, color: Colors.white),
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.green),
                  ),
                )),
        ],
      ),
    );
  }
}
