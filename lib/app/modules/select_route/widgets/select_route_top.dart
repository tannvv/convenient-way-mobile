import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/modules/select_route/controllers/select_route_controller.dart';

class SelectRouteTop extends GetView<SelectRouteController> {
  const SelectRouteTop({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBackButton();
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 40.h,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.h,
          left: 20.w,
        ),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: AppColors.white,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(0),
                minimumSize: Size(34.r, 34.r),
              ),
              child: SizedBox(
                  height: 30.r,
                  width: 30.r,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18.r,
                    color: AppColors.primary400,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
