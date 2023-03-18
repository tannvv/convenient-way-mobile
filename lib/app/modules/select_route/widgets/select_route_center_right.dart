import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/box_decorations.dart';
import 'package:tien_duong/app/modules/select_route/controllers/select_route_controller.dart';

class SelectRouteCenterRight extends GetWidget<SelectRouteController> {
  const SelectRouteCenterRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(10.w),
        child: controller.isLoadingFetchPolyline.value
            ? const CircularProgressIndicator()
            : Container(),
      ),
    );
  }
}
