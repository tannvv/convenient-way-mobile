import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
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
          currentStep: controller.currentStep,
          onStepTapped: (step) => controller.changeStep(step),
          onStepCancel: () => controller.previousStep(),
          onStepContinue: () => controller.nextStep(),
          steps: [
            Step(
              title: const Text('Chọn địa điểm lấy hàng'),
              content: const LocationPickup(),
              isActive: controller.currentStep > 0,
            ),
            Step(
              title: const Text('Thêm thông tin người nhận'),
              content: const ReceivedInfo(),
              isActive: controller.currentStep > 1,
            ),
            Step(
              title: const Text('Thông tin các sản phẩm'),
              content: const ProductInfo(),
              isActive: controller.currentStep > 2,
            ),
          ]),
    );
  }

  Row _actionStep(ControlsDetails details) {
    return Row(
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
                      const BorderSide(color: Colors.black38)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                ),
              )
            : const SizedBox()),
        Gap(8.w),
        Obx(() => controller.currentStep != controller.maxStep
            ? ElevatedButton.icon(
                onPressed: details.onStepContinue,
                label: const Text('Tiếp tục',
                    style: TextStyle(color: Colors.green)),
                icon: const Icon(Icons.next_plan, color: Colors.green),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(
                      color: Color.fromARGB(255, 129, 207, 131))),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                ),
              )
            : ElevatedButton.icon(
                onPressed: () {
                  controller.submit();
                },
                label: const Text('Hoàn thành',
                    style: TextStyle(color: Colors.green)),
                icon: const Icon(Icons.next_plan, color: Colors.green),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(
                      color: Color.fromARGB(255, 129, 207, 131))),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                ),
              )),
      ],
    );
  }
}
