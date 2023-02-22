import 'package:tien_duong/app/core/utils/camera_service.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/button_styles.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:tien_duong/app/modules/package/tabs/received_tab/received_package_controller.dart';
import 'package:tien_duong/app/modules/package/tabs/received_tab/received_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';

class ReceivedView extends GetView<ReceivedPackageController> {
  const ReceivedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(() => SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.onRefresh(),
        onLoading: () => controller.onLoading(),
        footer: CustomFooterSmartRefresh.defaultCustom(),
        child: ListView.separated(
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
              decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(6.w),
              boxShadow: ShadowStyles.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReceivedPackageItem(
                      package: controller.dataApis[index]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyles.primaryBlueSmall().copyWith(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.red[400])),
                        onPressed: () {
                          controller.reportPackage(
                              controller.dataApis[index].id!);
                        },
                        child: const Text('Hủy đơn')
                      ),
                      Gap(6.w),
                      ElevatedButton(
                        style: ButtonStyles.primaryBlueSmall(),
                        onPressed: () async {
                          if(await CameraService().scanQR() == controller.dataApis[index].id!) {
                            await controller.accountConfirmPackage(
                                controller.dataApis[index].id!);
                          } else {
                            if(await CameraService().getFromCamera() != null){
                              await controller.accountConfirmPackage(
                                  controller.dataApis[index].id!);
                            }
                          }
                        },
                        child: const Text('Xác nhận nhận hàng')
                      ),
                    ],
                  )
                ],
              )
            );
          },
          separatorBuilder: (_, index) => Gap(12.h),
          itemCount: controller.dataApis.length),
        )
      )
    );
  }
}
