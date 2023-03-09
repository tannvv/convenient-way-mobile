import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/app_values.dart';
import 'package:tien_duong/app/core/values/box_decorations.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/location_package/controllers/location_package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Bottom extends GetWidget<LocationPackageController> {
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
          height: 300.h,
          decoration: BoxDecorations.map(),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _header()),
              Expanded(
                  flex: 16,
                  child: Obx(
                    () => ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemBuilder: (_, index) {
                        return Row(
                          children: [
                            Text(
                              '${index + 1}',
                              style: subtitle1.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.softBlack),
                            ),
                            Gap(8.w),
                            SvgPicture.asset(
                              controller.getAssetsWithType(
                                  controller.pointPackages[index].type!),
                              width: 20.h,
                              height: 20.h,
                            ),
                            Gap(8.w),
                            Expanded(
                                child: Text(
                                    controller.pointPackages[index].name ?? '',
                                    style: subtitle1.copyWith(
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColors
                                            .softBlack))), // 'Điểm đón')
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gap(8.h),
                      itemCount: controller.pointPackages.length,
                    ),
                  )),
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
        'Gợi ý thứ tự lộ trình',
        style: subtitle1.copyWith(
            fontWeight: FontWeight.bold, color: AppColors.softBlack),
      ),
    );
  }

  Container _goToCurrentLocation() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h, right: 20.w, left: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              controller.gotoCurrentLocation();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: AppColors.white,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.all(0),
              minimumSize: Size(40.r, 40.r),
            ),
            child: SizedBox(
              height: 40.r,
              width: 40.r,
              child: Icon(
                Icons.gps_fixed,
                size: 18.r,
                color: AppColors.gray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
